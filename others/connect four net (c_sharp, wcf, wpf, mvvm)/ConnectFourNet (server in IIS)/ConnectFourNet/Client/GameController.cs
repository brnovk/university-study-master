using System;
using System.ServiceModel;
using System.Threading;
using System.Timers;
using System.Windows;
using ConnectNNet.Client.Models;
using ConnectNNet.Client.WcfServer;
using ConnectNNet.GameCore.Models.Players;
using Point = System.Drawing.Point;
using Timer = System.Timers.Timer;

namespace ConnectNNet.Client
{
	public class GameController : GameCore.GameLogic
	{
		#region Поля

        private bool _isInetGame;
        private ServerClient _server;
        private Timer _stateScanner;
        private Guid _playerId;
        private Guid _gameId;

        #endregion

		#region События

		public delegate void SampleEventHandler(object sender);
		public event SampleEventHandler OnGameDataUpdated;
		public event SampleEventHandler OnGameStarted;
		public event SampleEventHandler OnGameStopped;
		public event SampleEventHandler OnRebuildBoard;
		public event SampleEventHandler OnUpdateBoard;

		#endregion

		#region Конструкторы

		public GameController(ISettingsModel settings)
			: base()
		{
			Settings = settings;
			Board.Rows = settings.Rows;
			Board.Columns = settings.Columns;
			VinCount = settings.VinCount;
			Player.Login = settings.Login;
			Player.Score = Settings.PlayerVsBotScore;
			Enemy = new EnemyBot();
			Enemy.Score = Settings.BotScore;
			PlayerSide = settings.Side;
			IsInetGame = Settings.IsInetGame;
			LocaleGameCopy = null;
			_stateScanner = new Timer();
			_stateScanner.Interval = 500;
			_stateScanner.Elapsed += GetGameState;
			_playerId = Guid.NewGuid();
			GameOver = false;
			ItsNotOver = false;
		}

		#endregion

		#region Свойства

        public ServerClient Server
        {
            get
            {
                if (_server == null || _server.State == CommunicationState.Faulted || _server.State == CommunicationState.Closed)
                {
                    _server = new ServerClient();
                    _server.Endpoint.Address = new EndpointAddress(Settings.ServerAdress);
                }
                return _server;
            }
        }

		public bool IsStopped
		{
			get { return !ItsNotOver; }
		}

		public bool GameOver { get; set; }
		public bool ItsNotOver { get; set; }
		
		private GameCore.GameLogic LocaleGameCopy { get; set; }

		public ISettingsModel Settings { get; set; }

		public bool IsInetGame
		{
			get { return _isInetGame; }
			set
			{
				_isInetGame = value;
				if (value)
				{
					if (Enemy is EnemyBot)
					{
						Settings.BotScore = Enemy.Score;
						if (Player != null)
						{
							Settings.PlayerVsBotScore = Player.Score;
							Player.Score = 0;
						}
					}
					Enemy = new Player(Enemy);
				}
				else
				{
					Enemy = new EnemyBot(Enemy);
					Enemy.Score = Settings.BotScore;
					if (Player != null)
					{
						Player.Score = Settings.PlayerVsBotScore;
					}
				}
				if (OnGameDataUpdated != null)
					OnGameDataUpdated.Invoke(this);
			}
		}

		#endregion

		#region Методы

		public void SaveSettings()
		{
			if (Enemy is EnemyBot)
			{
				Settings.PlayerVsBotScore = Player.Score;
				Settings.BotScore = Enemy.Score;
			}
			Settings.Columns = Board.Columns;
			Settings.Rows = Board.Rows;
			Settings.VinCount = VinCount;
			Settings.Login = Player.Login;
			Settings.Side = PlayerSide;
			Settings.ServerAdress = Server.Endpoint.Address.ToString();
			Settings.IsInetGame = IsInetGame;
			Settings.Save();
		}

		public override void Stop(bool isReset = false)
		{
			if (IsInetGame)
			{
				_stateScanner.Stop();
				Thread.Sleep(501);
				Enemy.Login = "...";
				Enemy.Score = 0;
				Player.Score = 0;
				InProcess = false;
				try
				{
					Server.Stop(_gameId, _playerId);
					Server.Close();
				}
				catch (Exception)
				{
					//
				}
				_gameId = Guid.NewGuid();
				if (LocaleGameCopy != null)
				{
					LocaleGameCopy.CopyTo(this);
					LocaleGameCopy = null;
				}
				isReset = false;
			}

			base.Stop(isReset);
			ItsNotOver = false;
			GameOver = false;
			if (OnGameStopped != null)
				OnGameStopped(this);
		}

		public override bool Turn(Point cellPos)
		{

			if (IsInetGame)
			{
				try
				{
					if (Server.Turn(_gameId, _playerId, cellPos))
					{
						if (OnGameDataUpdated != null)
							OnGameDataUpdated.Invoke(this);
						return true;
					}
					return false;
				}
				catch (Exception e)
				{
					Stop();
					MessageBox.Show(e.Message, "Ошибка соединения с сервером!", MessageBoxButton.OK, MessageBoxImage.Error);
				}
			}
			if (base.Turn(cellPos))
			{
				if (VinCells!=null || Board.EmptyCells == 0)
					GameOver = true;
				if (OnGameDataUpdated != null)
					OnGameDataUpdated.Invoke(this);
				if (OnUpdateBoard != null)
					OnUpdateBoard.Invoke(this);
				return true;
			}
			return false;
		}

