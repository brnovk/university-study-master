namespace ConnectNNet.GameCore.Models.Players
{
	public class Player
	{

		#region Свойства

		public string Login { get; set; }

		public GameBoard.GameSide Side { get; set; }

		public int Score { get; set; }

		#endregion


		#region Конструкторы

		public Player(string login, GameBoard.GameSide side)
			: base()
		{
			Login = login;
			Side = side;
		}

		public Player()
		{
			Login = "";
			Side = GameBoard.GameSide.Zero;
			Score = 0;
		}

		public Player(Player source)
		{
			Side = source.Side;
		}

		#endregion

	}
}
