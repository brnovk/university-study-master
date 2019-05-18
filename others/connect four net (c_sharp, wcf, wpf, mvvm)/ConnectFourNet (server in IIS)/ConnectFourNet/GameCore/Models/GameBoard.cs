using System.Collections.Generic;
using System.Drawing;

namespace ConnectNNet.GameCore.Models
{
	public class GameBoard
	{
		public enum GameSide
		{
			Zero = 0,
			Cross = 1,
			Empty = 2
		}

		#region Константы

		private readonly Point[] _linesShifts = new[]
		{
            new Point(1, 0),
            new Point(-1, 0),
            new Point(1, 1),
            new Point(-1, -1),
            new Point(0, 1),
            new Point(0, -1),
            new Point(1, -1),
            new Point(-1, 1),	
		};

		public const int MaxRows = 99;
		public const int MaxColumns = 99;
		public const int MinRows = 3;
		public const int MinColumns = 3;

		#endregion

		#region Поля

		private int _rows;
		private int _columns;

        #endregion

        #region События

        public delegate void SampleEventHandler(object sender);
		public event SampleEventHandler OnBoardSizeChanged;

		#endregion

		#region Свойства

		public int Rows
		{
			set
			{
				if (value >= MinRows && value <= MaxRows)
				{
					_rows = value;
					if (OnBoardSizeChanged != null)
						OnBoardSizeChanged(this);
				}
			}
			get { return _rows; }
		}

		public int Columns
		{
			set
			{
				if (value >= MinColumns && value <= MaxColumns)
				{
					_columns = value;
					if (OnBoardSizeChanged != null)
						OnBoardSizeChanged(this);
				}
			}
			get { return _columns; }
		}

		public int EmptyCells { set; get; }

		public GameSide[,] Board { private set; get; }

		#endregion

		#region Конструкторы

		public GameBoard()
		{
			Rows = MinRows;
			Columns = MinColumns;
			Rebuild();
		}

		public GameBoard(int rows, int columns)
			: base()
		{
			Rows = rows;
			Columns = columns;
			Rebuild();
		}

		#endregion

        #region Методы

        public void Rebuild()
		{
			Board = new GameSide[Rows, Columns];
			for (int i = 0; i < Rows; i++)
				for (int j = 0; j < Columns; j++)
					Board[i, j] = GameSide.Empty;
			EmptyCells = Rows * Columns;
		}

		public bool CheckFreeCell(Point cellPos)
		{
			return (Board[cellPos.Y, cellPos.X] == GameSide.Empty);
		}

		public List<Point> GetVinState(Point cellPos, int vinSize, int lineCode = 0)
		{
			if (lineCode < _linesShifts.Length)
			{
				int row = cellPos.Y,
				column = cellPos.X,
				xShift = _linesShifts[lineCode].X,
				yShift = _linesShifts[lineCode].Y;
				GameSide currSide = Board[row, column];
				List<Point> vinCells = new List<Point>();
				while ((row + yShift < Rows) && (column + xShift < Columns) && (row + yShift > -1) && (column + xShift > -1) &&
					currSide.Equals(Board[row + yShift, column + xShift]))
				{
					vinCells.Add(new Point(column + xShift, row + yShift));
					xShift += _linesShifts[lineCode].X;
					yShift += _linesShifts[lineCode].Y;
				}
				if (lineCode % 2 == 0)
				{
					List<Point> nextVinCells = GetVinState(cellPos, vinSize, lineCode + 1);
					if (nextVinCells != null)
						vinCells.AddRange(nextVinCells);
					if (vinCells.Count + 1 < vinSize)
						vinCells.Clear();
					if (vinCells.Count > 0)
						vinCells.Add(cellPos);
					nextVinCells = GetVinState(cellPos, vinSize, lineCode + 2);
					if (nextVinCells != null)
						vinCells.AddRange(nextVinCells);
				}
				if (vinCells.Count > 0)
					return vinCells;
			}
			if (lineCode == 0 && EmptyCells == 0) // ничья
				return new List<Point>();
			return null; // победителя нет, но игра продолжается
		}

		public GameSide GetCellState(Point cellPos)
		{
			return Board[cellPos.Y, cellPos.X];
		}

		public GameSide GetCellState(int x, int y)
		{
			return Board[y, x];
		}

		public void SetCellState(Point cellPos, GameSide value)
		{
			EmptyCells--;
			Board[cellPos.Y, cellPos.X] = value;
        }

        #endregion
    }
}