		public override void BotTurn()
		{
			base.BotTurn();
			if (VinCells != null || Board.EmptyCells == 0)
				GameOver = true;
			if (OnGameDataUpdated != null)
				OnGameDataUpdated.Invoke(this);
			if (OnUpdateBoard != null)
				OnUpdateBoard.Invoke(this);
		}

		public override void Start()
		{
			GameOver = false;
			ItsNotOver = true;
			if (OnRebuildBoard != null)
				OnRebuildBoard.Invoke(this);
			if (IsInetGame)
			{
				try
				{
					GameSession currentGame = new GameSession
					{
						CreatorId = _playerId,
						GameInstance = new GameCore.GameLogic(this)
					};

					_gameId = Server.Start(currentGame);
					Enemy.Login = "...";

					InProcess = true;
					if (OnGameStarted != null)
						OnGameStarted(this);
					if (OnRebuildBoard != null)
						OnRebuildBoard.Invoke(this);
					_stateScanner.Start();
				}
				catch (Exception e)
				{
					Stop();
					MessageBox.Show(e.Message, "Ошибка соединения с сервером!", MessageBoxButton.OK, MessageBoxImage.Error);
				}
			}
			else
			{
				base.Start();
				if (OnGameStarted != null)
					OnGameStarted(this);
			}
		}

		private void GetGameState(object sender, ElapsedEventArgs e)
		{
			_stateScanner.Stop();
			try
			{
				GameSession serverGame;
				GameState state = Server.GetState(_gameId, _playerId);
				switch (state)
				{
					case GameState.Started:
						serverGame = Server.GetGameSession(_gameId, _playerId);
						if (serverGame == null)
						{
							Stop();
							return;
						}
						if (serverGame.CreatorId != _playerId)
						{
							LocaleGameCopy = new GameCore.GameLogic(this);
						}
						serverGame.GameInstance.CopyTo(this);
						Board.Rebuild();
						InProcess = false;
						InProcess = true;
						if (OnRebuildBoard != null)
							OnRebuildBoard.Invoke(this);
						break;
					case GameState.PlayerATurn:
						IsPlayerTurn = true;
						serverGame = Server.GetGameSession(_gameId, _playerId);
						if (serverGame == null)
						{
							Abort();
							return;
						}
						serverGame.GameInstance.CopyTo(this);
						PlayerTurn = null;
						if (OnUpdateBoard!=null)
							OnUpdateBoard.Invoke(this);
						if (OnGameDataUpdated != null)
							OnGameDataUpdated.Invoke(this);
						break;
					case GameState.PlayerBTurn:
						IsEnemyTurn = true;
						serverGame = Server.GetGameSession(_gameId, _playerId);
						if (serverGame == null)
						{
							Abort();
							return;
						}
						serverGame.GameInstance.CopyTo(this);
						EnemyTurn = null;
						if (OnUpdateBoard != null)
							OnUpdateBoard.Invoke(this);
						if (OnGameDataUpdated != null)
							OnGameDataUpdated.Invoke(this);
						break;
					case GameState.Tie:
						serverGame = Server.GetGameSession(_gameId, _playerId);
						if (serverGame == null)
						{
							Abort();
							return;
						}
						serverGame.GameInstance.CopyTo(this);
						EnemyTurn = null;
						PlayerTurn = null;
						GameOver = true;
						InProcess = false;
						Board.EmptyCells = 0;
						if (OnUpdateBoard != null)
							OnUpdateBoard.Invoke(this);
						if (OnGameDataUpdated != null)
							OnGameDataUpdated.Invoke(this);				
						break;
					case GameState.PlayerAVin:
						serverGame = Server.GetGameSession(_gameId, _playerId);
						if (serverGame == null)
						{
							Abort();
							return;
						}
						serverGame.GameInstance.CopyTo(this);
						EnemyTurn = null;
						GameOver = true;
						InProcess = false;
						if (OnUpdateBoard != null)
							OnUpdateBoard.Invoke(this);
						if (OnGameDataUpdated != null)
							OnGameDataUpdated.Invoke(this);
						break;
					case GameState.PlayerBVin:
						serverGame = Server.GetGameSession(_gameId, _playerId);
						if (serverGame == null)
						{
							Abort();
							return;
						}
						serverGame.GameInstance.CopyTo(this);
						PlayerTurn = null;
						GameOver = true;
						InProcess = false;
						if (OnUpdateBoard != null)
							OnUpdateBoard.Invoke(this);
						if (OnGameDataUpdated != null)
							OnGameDataUpdated.Invoke(this);
						break;
					case GameState.Closed:
						Abort();
						break;
				}
				if (state!= GameState.Closed)
					_stateScanner.Start();
			}
			catch (Exception er)
			{
				MessageBox.Show(er.Message, "Ошибка соединения с сервером!", MessageBoxButton.OK, MessageBoxImage.Error);
			}
		}

		private void Abort()
		{
			if (InProcess)
			{
				MessageBox.Show("Другой игрок прервал игру.", "Игра окончена!", MessageBoxButton.OK, MessageBoxImage.Stop);
			}
			Stop();
		}

        public new void ReStart()
        {
            GameOver = false;
            ItsNotOver = true;
            InProcess = true;
            if (IsInetGame)
            {
                try
                {
                    Server.ReStart(_gameId, _playerId);
                    InProcess = true;
                    if (OnGameStarted != null)
                        OnGameStarted(this);
                    if (OnRebuildBoard != null)
                        OnRebuildBoard.Invoke(this);
                    _stateScanner.Start();
                }
                catch (Exception e)
                {
                    Stop();
                    MessageBox.Show(e.Message, "Ошибка соединения с сервером!", MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }
            else
            {
                base.ReStart();
                Start();
            }
        }
		#endregion
	}
}
