using System;
using System.Collections.Generic;
using System.Drawing;
using System.Threading;
using ConnectNNet.GameCore.Models;
using ConnectNNet.GameCore.Models.Players;

namespace ConnectNNet.GameCore
{
	public class GameLogic
	{
		#region Поля

		private bool _inProcess;
		private bool _isPlayerTurn;
		private bool _isEnemyTurn;
		static readonly Random Rd = new Random();

		#endregion

		#region Свойства

		public int VinCount { get; set; }
		public Player Player { get; set; }
		public Player Enemy { get; set; }
		public GameBoard Board { get; set; }
		public List<Point> VinCells { get; set; }        // выигрышная комбинация клеток (для подсвечивания при победе)
		public GameBoard.GameSide VinSide { get; set; } // сторона победителя (указывается в случае победы одной из сторон)

		public bool InProcess
		{
			get { return _inProcess; }
			set
			{
				_inProcess = value;
				if (!value)
				{
					_isPlayerTurn = false;
					_isEnemyTurn = false;
				}
			}
		}

		public GameBoard.GameSide PlayerSide
		{
			get { return Player.Side; }
			set
			{
				Player.Side = value;
				if (Enemy != null)
					switch (value)
					{
						case GameBoard.GameSide.Cross:
							Enemy.Side = GameBoard.GameSide.Zero;
							break;
						case GameBoard.GameSide.Zero:
							Enemy.Side = GameBoard.GameSide.Cross;
							break;
					}
			}
		}

		public GameBoard.GameSide EnemySide
		{
			get { return Enemy.Side; }
			set
			{
				Enemy.Side = value;
				switch (value)
				{
					case GameBoard.GameSide.Cross:
						Player.Side = GameBoard.GameSide.Zero;
						break;
					case GameBoard.GameSide.Zero:
						Player.Side = GameBoard.GameSide.Cross;
						break;
				}
			}
		}

		public bool IsPlayerTurn
		{
			get { return _isPlayerTurn; }
			set
			{
				_isPlayerTurn = value;
				_isEnemyTurn = !value;
			}
		}

		public bool IsEnemyTurn
		{
			get { return _isEnemyTurn; }
			set
			{
				_isEnemyTurn = value;
				_isPlayerTurn = !value;
			}
		}

		public Point? EnemyTurn { get; set; }  // координаты последнего хода соперника (для отрисовки)
		public Point? PlayerTurn { get; set; }

		#endregion

		#region Конструкторы

		public GameLogic()
		{
			VinCount = 0;
			Board = new GameBoard();
			Player = new Player();
			Enemy = new EnemyBot();
			PlayerSide = Player.Side;
			InProcess = false;
			_isPlayerTurn = false;
			_isEnemyTurn = false;
		}

		/// <summary>
		/// Конструктор копирования.
		/// </summary>
		/// <param name="source">Источник.</param>
		public GameLogic(GameLogic source)
		{
			EnemyTurn = source.EnemyTurn;
			PlayerTurn = source.PlayerTurn;
			VinCells = source.VinCells;
			VinSide = source.VinSide;
			VinCount = source.VinCount;
			Board = source.Board;
			Player = source.Player;
			Enemy = source.Enemy;
			PlayerSide = source.PlayerSide;
			InProcess = source.InProcess;
			_isPlayerTurn = source._isPlayerTurn;
			_isEnemyTurn = source.IsEnemyTurn;
		}

		#endregion

		#region Методы

		public virtual void Start()
		{
			// определение стороны первого хода
			if (Player.Score == Enemy.Score)        
			{
				IsPlayerTurn = Rd.Next(2) == 1;    
			}
			else
			{
				IsPlayerTurn = Player.Score < Enemy.Score;
			}
			
			Board.Rebuild();
			InProcess = true;
			if (IsEnemyTurn && Enemy is EnemyBot)
				BotTurn();
		}

		public virtual void Stop(bool isReset = false)
		{
			if (isReset)
				Player.Score--;
			InProcess = false;
			_isPlayerTurn = false;
			_isEnemyTurn = false;
		}

		#endregion

		#region Обработчики ходов при локальной игре с ботом

