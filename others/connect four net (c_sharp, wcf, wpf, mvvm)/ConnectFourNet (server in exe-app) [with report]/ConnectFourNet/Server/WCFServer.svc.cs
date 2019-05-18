using System;
using System.Collections.Generic;
using System.Drawing;
using System.ServiceModel;
using ConnectNNet.Server.Models;

namespace ConnectNNet.Server
{
	[ServiceBehavior(InstanceContextMode = InstanceContextMode.PerCall)]
	public class WcfServer : IServer
	{
		/// <summary>
		/// Коллекция игровых сессий.
		/// </summary>
		private static Dictionary<Guid, GameSession> Games { set; get; }

		static WcfServer()
		{
			Games = new Dictionary<Guid, GameSession>();
		}

		#region Методы

		public Guid Start(GameSession session)
		{
			CleanSessions();
			// поиск открытой игровой сессии (один игрок уже ждет подключения другого)
			foreach (var game in Games.Values)
			{
				if (game.State == GameState.Starting)
				{
					game.GameInstance.Enemy = session.GameInstance.Player;
					game.LastPlayerBConnection = DateTime.Now;
					game.State = GameState.Started;
					return game.CreatorId;
				}
			}
			session.GameInstance.InProcess = false;
			Games[session.CreatorId] = session;
			session.State = GameState.Starting;
			return session.CreatorId;
		}

		/// <summary>
		/// Удаление устаревших сессий.
		/// </summary>
		private void CleanSessions()
		{
			List<Guid> deleteList = null;
			foreach (var game in Games.Values)
			{
				int t= (DateTime.Now - game.LastPlayerAConnection).Minutes;
				int t2 = (DateTime.Now - game.LastPlayerAConnection).Minutes;
				if (t > 5 || t2 > 5)
				{
					if (deleteList == null)
						deleteList = new List<Guid>();
					deleteList.Add(game.CreatorId);
				}
			}
			if (deleteList != null)
				foreach (var game in deleteList)
				{
					Games.Remove(game);
				}
		}

		public void ReStart(Guid gameId, Guid playerId)
		{
			if (!Games.ContainsKey(gameId))
				return;
			GameSession game = Games[gameId];
			if (game.State != GameState.Restart)
			{
				game.State = GameState.Restart;
			}
			if (game.CreatorId == playerId)
			{
				game.IsPlayerAReadedState = true;
			}
			else
			{
				game.IsPlayerBReadedState = true;
			}
			if (game.IsStateRecieved)
			{
				game.State = GameState.Started;
				game.GameInstance.ReStart();
			}
		}

		public void Stop(Guid gameId, Guid playerId)
		{
			Games.Remove(gameId);
		}

		public GameSession GetGameSession(Guid gameId, Guid playerId)
		{
			if (!Games.ContainsKey(gameId))
				return null;
			GameSession game = Games[gameId];
			if (game.State != GameState.Starting &&
					((DateTime.Now - game.LastPlayerAConnection).Seconds > 10) ||
					(DateTime.Now - game.LastPlayerBConnection).Seconds > 10)
			{
				Games.Remove(gameId);
				return null;
			}
			if (game.CreatorId == playerId)
				return game;
			return game.ToPlayerB();
		}

		public GameState GetState(Guid gameId, Guid playerId)
		{
			if (!Games.ContainsKey(gameId))
				return GameState.Closed;
			GameState result;
			GameSession game = Games[gameId];

			if (game.State == GameState.Restart)
				return GameState.NotUpdated;

			if (game.CreatorId == playerId)  // если запрашивает создатель игры
			{
				game.LastPlayerAConnection = DateTime.Now;
				if (game.IsPlayerAReadedState)
				{
					result = GameState.NotUpdated;
				}
				else
				{
					game.IsPlayerAReadedState = true;
					result = game.State;
				}
			}  // если запрашивает подключившийся
			else
			{
				game.LastPlayerBConnection = DateTime.Now;
				if (game.IsPlayerBReadedState)
				{
					result = GameState.NotUpdated;
				}
				else
				{
					game.IsPlayerBReadedState = true;
					result = GameStateConverter.GameStateForPlayerB(game.State);
				}
			}
			if (game.IsStateRecieved)
			{
				switch (game.State)
				{
					case GameState.Started:
						game.GameInstance.Start();
						game.State = game.GameInstance.IsPlayerTurn ? GameState.PlayerATurn : GameState.PlayerBTurn;
						break;
				}
			}
			if (game.State != GameState.Starting &&
				((DateTime.Now - game.LastPlayerAConnection).Seconds > 20 ||
				(DateTime.Now - game.LastPlayerBConnection).Seconds > 20))
			{
				Games.Remove(gameId);
				return GameState.Closed;
			}
			return result;
		}

		public bool Turn(Guid gameId, Guid playerId, Point cellPoint)
		{
			if (!Games.ContainsKey(gameId))
				return false;
			GameSession game = Games[gameId];
			bool result;
			lock (game)
			{
				result = game.CreatorId == playerId
					? game.GameInstance.PlayerATurn(cellPoint)
					: game.GameInstance.PlayerBTurn(cellPoint);
			}
			if (result)
			{
				if (game.GameInstance.VinCells != null)
				{
					game.GameInstance.InProcess = false;
					switch (game.State)
					{
						case GameState.PlayerATurn:
							game.State = GameState.PlayerAVin;
							break;
						case GameState.PlayerBTurn:
							game.State = GameState.PlayerBVin;
							break;
					}
				}
				else
				{
					switch (game.State)
					{
						case GameState.PlayerATurn:
							game.State = GameState.PlayerBTurn;
							break;
						case GameState.PlayerBTurn:
							game.State = GameState.PlayerATurn;
							break;
					}
				}
				if (game.GameInstance.Board.EmptyCells == 0)
				{
					game.GameInstance.InProcess = false;
					game.State = GameState.Tie;
				}
			}
			return result;
		}

		public Point? GetDownPos(Guid gameId, Point cellPos)
		{
			if (!Games.ContainsKey(gameId))
			return null;
			GameSession game = Games[gameId];
			return game.GameInstance.GetDownPos(cellPos);
		}

		#endregion

	}
}
