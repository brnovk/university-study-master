using ConnectNNet.GameCore.Models;

namespace ConnectNNet.Client.Models
{
	/// <summary>
	/// A class that just encapsulates the application settings.
	/// </summary>
	internal class SettingsModel : ISettingsModel
	{
		#region Constructors

		/// <summary>
		/// Initializes a new instance of the <see cref="SettingsModel" /> class.
		/// </summary>
		public SettingsModel()
		{
			Load();
		}

		#endregion

		#region Fields

		private int _windowLeft;
		private int _windowTop;
		private int _windowHeight;
		private int _windowWidth;
		private bool _windowMax;
		private string _serverIp;
		private int _serverPort;
		private bool _isInetGame;
		private int _botScore;
		private int _playerVsBotScore;

		private string _login;
		private int _rows;
		private int _columns;
		private int _vinCount;
		private GameBoard.GameSide _side;


		#endregion

		#region Properties

		#region Window properties

		/// <summary>
		/// Shift position of window from left.
		/// </summary>
		public int WindowLeft
		{
			get { return _windowLeft; }
			set
			{
				if (_windowLeft == value)
					return;
				_windowLeft = value;
				Modified = true;
			}
		}

		/// <summary>
		/// Shift position of window from top.
		/// </summary>
		public int WindowTop
		{
			get { return _windowTop; }
			set
			{
				if (_windowTop == value)
					return;
				_windowTop = value;
				Modified = true;
			}
		}

		/// <summary>
		/// Window hieght.
		/// </summary>
		public int WindowHeight
		{
			get { return _windowHeight; }
			set
			{
				if (_windowHeight == value)
					return;
				_windowHeight = value;
				Modified = true;
			}
		}

		/// <summary>
		/// Window width.
		/// </summary>
		public int WindowWidth
		{
			get { return _windowWidth; }
			set
			{
				if (_windowWidth == value)
					return;
				_windowWidth = value;
				Modified = true;
			}
		}

		/// <summary>
		/// Whether is the window in state Maximized.
		/// </summary>
		public bool WindowMax
		{
			get { return _windowMax; }
			set
			{
				if (_windowMax == value)
					return;
				_windowMax = value;
				Modified = true;
			}
		}

		#endregion

		public string Login
		{
			get
			{
				return _login;
			}
			set
			{
				if (_login == value)
					return;
				_login = value;
				Modified = true;
			}
		}

		public int Rows
		{
			get { return _rows; }
			set
			{
				if (_rows == value)
					return;
				_rows = value;
				Modified = true;
			}
		}

		public int Columns
		{
			get { return _columns; }
			set
			{
				if (_columns == value)
					return;
				_columns = value;
				Modified = true;
			}
		}

		public int VinCount
		{
			get { return _vinCount; }
			set
			{
				if (_vinCount == value)
					return;
				_vinCount = value;
				Modified = true;
			}
		}


		public GameBoard.GameSide Side
		{
			get { return _side; }
			set
			{
				if (_side == value)
					return;
				_side = value;
				Modified = true;
			}
		}

		public bool IsInetGame
		{
			get { return _isInetGame; }
			set
			{
				if (_isInetGame == value)
					return;
				_isInetGame = value;
				Modified = true;
			}
		}

		public int BotScore
		{
			get { return _botScore; }
			set
			{
				if (_botScore == value)
					return;
				_botScore = value;
				Modified = true;
			}
		}

		public int PlayerVsBotScore
		{
			get { return _playerVsBotScore; }
			set
			{
				if (_playerVsBotScore == value)
					return;
				_playerVsBotScore = value;
				Modified = true;
			}
		}

		#region Настройки сервера

		public string ServerAdress
		{
			get { return _serverIp; }
			set
			{
				if (_serverIp == value)
					return;
				_serverIp = value;
				Modified = true;
			}
		}

		public int ServerPort
		{
			get { return _serverPort; }
			set
			{
				if (_serverPort == value)
					return;
				_serverPort = value;
				Modified = true;
			}
		}

		#endregion

		/// <summary>
		/// Returns whether the settings have been modified.
		/// </summary>
		/// <value>
		///   <c>true</c> if modified; otherwise, <c>false</c>.
		/// </value>
		public bool Modified { get; private set; }

		#endregion

		#region Methods

		/// <summary>
		/// Actually update and save the application settings.
		/// </summary>
		private void SaveSettings()
		{
			Properties.Settings.Default.WindowLeft = WindowLeft;
			Properties.Settings.Default.WindowTop = WindowTop;
			Properties.Settings.Default.WindowWidth = WindowWidth;
			Properties.Settings.Default.WindowHeight = WindowHeight;
			Properties.Settings.Default.WindowMax = WindowMax;

			Properties.Settings.Default.Login = Login;
			Properties.Settings.Default.Rows = Rows;
			Properties.Settings.Default.Columns = Columns;
			Properties.Settings.Default.VinCount = VinCount;
			Properties.Settings.Default.Side = (int)Side;

			Properties.Settings.Default.IsInetGame = IsInetGame;
			Properties.Settings.Default.PlayerVSBotScore = PlayerVsBotScore;
			Properties.Settings.Default.BotScore = BotScore;

			Properties.Settings.Default.ServerAdress = ServerAdress;

			Properties.Settings.Default.Save();
			Modified = false;
		}

		/// <summary>
		/// Load the application settings into the class.
		/// </summary>
		public void Load()
		{
			WindowLeft = Properties.Settings.Default.WindowLeft;
			WindowTop = Properties.Settings.Default.WindowTop;
			WindowWidth = Properties.Settings.Default.WindowWidth;
			WindowHeight = Properties.Settings.Default.WindowHeight;
			WindowMax = Properties.Settings.Default.WindowMax;

			Login = Properties.Settings.Default.Login;
			Rows = Properties.Settings.Default.Rows;
			Columns = Properties.Settings.Default.Columns;
			VinCount = Properties.Settings.Default.VinCount;
			Side = (GameBoard.GameSide)Properties.Settings.Default.Side;

			IsInetGame = Properties.Settings.Default.IsInetGame;
			PlayerVsBotScore = Properties.Settings.Default.PlayerVSBotScore;
			BotScore = Properties.Settings.Default.BotScore;

			ServerAdress = Properties.Settings.Default.ServerAdress;

			Modified = false;
		}

		/// <summary>
		/// Save the settings if they have been modified, otherwise do nothing.
		/// </summary>
		public void Save()
		{
			if (!Modified)
				return;
			SaveSettings();
		}

		#endregion
	}
}
