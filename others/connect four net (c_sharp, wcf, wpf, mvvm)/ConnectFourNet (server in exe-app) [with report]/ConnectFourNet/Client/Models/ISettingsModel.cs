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


		#region ��������� �������

		/// <summary>
		/// ����� ������� � ���������.
		/// </summary>
		string ServerAdress { get; set; }

		#endregion

		#region ������� ���������

		/// <summary>
		/// Last authorized user's login.
		/// </summary>
		string Login { get; set; }

		/// <summary>
		/// ����� ����� �������� ����.
		/// </summary>
		int Rows { get; set; }

		/// <summary>
		/// ����� �������� �������� ����.
		/// </summary>
		int Columns { get; set; }

		/// <summary>
		/// ����� ������ ��� ������.
		/// </summary>
		int VinCount { get; set; }

		/// <summary>
		/// ����������� ������� ������� (�������/�����).
		/// </summary>
		GameBoard.GameSide Side { get; set; }

		#endregion

		/// <summary>
		/// ����� ����� ��� �����.
		/// </summary>
		int PlayerVsBotScore { get; set; }

		/// <summary>
		/// ����� ����� ����.
		/// </summary>
		int BotScore { get; set; }

		/// <summary>
		/// ����������� ���������� (���/�����).
		/// </summary>
		bool IsInetGame { get; set; }

	}
}
