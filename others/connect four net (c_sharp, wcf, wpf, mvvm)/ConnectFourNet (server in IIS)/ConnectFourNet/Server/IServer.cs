using System;
using System.Drawing;
using System.ServiceModel;
using ConnectNNet.Server.Models;

namespace Server
{
	[ServiceContract]
	public interface IServer
	{
		[OperationContract]
		Guid Start(GameSession gameState);

		[OperationContract]
		void ReStart(Guid gameId, Guid playerId);	

		[OperationContract]
		void Stop(Guid gameId, Guid playerId);

		[OperationContract]
		GameSession GetGameSession(Guid gameId, Guid playerId);

		[OperationContract]
		GameState GetState(Guid gameId, Guid playerId);

		[OperationContract]
		bool Turn(Guid gameId, Guid playerId, Point cellPoint);

		[OperationContract]
		Point? GetDownPos(Guid gameId, Point cellPos);
	}
}
