using System;
using System.Collections.Generic;
using System.Drawing;

namespace ConnectNNet.GameCore.Models.Players
{
	public class EnemyBot : Player
	{
		private static readonly Random Rd;

		#region Конструкторы

		public EnemyBot(Player enemy)
			: base(enemy)
		{
			Login = "Компьютер";
		}

		public EnemyBot()
		{
			Login = "Компьютер";
		}

		static EnemyBot()
		{
			Rd = new Random();
		}

		#endregion

		#region Методы

		private static int p1, p2;

		public static Point GetStep(GameBoard board, int size, GameBoard.GameSide side)
		{
			int row, k, column;
			double[,] prob = new double[board.Rows, board.Columns];
			double max = 0;
			GameBoard.GameSide signEN = side == GameBoard.GameSide.Zero ? GameBoard.GameSide.Cross : GameBoard.GameSide.Zero;
			Point selo = new Point();
			List<Point> A = new List<Point>();
			for (row = 0; row < board.Rows; row++)
				for (column = 0; column < board.Columns; column++)
				{
					if (!board.Board[row, column].Equals(GameBoard.GameSide.Empty))
					{
						prob[row, column] = -1;
						continue;
					}

					k = GetRateV(row, column, side, board, size);
					if (k + 1 >= size) k += 100500;
					if (prob[row, column] < k + p1 + p2) prob[row, column] = k + p1 + p2 + 0.1;
					k = GetRateV(row, column, signEN, board, size);
					if (k + 1 >= size) k += 100;
					if (prob[row, column] < k + p1 + p2) prob[row, column] = k + p1 + p2;

					k = GetRateH(row, column, side, board, size);
					if (k + 1 >= size) k += 100500;
					if (prob[row, column] < k + p1 + p2) prob[row, column] = k + p1 + p2 + 0.1;
					k = GetRateH(row, column, signEN, board, size);
					if (k + 1 >= size) k += 100;
					if ((prob[row, column] > 2) && (prob[row, column] == k + p1 + p2)) prob[row, column] += 0.1;
					if (prob[row, column] < k + p1 + p2) prob[row, column] = k + p1 + p2;

					k = GetRateMd(row, column, side, board, size);
					if (k + 1 >= size) k += 100500;
					if (prob[row, column] < k + p1 + p2) prob[row, column] = k + p1 + p2 + 0.1;
					k = GetRateMd(row, column, signEN, board, size);
					if (k + 1 >= size) k += 100;
					if ((prob[row, column] > 2) && (prob[row, column] == k + p1 + p2)) prob[row, column] += 0.1;
					if (prob[row, column] < k + p1 + p2) prob[row, column] = k + p1 + p2;

					k = GetRateSd(row, column, side, board, size);
					if (k + 1 >= size) k += 100500;
					if (prob[row, column] < k + p1 + p2) prob[row, column] = k + p1 + p2 + 0.1;
					k = GetRateSd(row, column, signEN, board, size);
					if (k + 1 >= size) k += 100;
					if ((prob[row, column] > 2) && (prob[row, column] == k + p1 + p2)) prob[row, column] += 0.1;
					if (prob[row, column] < k + p1 + p2) prob[row, column] = k + p1 + p2;
				}

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

			for (row = 0; row < board.Rows; row++)
				for (column = 0; column < board.Columns; column++)
					if (max == prob[row, column])
					{
						selo = new Point(column, row);
						A.Add(selo);
					}

			for (int trow = 0; trow < board.Rows; trow++)
			{
				for (int tcolumn = 0; tcolumn < board.Columns; tcolumn++)
				{
					Console.Write("{0:00.00}\t",prob[trow, tcolumn]);
				}
				Console.Write("\n");
			}
			Console.WriteLine("__________________________________________________________________");
			return A[Rd.Next(A.Count)];
		}

		static int GetRateV(int i, int j, GameBoard.GameSide side, GameBoard board, int size)
		{
			int t = 1, k = 0, p = 1;
			p1 = 0; p2 = 0;
			while ((i + t < board.Rows) && side.Equals(board.Board[i + t, j]))
			{ t++; k++; };
			while ((i + t < board.Rows) && GameBoard.GameSide.Empty.Equals(board.Board[i + t, j]))
			{ t++; p1 = 1; p++; };
			t = -1;
			while ((i + t > -1) && side.Equals(board.Board[i + t, j])) { t--; k++; };
			while ((i + t > -1) && GameBoard.GameSide.Empty.Equals(board.Board[i + t, j]))
			{ t--; p2 = 1; p++; };
			if ((k + p < size)) k = 0;
			return k;
		}

		static int GetRateH(int i, int j, GameBoard.GameSide side, GameBoard board, int size)
		{
			int t = 1, k = 0, p = 1;
			p1 = 0; p2 = 0;
			while ((j + t < board.Columns) && side.Equals(board.Board[i, j + t])) { t++; k++; };
			while ((j + t < board.Columns) && GameBoard.GameSide.Empty.Equals(board.Board[i, j + t]))
			{ t++; p1 = 1; p++; };
			t = -1;
			while ((j + t > -1) && side.Equals(board.Board[i, j + t])) { t--; k++; };
			while ((j + t > -1) && GameBoard.GameSide.Empty.Equals(board.Board[i, j + t]))
			{ t--; p2 = 1; p++; };
			if ((k + p < size))
				k = 0;
			return k;
		}

		static int GetRateMd(int i, int j, GameBoard.GameSide side, GameBoard board, int size)
		{
			int t = 1, k = 0, p = 1;
			p1 = 0; p2 = 0;
			while ((j + t < board.Columns) && (i + t < board.Rows) && side.Equals(board.Board[i + t, j + t]))
			{ t++; k++; };
			while ((j + t < board.Columns) && (i + t < board.Rows) &&
				GameBoard.GameSide.Empty.Equals(board.Board[i + t, j + t]))
			{ t++; p1 = 1; p++; };
			t = -1;
			while ((j + t > -1) && (i + t > -1) && side.Equals(board.Board[i + t, j + t]))
			{ t--; k++; };
			while ((j + t > -1) && (i + t > -1) && GameBoard.GameSide.Empty.Equals(board.Board[i + t, j + t]))
			{ t--; p2 = 1; p++; };
			if ((k + p < size)) k = 0;
			return k;
		}

		static int GetRateSd(int i, int j, GameBoard.GameSide side, GameBoard board, int size)
		{
			int t = 1, k = 0, p = 1;
			p1 = 0; p2 = 0;
			while ((j - t > -1) && (i + t < board.Rows) && side.Equals(board.Board[i + t, j - t]))
			{ t++; k++; };
			while ((j - t > -1) && (i + t < board.Rows) && GameBoard.GameSide.Empty.Equals(board.Board[i + t, j - t]))
			{ t++; p1 = 1; p++; };
			t = -1;
			while ((j - t < board.Columns) && (i + t > -1) && side.Equals(board.Board[i + t, j - t]))
			{ t--; k++; };
			while ((j - t < board.Columns) && (i + t > -1) && GameBoard.GameSide.Empty.Equals(board.Board[i + t, j - t]))
			{ t--; p2 = 1; p++; };
			if ((k + p < size)) k = 0;
			return k;
		}

		#endregion
	}
}
