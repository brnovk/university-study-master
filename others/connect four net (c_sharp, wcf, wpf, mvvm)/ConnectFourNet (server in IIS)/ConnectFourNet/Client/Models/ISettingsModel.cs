using ConnectNNet.GameCore.Models;

namespace ConnectNNet.Client.Models
{
	/// <summary>
	/// Defines methods of a settings provider.
	/// </summary>
	public interface ISettingsModel
	{
		#region Window settings

		/// <summary>
		/// Shift position of window from left.
		/// </summary>
		int WindowLeft { get; set; }

		/// <summary>
		/// Shift position of window from top.
		/// </summary>
		int WindowTop { get; set; }

		/// <summary>
		/// Window hieght.
		/// </summary>
		int WindowHeight { get; set; }

		/// <summary>
		/// Window width.
		/// </summary>
		int WindowWidth { get; set; }

		/// <summary>
		/// Whether  is the window in state Maximized.
		/// </summary>
		bool WindowMax { get; set; }

		#endregion

		/// <summary>
		/// Load settings from the application properties.
		/// </summary>
		void Load();

		/// <summary>
		/// Save settings if they have been modified.
		/// </summary>
		void Save();


		#region Настройки сервера

		/// <summary>
		/// Адрес сервера в интернете.
		/// </summary>
		string ServerAdress { get; set; }

		#endregion

		#region Игровые настройки

		/// <summary>
		/// Last authorized user's login.
		/// </summary>
		string Login { get; set; }

		/// <summary>
		/// Число строк игрового поля.
		/// </summary>
		int Rows { get; set; }

		/// <summary>
		/// Число столбцов игрового поля.
		/// </summary>
		int Columns { get; set; }

		/// <summary>
		/// Число клеток для победы.
		/// </summary>
		int VinCount { get; set; }

		/// <summary>
		/// Переключать игровой стороны (крестик/нолик).
		/// </summary>
		GameBoard.GameSide Side { get; set; }

		#endregion

		/// <summary>
		/// Число побед над ботом.
		/// </summary>
		int PlayerVsBotScore { get; set; }

		/// <summary>
		/// Число побед бота.
		/// </summary>
		int BotScore { get; set; }

		/// <summary>
		/// Переключать соперников (бот/игрок).
		/// </summary>
		bool IsInetGame { get; set; }

	}
}
