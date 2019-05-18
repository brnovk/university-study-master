namespace ConnectNNet.GameCore.Models.Players
{
	public class Player
    {
        #region Поля

        private int _score;
		private GameBoard.GameSide _side;
		private string _login;

        #endregion

		#region Свойства

		public string Login
		{
			get { return _login; }
			set
			{
				_login = value;
				if (OnPlayerChanged != null)
					OnPlayerChanged.Invoke(this);
			}
		}

		public GameBoard.GameSide Side
		{
			get { return _side; }
			set
			{
				_side = value;
				if (OnPlayerChanged != null)
					OnPlayerChanged.Invoke(this);
			}
		}

		public int Score
		{
			get { return _score; }
			set
			{
				_score = value;
				if(OnPlayerChanged!=null)
					OnPlayerChanged.Invoke(this);
			}
		}

        #endregion
        
        #region События

        public delegate void SampleEventHandler(object sender);
		public event SampleEventHandler OnPlayerChanged;

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
