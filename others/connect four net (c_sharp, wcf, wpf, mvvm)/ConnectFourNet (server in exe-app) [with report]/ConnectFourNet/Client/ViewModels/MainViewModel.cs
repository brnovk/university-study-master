using System.Windows;
using System.Windows.Input;
using ConnectNNet.Client.Models;
using ConnectNNet.Client.MVVM;
using GalaSoft.MvvmLight.Messaging;

namespace ConnectNNet.Client.ViewModels
{
	public class MainViewModel : ViewModelBase
	{
		#region Fields

		#region Commands

		public ICommand ShowSettings { get; private set; }
		public ICommand ShowGameScreen { get; private set; }
		public ICommand StartGame { get; private set; }

		#endregion

		/// <summary>
		/// The programm title by default.
		/// </summary>
		public const string ProgrammTitle = "ConnectNNet";

		/// <summary>
		/// Instance of settings provider.
		/// </summary>
		private readonly ISettingsModel _settings;

		private int _left;
		private int _top;
		private int _height;
		private int _width;
		private WindowState _state;
		private string _title;
		private ViewModelBase _currentViewModel;

		#endregion

		#region Properties

		/// <summary>
		/// Gets or sets the current view model.
		/// </summary>
		/// <value>
		/// The current view model.
		/// </value>
		public ViewModelBase CurrentViewModel
		{
			get
			{
				return _currentViewModel;
			}
			set
			{
				if (_currentViewModel == value)
					return;
				_currentViewModel = value;
				OnPropertyChanged("CurrentViewModel");
			}
		}

		public bool IsInetGame
		{
			set
			{
				ViewModelLocator.Game.Logic.IsInetGame = value;
				OnPropertyChanged("IsInetGame");
			}
			get { return ViewModelLocator.Game.Logic.IsInetGame; }
		}

		public bool IsGameStopped
		{
			get { return ViewModelLocator.Game.Logic.IsStopped; }
		}

		#region Window settings

		/// <summary>
		/// Shift position of window from left.
		/// </summary>
		public int Left
		{
			get { return _left; }
			set
			{
				if (_left == value)
					return;
				_left = value;
				OnPropertyChanged("Left");
			}
		}

		/// <summary>
		/// Shift position of window from top.
		/// </summary>
		public int Top
		{
			get { return _top; }
			set
			{
				if (_top == value)
					return;
				_top = value;
				OnPropertyChanged("Top");
			}
		}

		/// <summary>
		/// Window hieght.
		/// </summary>
		public int Height
		{
			get { return _height; }
			set
			{
				if (_height == value)
					return;
				_height = value;
				OnPropertyChanged("Height");
			}
		}

		/// <summary>
		/// Window width.
		/// </summary>
		public int Width
		{
			get { return _width; }
			set
			{
				if (_width == value)
					return;
				_width = value;
				OnPropertyChanged("Width");
			}
		}

		/// <summary>
		/// Window state.
		/// </summary>
		public WindowState State
		{
			get { return _state; }
			set
			{
				if (_state == value)
					return;
				_state = value;
				OnPropertyChanged("State");
			}
		}

		/// <summary>
		/// Gets or sets the window title.
		/// </summary>
		public string Title
		{
			get { return _title; }
			set
			{
				if (_title == value)
					return;
				_title = value;
				OnPropertyChanged("Title");
			}
		}

		#endregion


		#endregion

		#region Constructors & destructor

		public MainViewModel(ISettingsModel settings)
		{
			ShowSettings = new RelayCommand(ExecuteSettingsViewCommand);
			ShowGameScreen = new RelayCommand(ExecuteGameViewCommand);
			StartGame = new RelayCommand(ExecuteGameViewWithStartCommand);
			_settings = settings;
			Left = _settings.WindowLeft;
			Top = _settings.WindowTop;
			Height = _settings.WindowHeight;
			Width = _settings.WindowWidth;
			State = _settings.WindowMax ? WindowState.Maximized : WindowState.Normal;

			// Set the start-up view model.
			ConsumeMessage(MessageForMain.MessageType.SwitchToGameView);

			// Listen for messages from other view models.
			Messenger.Default.Register<MessageForMain>(this, ConsumeMessage);		
		}

		/// <summary>
		/// Finalizes an instance of the <see cref="MainViewModel"/> class.
		/// </summary>
		~MainViewModel()
		{
			_settings.WindowMax = State == WindowState.Maximized;
			_settings.WindowLeft = Left;
			_settings.WindowTop = Top;
			_settings.WindowWidth = Width;
			_settings.WindowHeight = Height;
			ViewModelLocator.Game.Logic.SaveSettings();
			_settings.Save();
		}

		#endregion

		#region Methods

		#region Command execute methods

		/// <summary>
		/// Переключение на игровой экран.
		/// </summary>
		private void ExecuteGameViewCommand()
		{
			Title = ProgrammTitle;
			CurrentViewModel = ViewModelLocator.Game;
			ViewModelLocator.Game.Logic.OnGameStarted += OnGameStarted;
			ViewModelLocator.Game.Logic.OnGameStopped += OnGameStopped;
		}

		/// <summary>
		/// Переключение на игровой экран с запуском игры
		/// </summary>
		private void ExecuteGameViewWithStartCommand()
		{
			ExecuteGameViewCommand();
			ViewModelLocator.Game.ExecuteStartGameCommand();
		}

		/// <summary>
		/// Переключение на экран настроек.
		/// </summary>
		private void ExecuteSettingsViewCommand()
		{
			Title = ProgrammTitle + " [Настройки]";
			CurrentViewModel = ViewModelLocator.Settings;
			CurrentViewModel.UpdateData();
		}

		#endregion

		#region Model methods

		/// <summary>
		/// Consume the MessageForMain class and perform actions based on its content.
		/// </summary>
		/// <param name="message">The message.</param>
		private void ConsumeMessage(MessageForMain message)
		{
			ConsumeMessage(message.Type);
		}

		/// <summary>
		/// Consumes the message.
		/// </summary>
		/// <param name="type">The type.</param>
		private void ConsumeMessage(MessageForMain.MessageType type)
		{
			switch (type)
			{
				case MessageForMain.MessageType.SwitchToGameView:
					ExecuteGameViewCommand();
					break;
				case MessageForMain.MessageType.SwitchToSettingsView:
					ExecuteSettingsViewCommand();
					break;
			}
		}

		#region Обработчики событий


		private void OnGameStarted(object sender)
		{
			OnPropertyChanged("IsGameStopped");
		}

		private void OnGameStopped(object sender)
		{
			OnPropertyChanged("IsGameStopped");
		}

		#endregion

		#endregion

		#endregion

	}
}
