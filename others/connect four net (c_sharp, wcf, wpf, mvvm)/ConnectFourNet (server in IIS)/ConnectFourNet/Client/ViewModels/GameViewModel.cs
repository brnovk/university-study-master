using System.Drawing;
using System.Windows.Input;
using ConnectNNet.Client.Models;
using GalaSoft.MvvmLight.Command;

namespace ConnectNNet.Client.ViewModels
{
	public class GameViewModel : ViewModelBase
	{
		private bool _reBoard;
		private bool _upBoard;

		#region Поля


		#endregion

		#region Свойства

		#region Commands

		public ICommand Start { get; private set; }
		public ICommand End { get; private set; }
		public ICommand Continue { get; private set; }

		#endregion

		public GameController Logic { get; private set; }

		public bool ReBoard
		{
			get { return _reBoard; }
			set
			{
				_reBoard = value;
				OnPropertyChanged("ReBoard");
			}
		}

		public bool UpBoard
		{
			get { return _upBoard; }
			set
			{
				_upBoard = value;
				OnPropertyChanged("UpBoard");
			}
		}

		#endregion

		#region Конструкторы

		public GameViewModel(ISettingsModel settings)
		{
			Logic = new GameController(settings);
			Logic.OnGameStarted += OnGameStateChanged;
			Logic.OnGameStopped += OnGameStateChanged;
			Logic.OnGameDataUpdated += OnGameStateChanged;
			Logic.OnRebuildBoard += RebuildBoard;
			Logic.OnUpdateBoard += UpdateBoard;
			Start = new RelayCommand(ExecuteStartGameCommand);
			End = new RelayCommand(ExecuteEndGameCommand);
			Continue = new RelayCommand(ExecuteContinueGameCommand);
		}

		#endregion


		#region Методы команд

		public void ExecuteStartGameCommand()
		{
			Logic.Start();
		}

		public void ExecuteContinueGameCommand()
		{
			Logic.ReStart();
		}

		

		public void ExecuteEndGameCommand()
		{
			Logic.Stop(true);
		}

		public bool CellClick(Point cellPos)
		{
			if (Logic.Turn(cellPos))
			{
				return true;
			}
			return false;
		}

	#endregion

		#region Обработчики событий

		private void RebuildBoard(object sender)
		{
			ReBoard = !ReBoard;
			OnPropertyChanged("Logic");
		}

		private void UpdateBoard(object sender)
		{
			UpBoard = !UpBoard;
			OnPropertyChanged("Logic");
		}

		private void OnGameStateChanged(object sender)
		{
			OnPropertyChanged("Logic");
		}



		#endregion

	}
}
