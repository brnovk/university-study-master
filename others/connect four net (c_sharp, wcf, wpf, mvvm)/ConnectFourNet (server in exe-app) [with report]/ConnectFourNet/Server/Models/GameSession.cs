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

		#region Подтверждение получения состояния игроками

		public bool IsPlayerAReadedState { set; get; }
		public bool IsPlayerBReadedState { set; get; }


		/// <summary>
		/// Оба игрока получили игровое состояние.
		/// </summary>
		public bool IsStateRecieved
		{
			get { return (IsPlayerAReadedState && IsPlayerBReadedState); }
		}

		#endregion

		public DateTime LastPlayerAConnection { set; get; }
		public DateTime LastPlayerBConnection { set; get; }
		
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
			: this()
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

		/// <summary>
		/// Инвертирование игроков в игровой сессии (для отправки состояния подключившемуся).
		/// </summary>
		/// <returns></returns>
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