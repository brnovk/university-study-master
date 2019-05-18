using System.Text;
using System.Windows.Input;
using ConnectNNet.Client.Helpers;
using ConnectNNet.Client.MVVM;
using ConnectNNet.GameCore.Models;
using GalaSoft.MvvmLight.Messaging;

namespace ConnectNNet.Client.ViewModels
{
	public class SettingsViewModel : ViewModelBase
	{

		#region Поля

		private int _rows;
		private int _columns;
		private int _vinCount;
		private string _serverAdres;
		private int _serverPort;
		private string _login;
		private int _sideId;

		#endregion

		#region Свойства

		#region Commands

		public ICommand Save { get; private set; }
		public ICommand Back { get; private set; }

		#endregion

		public bool NeedSave { get; private set; }

		private GameController Logic { set; get; }

		public int Rows
		{
			set
			{
				if (_rows != value)
				{
					_rows = value;
					if (VinCount > value)
						VinCount = value;
					NeedSave = true;
					OnPropertyChanged("Rows");
				}
			}
			get { return _rows; }
		}

		public int Columns
		{
			set
			{
				if (_columns != value)
				{
					_columns = value;
					if (VinCount > value)
						VinCount = value;
					NeedSave = true;
					OnPropertyChanged("Columns");
				}
			}
			get { return _columns; }
		}

		public int VinCount
		{
			set
			{
				if (_vinCount != value)
				{
					_vinCount = value;
					if (Columns < value)
						Columns = value;
					if (Rows < value)
						Rows = value;
					NeedSave = true;
					OnPropertyChanged("VinCount");
				}
			}
			get { return _vinCount; }
		}

		public string ServerAdress
		{
			set
			{
				if (_serverAdres != value)
				{
					_serverAdres = value;
					NeedSave = true;
					OnPropertyChanged("ServerAdress");
				}
			}
			get { return _serverAdres; }
		}

		public string Login
		{
			set
			{
				if (_login != value)
				{
					_login = value.Trim();
					NeedSave = true;
					OnPropertyChanged("Login");
				}
			}
			get { return _login; }
		}

		public int SideId
		{
			set
			{
				if (_sideId != value)
				{
					_sideId = value;
					NeedSave = true;
					OnPropertyChanged("SideId");
				}
			}
			get { return _sideId; }
		}

		#endregion

		#region Конструкторы

		public SettingsViewModel(GameController logic)
		{
			Logic = logic;
			Save = new RelayCommand(ExecuteSaveCommand, CanSave);
			Back = new RelayCommand(ExecuteBackCommand);
		}

		#endregion

		#region Command execute methods

		private bool CanSave(object arg)
		{
			if (!NeedSave)
				return false;
			StringBuilder errors = new StringBuilder();
			ValidationHelper.InRange("Логин", Login, errors, 11, 3);
			ValidationHelper.RegularExpression("Логин", Login, errors, @"^[\w][\w \d\-\']*[^\s]$");

			ErrorMsg = errors.Length == 0 ? "" : errors.ToString();
			return errors.Length == 0;
		}

		/// <summary>
		/// Применение настроек.
		/// </summary>
		private void ExecuteSaveCommand()
		{
			Logic.VinCount = VinCount;
			Logic.Board.Rows = Rows;
			Logic.Board.Columns = Columns;
			Logic.Player.Login = Login;
			Logic.PlayerSide = (GameBoard.GameSide)SideId;
			Logic.Settings.ServerAdress = ServerAdress;
			Logic.Server.Close();
			Logic.SaveSettings();
			NeedSave = false;
		}

		/// <summary>
		/// Возврат на игровой экран.
		/// </summary>
		private void ExecuteBackCommand()
		{
			Messenger.Default.Send(new MessageForMain(MessageForMain.MessageType.SwitchToGameView));
		}

		#endregion

		#region Методы

		public override void UpdateData()
		{
			VinCount = Logic.VinCount;
			Rows = Logic.Board.Rows;
			Columns = Logic.Board.Columns;
			Login = Logic.Player.Login;
			SideId = (int)Logic.Player.Side;
			ServerAdress = Logic.Settings.ServerAdress;
			NeedSave = false;
			base.UpdateData();
		}

		#endregion

	}
}
