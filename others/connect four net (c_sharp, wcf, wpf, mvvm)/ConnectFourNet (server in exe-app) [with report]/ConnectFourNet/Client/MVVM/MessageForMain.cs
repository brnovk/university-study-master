namespace ConnectNNet.Client.MVVM
{
	/// <summary>
	/// A simple message class that we use to pass messages around the application
	/// via the Messenger singleton, but keep the parts sufficiently decoupled
	/// for the MVVM style of work.  It is used for switching of global views.
	/// </summary>
	public class MessageForMain
	{
		/// <summary>
		/// Enum of commands for the main manager of messages.
		/// </summary>
		public enum MessageType
		{
			SwitchToGameView,
			SwitchToSettingsView
		}

		#region Constructors

		/// <summary>
		/// Initializes a new instance of the <see cref="MessageForMain"/> class.
		/// </summary>
		public MessageForMain()
			: this(MessageType.SwitchToGameView)
		{
		}

		/// <summary>
		/// Initializes a new instance of the <see cref="MessageForMain"/> class.
		/// </summary>
		/// <param name="type">The type.</param>
		public MessageForMain(MessageType type)
			: this(type, string.Empty)
		{
		}

		/// <summary>
		/// Initializes a new instance of the <see cref="MessageForMain"/> class.
		/// </summary>
		/// <param name="type">The type.</param>
		/// <param name="message">The message.</param>
		public MessageForMain(MessageType type, string message)
		{
			Type = type;
			Message = message;
		}

		#endregion

		#region Properties

		/// <summary>
		/// Gets or sets the type.
		/// </summary>
		/// <value>
		/// The type.
		/// </value>
		public MessageType Type { get; set; }

		/// <summary>
		/// Gets or sets the message.
		/// </summary>
		/// <value>
		/// The message.
		/// </value>
		public string Message { get; set; }

		#endregion
	}
}