		public virtual bool Turn(Point cellPos)
		{
			Point? newPos = GetDownPos(cellPos);
			if (newPos == null)
				return false;
			cellPos = newPos.Value;
			if (IsPlayerTurn && Board.CheckFreeCell(cellPos))
			{
				IsEnemyTurn = true;
				Board.SetCellState(cellPos, PlayerSide);
				CheckVinState(cellPos);
				PlayerTurn = cellPos;
				if (InProcess)
				{
					Thread tr = new Thread(BotTurn);
					tr.Start();
				}
				return true;
			}
			return false;
		}



		public virtual void BotTurn()
		{
			Thread.Sleep(650);
			Point cellPos = EnemyBot.GetStep(Board, VinCount, Enemy.Side);
			Point? newPos = GetDownPos(cellPos);
			if (newPos == null)
				return;
			cellPos = newPos.Value;
			if (IsEnemyTurn && Board.CheckFreeCell(cellPos))
			{
				IsPlayerTurn = true;
				Board.SetCellState(cellPos, Enemy.Side);
				CheckVinState(cellPos);
				EnemyTurn = cellPos;
			}
		}

		#endregion

		#region бработчики ходов при сетевой игре

		public bool PlayerATurn(Point cellPos)
		{
			Point? newPos = GetDownPos(cellPos);
			if (newPos == null)
				return false;
			cellPos = newPos.Value;
			if (IsPlayerTurn && Board.CheckFreeCell(cellPos))
			{
				Board.SetCellState(cellPos, PlayerSide);
				CheckVinState(cellPos);
				IsEnemyTurn = true;
				PlayerTurn = cellPos;
				return true;
			}
			return false;
		}

		public bool PlayerBTurn(Point cellPos)
		{
			Point? newPos = GetDownPos(cellPos);
			if (newPos == null)
				return false;
			cellPos = newPos.Value;
			if (IsEnemyTurn && Board.CheckFreeCell(cellPos))
			{
				Board.SetCellState(cellPos, EnemySide);
				CheckVinState(cellPos);
				IsPlayerTurn = true;
				EnemyTurn = cellPos;
				return true;
			}
			return false;
		}

		#endregion


		private void CheckVinState(Point cellPos)
		{
			VinCells = Board.GetVinState(cellPos, VinCount);
			if (VinCells != null)            // если игра окончена
			{
				if (VinCells.Count > 0)        // если это не ничья
				{
					if (Board.GetCellState(cellPos) == PlayerSide)
					{
						Player.Score += VinCells.Count - VinCount + 1;
						VinSide = PlayerSide;
					}
					else
					{
						Enemy.Score += VinCells.Count - VinCount + 1;
						VinSide = Enemy.Side;
					}
				}
				Stop();
			}
		}

		public void CopyTo(GameLogic destination)
		{
			if (destination == null)
				return;
			destination.VinCount = VinCount;
			destination.Board = Board;
			destination.Player = Player;
			destination.Enemy = Enemy;
			destination.VinCells = VinCells;
			destination.VinSide = VinSide;
			destination.PlayerSide = PlayerSide;
			destination.InProcess = InProcess;
			destination.EnemyTurn = EnemyTurn;
			destination.PlayerTurn = PlayerTurn;

			destination._isPlayerTurn = _isPlayerTurn;
			destination._isEnemyTurn = IsEnemyTurn;
			Board.Rebuild();
		}
		/// <summary>
		/// Сброс игрового состояния для новой игры с тем же соперником.
		/// </summary>
		public void ReStart()
		{
			VinCells = null;
			_isPlayerTurn = false;
			_isEnemyTurn = false;
			EnemyTurn = null;
			PlayerTurn = null;
			Board.Rebuild();
		}

		/// <summary>
		/// Получение свободной нижней клетки столбца.
		/// </summary>
		/// <param name="cellPos">The cell position.</param>
		/// <returns></returns>
		public Point? GetDownPos(Point cellPos)
		{
			if (cellPos.Y < Board.Rows || cellPos.X < Board.Columns)
				for (int i = Board.Rows - 1; i >= 0; i--)
				{
					if (Board.GetCellState(cellPos.X, i) == GameBoard.GameSide.Empty)
						return new Point(cellPos.X, i);
				}
			return null;
		}

	}
}
