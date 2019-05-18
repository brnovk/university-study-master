namespace ConnectNNet.Server.Models
{
	public enum GameState
	{
		Starting, // ожидание подключения второго игрока
		Started,  // второй игрок подключился
		Closed,   // игра завершилась
		PlayerATurn,
		PlayerBTurn,
		Tie,      // ничья
		PlayerAVin,
		PlayerBVin,
		NotUpdated, // состояние не изменилось с предыдущего запроса  
		Restart
	}

	public static class GameStateConverter
	{
		/// <summary>
		/// Игровой состояние для игрока В. Т.к. в локальной копии логики игрок В является игроком А.
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