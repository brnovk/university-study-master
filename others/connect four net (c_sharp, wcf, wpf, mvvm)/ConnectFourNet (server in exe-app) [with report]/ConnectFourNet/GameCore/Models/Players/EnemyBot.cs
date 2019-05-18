using System;
using System.Collections.Generic;
using System.Drawing;

namespace ConnectNNet.GameCore.Models.Players
{
	public class EnemyBot : Player
	{
		private static readonly Random Rd = new Random();

		#region Конструкторы

		/// <summary>
		/// Для указания игровой стороны.
		/// </summary>
		/// <param name="enemy">The enemy.</param>
		public EnemyBot(Player enemy)
			: base(enemy)
		{
			Login = "Компьютер";
		}

		public EnemyBot()
		{
			Login = "Компьютер";
		}

		#endregion


		#region Логика бота

		private static int p1, p2;

		/// <summary>
		/// Получение хода бота.
		/// </summary>
		/// <param name="board">Игровая доска.</param>
		/// <param name="winSize">Длина выигрышной комбинации.</param>
		/// <param name="side">Сторона игрока.</param>
		/// <returns></returns>
		public static Point GetStep(GameBoard board, int winSize, GameBoard.GameSide side)
		{
			int row, k, column;
			double[,] prob = new double[board.Rows, board.Columns];  // матрица вероятностей
			double max = 0;																					 // максимальное значение в матрице
			GameBoard.GameSide enemySide = (side == GameBoard.GameSide.Zero ? GameBoard.GameSide.Cross : GameBoard.GameSide.Zero);

			for (row = 0; row < board.Rows; row++)
				for (column = 0; column < board.Columns; column++)
				{
					if (!board.Board[row, column].Equals(GameBoard.GameSide.Empty))  // зануление вероятности ходя для занятой клетки
					{
						prob[row, column] = -1;
						continue;
					}

					#region Вычислние вероятности хода в клетку с координатами [row, column]

					k = GetRateV(row, column, side, board, winSize);
					if (k + 1 >= winSize) k += 100500;
					if (prob[row, column] < k + p1 + p2) prob[row, column] = k + p1 + p2 + 0.1;
					k = GetRateV(row, column, enemySide, board, winSize);
					if (k + 1 >= winSize) k += 100;
					if (prob[row, column] < k + p1 + p2) prob[row, column] = k + p1 + p2;

					k = GetRateH(row, column, side, board, winSize);
					if (k + 1 >= winSize) k += 100500;
					if (prob[row, column] < k + p1 + p2) prob[row, column] = k + p1 + p2 + 0.1;
					k = GetRateH(row, column, enemySide, board, winSize);
					if (k + 1 >= winSize) k += 100;
					if ((prob[row, column] > 2) && (prob[row, column] == k + p1 + p2)) prob[row, column] += 0.1;
					if (prob[row, column] < k + p1 + p2) prob[row, column] = k + p1 + p2;

					k = GetRateMd(row, column, side, board, winSize);
					if (k + 1 >= winSize) k += 100500;
					if (prob[row, column] < k + p1 + p2) prob[row, column] = k + p1 + p2 + 0.1;
					k = GetRateMd(row, column, enemySide, board, winSize);
					if (k + 1 >= winSize) k += 100;
					if ((prob[row, column] > 2) && (prob[row, column] == k + p1 + p2)) prob[row, column] += 0.1;
					if (prob[row, column] < k + p1 + p2) prob[row, column] = k + p1 + p2;

					k = GetRateSd(row, column, side, board, winSize);
					if (k + 1 >= winSize) k += 100500;
					if (prob[row, column] < k + p1 + p2) prob[row, column] = k + p1 + p2 + 0.1;
					k = GetRateSd(row, column, enemySide, board, winSize);
					if (k + 1 >= winSize) k += 100;
					if ((prob[row, column] > 2) && (prob[row, column] == k + p1 + p2)) prob[row, column] += 0.1;
					if (prob[row, column] < k + p1 + p2) prob[row, column] = k + p1 + p2;

					#endregion

				}

			// определение значения максимальной вероятности хода
			for (row = 0; row < board.Rows-1; row++)
				for (column = 0; column < board.Columns; column++)
				{
					if (prob[row + 1, column] != -1)
						prob[row, column] = 0;
					if (max < prob[row, column]) max = prob[row, column];
				}

			for (row = 0; row < board.Rows; row++)
				for (column = 0; column < board.Columns; column++)
				{
					if (max < prob[row, column]) max = prob[row, column];
				}

			List<Point> a = new List<Point>();

			// выбор клеток с максимальной вероятностью хода
			for (row = 0; row < board.Rows; row++)
				for (column = 0; column < board.Columns; column++)
					if (max == prob[row, column])
					{
						var selo = new Point(column, row);
						a.Add(selo);
					}

			// отрисовка в отладочной консоли матрицы вероятностей
			for (int trow = 0; trow < board.Rows; trow++)
			{
				for (int tcolumn = 0; tcolumn < board.Columns; tcolumn++)
				{
					Console.Write("{0:00.00}\t",prob[trow, tcolumn]);
				}
				Console.Write("\n");
			}
			Console.WriteLine("__________________________________________________________________");

			return a[Rd.Next(a.Count)];  //  случайный выбор одной из клеток возможного хода
		}

