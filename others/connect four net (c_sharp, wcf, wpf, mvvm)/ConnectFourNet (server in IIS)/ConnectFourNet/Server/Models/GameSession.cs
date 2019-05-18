using System;
using System.Drawing;
using System.Runtime.Serialization;
using ConnectNNet.GameCore;
using ConnectNNet.GameCore.Models.Players;

namespace ConnectNNet.Server.Models
{
	[DataContract]
	public class GameSession
	{
		private GameState _state;

		#region Свойства

		public bool IsPlayerAReadedState { set; get; }
		public bool IsPlayerBReadedState { set; get; }
		public DateTime LastPlayerAConnection { set; get; }
		public DateTime LastPlayerBConnection { set; get; }

		public bool IsStateRecieved
		{
			get { return (IsPlayerAReadedState && IsPlayerBReadedState); }
		}

		[DataMember]
		public GameLogic GameInstance { set; get; }

		[DataMember]
		public Guid CreatorId { set; get; }

		[DataMember]
		public GameState State
		{
			set
			{
				_state = value;
				IsPlayerAReadedState = false;
				IsPlayerBReadedState = false;
			}
			get { return _state; }
		}

		#endregion

		#region Конструкторы

		public GameSession(GameLogic gameInstance, Guid creatorId)
		{
			GameInstance = gameInstance;
			CreatorId = creatorId;
			State = GameState.Starting;
		}

		private GameSession()
		{
			LastPlayerAConnection = DateTime.Now;
			LastPlayerBConnection = DateTime.Now;
		}

		#endregion

		#region Методы

		public GameSession ToPlayerB()
		{
			GameLogic newInstance = new GameLogic(GameInstance);
			Player playerA = newInstance.Player;
			newInstance.Player = newInstance.Enemy;
			newInstance.Enemy = playerA;
			newInstance.IsEnemyTurn = newInstance.IsPlayerTurn;
			Point? turn = newInstance.PlayerTurn;
			newInstance.PlayerTurn = newInstance.EnemyTurn;
			newInstance.EnemyTurn = turn;
			return new GameSession
			{
				GameInstance = newInstance,
				CreatorId = CreatorId
			};
		}

		#endregion
	}
}