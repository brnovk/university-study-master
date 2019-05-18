namespace ConnectNNet.Server.Models
{
	public enum GameState
	{
		Starting,
		Started,
		Closed,
		PlayerATurn,
		PlayerBTurn,
		Tie,
		PlayerAVin,
		PlayerBVin,
		NotUpdated,
		Restart
	}

	public static class GameStateConverter
	{
        /// <summary>
        /// Вспомогательный метод получение следующего игрового состояния,
        /// в зависимости от текущего.
        /// </summary>
		public static GameState GameStateForPlayerB(GameState source)
		{
			switch (source)
			{
				case GameState.PlayerATurn:
					return GameState.PlayerBTurn;
				case GameState.PlayerBTurn:
					return GameState.PlayerATurn;
				case GameState.PlayerAVin:
					return GameState.PlayerBVin;
				case GameState.PlayerBVin:
					return GameState.PlayerAVin;
				default:
					return source;
			}
		}
	}
}