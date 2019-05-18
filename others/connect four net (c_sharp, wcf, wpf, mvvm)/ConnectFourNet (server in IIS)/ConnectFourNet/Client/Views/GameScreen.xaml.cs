using System;
using System.Threading;
using System.Timers;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;
using ConnectNNet.Client.MVVM;
using ConnectNNet.GameCore.Models;
using TicTacToeNet.Views.Controlls;
using Point = System.Drawing.Point;
using Timer = System.Timers.Timer;

namespace ConnectNNet.Client.Views
{
	/// <summary>
	/// Interaction logic for GameScreen.xaml
	/// </summary>
	public partial class GameScreen : UserControl
	{

		#region Конструкторы

		public GameScreen()
		{
			InitializeComponent();
			RBFlag.IsVisibleChanged += ResetBoard;
			UPFlag.IsVisibleChanged += UpdateBoard;
			UPFlag.IsVisibleChanged += Turn;
			_traceDrawerA = new Timer();
			_traceDrawerA.Interval = 30;
			_traceDrawerA.Elapsed += DrawTraceA;
			_traceDrawerB = new Timer();
			_traceDrawerB.Interval = 30;
			_traceDrawerB.Elapsed += DrawTraceB;
		}

		static GameScreen()
		{

		}

		#endregion

		#region Поля

		public static Point? PrewDrawCellA = null;
		public static Point? PrewDrawCellB = null;
		private readonly Timer _traceDrawerA;
		private readonly Timer _traceDrawerB;

		#endregion

		#region Методы

		private void DrawTraceA(object sender, ElapsedEventArgs e)
		{
			_traceDrawerA.Stop();
			if (PrewDrawCellA == null)
				return;
			Point? downPos = ViewModelLocator.Game.Logic.PlayerTurn;
			if (downPos != null && PrewDrawCellA.Value.Y <= downPos.Value.Y)
			{
				Dispatcher.Invoke((ThreadStart)delegate
				{
					lock (Board)
					{
						BoardCell cell = ((BoardCell)Board.Children[PrewDrawCellA.Value.X + PrewDrawCellA.Value.Y * Board.Columns]);

						if (ViewModelLocator.Game.Logic.VinCells != null &&
								ViewModelLocator.Game.Logic.VinSide == ViewModelLocator.Game.Logic.PlayerSide)
							cell.ImageBoardCell.Source = GetTurnVinImage(ViewModelLocator.Game.Logic.PlayerSide);
						else
							cell.ImageBoardCell.Source = GetTurnImage(ViewModelLocator.Game.Logic.PlayerSide);
					}
				});
				PrewDrawCellA = new Point(PrewDrawCellA.Value.X, PrewDrawCellA.Value.Y + 1);
				if (PrewDrawCellA.Value.Y - 2 > -1)
					Dispatcher.Invoke((ThreadStart)delegate
					{
						lock (Board)
						{
							BoardCell cell = ((BoardCell)Board.Children[PrewDrawCellA.Value.X + (PrewDrawCellA.Value.Y - 2) * Board.Columns]);
							cell.ImageBoardCell.Source = (ImageSource)cell.ImageBoardCell.FindResource("Untouched");
						}
					});

				_traceDrawerA.Start();
			}
			else
			{
				if (ViewModelLocator.Game.Logic.PlayerTurn.Value.Y - 1 > -1)
					Dispatcher.Invoke((ThreadStart)delegate
					{
						lock (Board)
						{
							BoardCell cell = ((BoardCell)Board.Children[ViewModelLocator.Game.Logic.PlayerTurn.Value.X +
								(ViewModelLocator.Game.Logic.PlayerTurn.Value.Y - 1) * Board.Columns]);
							cell.ImageBoardCell.Source = (ImageSource)cell.ImageBoardCell.FindResource("Untouched");
						}
					});
				lock (Board)
				{
					Dispatcher.Invoke((ThreadStart)delegate
					{
						BoardCell cell = ((BoardCell)Board.Children[ViewModelLocator.Game.Logic.PlayerTurn.Value.X +
																												 ViewModelLocator.Game.Logic.PlayerTurn.Value.Y * Board.Columns]);

						if (ViewModelLocator.Game.Logic.VinCells != null &&
								ViewModelLocator.Game.Logic.VinSide == ViewModelLocator.Game.Logic.PlayerSide)
							cell.ImageBoardCell.Source = GetTurnVinImage(ViewModelLocator.Game.Logic.PlayerSide);
						else
							cell.ImageBoardCell.Source = GetTurnImage(ViewModelLocator.Game.Logic.PlayerSide);
					});
				}
				PrewDrawCellA = null;
				ViewModelLocator.Game.Logic.PlayerTurn = null;
			}
		}

