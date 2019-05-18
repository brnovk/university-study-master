using System;
using System.Windows.Input;

namespace ConnectNNet.Client.MVVM
{
	/// <summary>
	/// Implementation of interface commands used by MVVM for binding of view controls and view model methods.
	/// </summary>
	public class RelayCommand : ICommand
	{
		/// <summary>
		/// Command delegate.
		/// </summary>
		private readonly Action<object> _execute;

		private readonly Action _executeWithoutParam;

		/// <summary>
		/// Delegate for checking posibility of command execution. 
		/// </summary>
		private readonly Func<object, bool> _canExecute;

		/// <summary>
		/// Initializes a new instance of the <see cref="RelayCommand"/> class.
		/// </summary>
		/// <param name="execute">The command delegate.</param>
		/// <param name="canExecute">The check delegate.</param>
		/// <exception cref="System.ArgumentNullException">execute;Execute cannot be null.</exception>
		public RelayCommand(Action<object> execute, Func<object, bool> canExecute = null)
		{
			if (execute == null)
			{
				throw new ArgumentNullException("execute", "Execute cannot be null.");
			}
			_execute = execute;
			_executeWithoutParam = null;
			_canExecute = canExecute;
		}

		public RelayCommand(Action execute, Func<object, bool> canExecute = null)
		{
			if (execute == null)
			{
				throw new ArgumentNullException("execute", "Execute cannot be null.");
			}
			_execute = null;
			_executeWithoutParam = execute;
			_canExecute = canExecute;
		}

		/// <summary>
		/// Occurs when changes occur that affect whether or not the command should execute.
		/// </summary>
		public event EventHandler CanExecuteChanged
		{
			add { CommandManager.RequerySuggested += value; }
			remove { CommandManager.RequerySuggested -= value; }
		}

		/// <summary>
		/// Defines the method to be called when the command is invoked.
		/// </summary>
		/// <param name="parameter">Data used by the command.  If the command does not require data to be passed, this object can be set to null.</param>
		public void Execute(object parameter = null)
		{
			if (_execute != null)
				_execute(parameter);
			if (_executeWithoutParam != null)
				_executeWithoutParam();
		}

		/// <summary>
		/// Defines the method that determines whether the command can execute in its current state.
		/// </summary>
		/// <param name="parameter">Data used by the command.  If the command does not require data to be passed, this object can be set to null.</param>
		/// <returns>
		/// true if this command can be executed; otherwise, false.
		/// </returns>
		public bool CanExecute(object parameter)
		{
			if (_canExecute == null)
			{
				return true;
			}
			return _canExecute(parameter);
		}
	}
}