		#region Определение ценности хода в клеткку [i,j] по каждой из линий (горизонтали, вертикали и по диагоналям)

		private static int GetRateV(int i, int j, GameBoard.GameSide side, GameBoard board, int size)
		{
			int t = 1, k = 0, p = 1;
			p1 = 0;
			p2 = 0;
			while ((i + t < board.Rows) && side.Equals(board.Board[i + t, j]))
			{
				t++;
				k++;
			}
			;
			while ((i + t < board.Rows) && GameBoard.GameSide.Empty.Equals(board.Board[i + t, j]))
			{
				t++;
				p1 = 1;
				p++;
			}
			;
			t = -1;
			while ((i + t > -1) && side.Equals(board.Board[i + t, j]))
			{
				t--;
				k++;
			}
			;
			while ((i + t > -1) && GameBoard.GameSide.Empty.Equals(board.Board[i + t, j]))
			{
				t--;
				p2 = 1;
				p++;
			}
			;
			if ((k + p < size)) k = 0;
			return k;
		}

		private static int GetRateH(int i, int j, GameBoard.GameSide side, GameBoard board, int size)
		{
			int t = 1, k = 0, p = 1;
			p1 = 0;
			p2 = 0;
			while ((j + t < board.Columns) && side.Equals(board.Board[i, j + t]))
			{
				t++;
				k++;
			}
			;
			while ((j + t < board.Columns) && GameBoard.GameSide.Empty.Equals(board.Board[i, j + t]))
			{
				t++;
				p1 = 1;
				p++;
			}
			;
			t = -1;
			while ((j + t > -1) && side.Equals(board.Board[i, j + t]))
			{
				t--;
				k++;
			}
			;
			while ((j + t > -1) && GameBoard.GameSide.Empty.Equals(board.Board[i, j + t]))
			{
				t--;
				p2 = 1;
				p++;
			}
			;
			if ((k + p < size))
				k = 0;
			return k;
		}

		private static int GetRateMd(int i, int j, GameBoard.GameSide side, GameBoard board, int size)
		{
			int t = 1, k = 0, p = 1;
			p1 = 0;
			p2 = 0;
			while ((j + t < board.Columns) && (i + t < board.Rows) && side.Equals(board.Board[i + t, j + t]))
			{
				t++;
				k++;
			}
			;
			while ((j + t < board.Columns) && (i + t < board.Rows) &&
			       GameBoard.GameSide.Empty.Equals(board.Board[i + t, j + t]))
			{
				t++;
				p1 = 1;
				p++;
			}
			;
			t = -1;
			while ((j + t > -1) && (i + t > -1) && side.Equals(board.Board[i + t, j + t]))
			{
				t--;
				k++;
			}
			;
			while ((j + t > -1) && (i + t > -1) && GameBoard.GameSide.Empty.Equals(board.Board[i + t, j + t]))
			{
				t--;
				p2 = 1;
				p++;
			}
			;
			if ((k + p < size)) k = 0;
			return k;
		}

		private static int GetRateSd(int i, int j, GameBoard.GameSide side, GameBoard board, int size)
		{
			int t = 1, k = 0, p = 1;
			p1 = 0;
			p2 = 0;
			while ((j - t > -1) && (i + t < board.Rows) && side.Equals(board.Board[i + t, j - t]))
			{
				t++;
				k++;
			}
			;
			while ((j - t > -1) && (i + t < board.Rows) && GameBoard.GameSide.Empty.Equals(board.Board[i + t, j - t]))
			{
				t++;
				p1 = 1;
				p++;
			}
			;
			t = -1;
			while ((j - t < board.Columns) && (i + t > -1) && side.Equals(board.Board[i + t, j - t]))
			{
				t--;
				k++;
			}
			;
			while ((j - t < board.Columns) && (i + t > -1) && GameBoard.GameSide.Empty.Equals(board.Board[i + t, j - t]))
			{
				t--;
				p2 = 1;
				p++;
			}
			;
			if ((k + p < size)) k = 0;
			return k;
		}

		#endregion


		#endregion

	}
}