		private void DrawTraceB(object sender, ElapsedEventArgs e)
		{
			_traceDrawerB.Stop();
			if (PrewDrawCellB == null)
				return;
			Point? downPos = ViewModelLocator.Game.Logic.EnemyTurn;
			if (downPos != null && PrewDrawCellB.Value.Y <= downPos.Value.Y)
			{
				Dispatcher.Invoke((ThreadStart)delegate
				{
					lock (Board)
					{
						BoardCell cell = ((BoardCell)Board.Children[PrewDrawCellB.Value.X + PrewDrawCellB.Value.Y * Board.Columns]);

						if (ViewModelLocator.Game.Logic.VinCells != null &&
								ViewModelLocator.Game.Logic.VinSide == ViewModelLocator.Game.Logic.EnemySide)
							cell.ImageBoardCell.Source = GetTurnVinImage(ViewModelLocator.Game.Logic.EnemySide);
						else
							cell.ImageBoardCell.Source = GetTurnImage(ViewModelLocator.Game.Logic.EnemySide);
					}
				});
				PrewDrawCellB = new Point(PrewDrawCellB.Value.X, PrewDrawCellB.Value.Y + 1);
				if (PrewDrawCellB.Value.Y - 2 > -1)
					Dispatcher.Invoke((ThreadStart)delegate
					{
						lock (Board)
						{
							BoardCell cell = ((BoardCell)Board.Children[PrewDrawCellB.Value.X + (PrewDrawCellB.Value.Y - 2) * Board.Columns]);
							cell.ImageBoardCell.Source = (ImageSource)cell.ImageBoardCell.FindResource("Untouched");
						}
					});

				_traceDrawerB.Start();
			}
			else
			{
				if (ViewModelLocator.Game.Logic.EnemyTurn.Value.Y - 1 > -1)
					Dispatcher.Invoke((ThreadStart)delegate
					{
						lock (Board)
						{
							BoardCell cell = ((BoardCell)Board.Children[ViewModelLocator.Game.Logic.EnemyTurn.Value.X +
								(ViewModelLocator.Game.Logic.EnemyTurn.Value.Y - 1) * Board.Columns]);
							cell.ImageBoardCell.Source = (ImageSource)cell.ImageBoardCell.FindResource("Untouched");
						}
					});
				lock (Board)
				{
					Dispatcher.Invoke((ThreadStart)delegate
					{
						BoardCell cell = ((BoardCell)Board.Children[ViewModelLocator.Game.Logic.EnemyTurn.Value.X +
																												 ViewModelLocator.Game.Logic.EnemyTurn.Value.Y * Board.Columns]);

						if (ViewModelLocator.Game.Logic.VinCells != null &&
								ViewModelLocator.Game.Logic.VinSide == ViewModelLocator.Game.Logic.EnemySide)
							cell.ImageBoardCell.Source = GetTurnVinImage(ViewModelLocator.Game.Logic.EnemySide);
						else
							cell.ImageBoardCell.Source = GetTurnImage(ViewModelLocator.Game.Logic.EnemySide);
					});
				}
				PrewDrawCellB = null;
				ViewModelLocator.Game.Logic.EnemyTurn = null;
			}
		}


		private void Turn(object sender, DependencyPropertyChangedEventArgs e)
		{
			Turn(sender, null);
		}

		private void Turn(object sender, EventArgs e)
		{
			if (ViewModelLocator.Game.Logic.EnemyTurn != null && PrewDrawCellB == null)
			{
				PrewDrawCellB = new Point(ViewModelLocator.Game.Logic.EnemyTurn.Value.X, 0);
				_traceDrawerB.Start();
			}

			if (ViewModelLocator.Game.Logic.PlayerTurn != null && PrewDrawCellA == null)
			{
				PrewDrawCellA = new Point(ViewModelLocator.Game.Logic.PlayerTurn.Value.X, 0);
				_traceDrawerA.Start();
			}
		}


		private void ResetBoard(object sender, DependencyPropertyChangedEventArgs e)
		{
			ResetBoard();
		}

		private void ResetBoard()
		{
			PrewDrawCellA = null;
			PrewDrawCellB = null;
			if (ViewModelLocator.Game.Logic.IsStopped)
				return;
			UIElementCollection children = Board.Children;
			children.Clear();
			Board.Columns = ViewModelLocator.Game.Logic.Board.Columns;
			Board.Rows = ViewModelLocator.Game.Logic.Board.Rows;

			for (int i = 0; i < Board.Rows; i++)
			{
				for (int j = 0; j < Board.Columns; j++)
				{
					BoardCell cell = new BoardCell();
					children.Add(cell);
					cell.ImageBoardCell.Source = (ImageSource)cell.ImageBoardCell.FindResource("Untouched");
					cell.Tag = new Point(j, i);
				}
			}
		}

		private void UpdateBoard(object sender, DependencyPropertyChangedEventArgs e)
		{
			if (ViewModelLocator.Game.Logic.InProcess)
			{
				Turn(sender, null);
			}
			else
			{
				VinPrint();
			}
		}

		private void VinPrint()
		{
			if (ViewModelLocator.Game.Logic.VinCells != null && ViewModelLocator.Game.Logic.VinCells.Count > 0)
			{

				UIElementCollection children = Board.Children;
				BoardCell cell;
				foreach (var vinCell in ViewModelLocator.Game.Logic.VinCells)
				{
					cell = ((BoardCell)children[vinCell.X + vinCell.Y * Board.Columns]);
					cell.ImageBoardCell.Source = GetTurnVinImage(ViewModelLocator.Game.Logic.VinSide);
				}
				ViewModelLocator.Game.Logic.VinCells.Clear();
				EndMessage.Content = ViewModelLocator.Game.Logic.VinSide == ViewModelLocator.Game.Logic.PlayerSide
					? "Победа!"
					: "Поражение...";
			}
			else if (ViewModelLocator.Game.Logic.Board.EmptyCells == 0)
			{
				EndMessage.Content = "Ничья.";
			}
		}

		private ImageSource GetTurnImage(GameBoard.GameSide side)
		{
			if (side == GameBoard.GameSide.Cross)
				return (ImageSource)FindResource("CrossImage");
			return (ImageSource)FindResource("ZeroImage");
		}

		private ImageSource GetTurnVinImage(GameBoard.GameSide side)
		{
			if (side == GameBoard.GameSide.Cross)
				return (ImageSource)FindResource("VinCrossImage");
			return (ImageSource)FindResource("VinZeroImage");
		}

		#endregion

	}
}
