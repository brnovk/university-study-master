using System;
using System.Runtime.Serialization;

namespace ConnectNNet.Server.Models
{
	[DataContract]
	public class GameMessage
	{
		[DataMember]
		public Guid CreatorId { set; get; }

		[DataMember]
		public Guid ReceiverId { set; get; }
	}
}