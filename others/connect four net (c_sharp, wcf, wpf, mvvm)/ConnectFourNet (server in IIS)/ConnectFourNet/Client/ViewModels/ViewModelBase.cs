using System;
using System.ComponentModel;
using System.Windows;

namespace ConnectNNet.Client.ViewModels
{

	/// <summary>
	/// Contains common parts of view models.
	/// </summary>
	public class ViewModelBase : INotifyPropertyChanged
	{
		#region Fields

		/// <summary>
		/// Notifies UI about the changes of model properties. 
		/// </summary>
		public event PropertyChangedEventHandler PropertyChanged;

		private bool _controlsEnabled;
		private Visibility _loadImageVisibility;
		private string _errorMsg;
		private Visibility _errorVisibility;

		#endregion

		#region Constructors

		/// <summary>
		/// Initializes a new instance of the <see cref="ViewModelBase"/> class.
		/// </summary>
		public ViewModelBase()
		{
			LoadImageVisibility = Visibility.Hidden;
			ErrorVisibility = Visibility.Hidden;
			Message = null;
		}

		#endregion

		#region Properties

		/// <summary>
		/// Gets or sets the message (id, name, etc...) for view models.
		/// </summary>
		public string Message { set; get; }

		/// <summary>
		/// Gets or sets a flag of enable state of view controls.
		/// </summary>
		public bool ControlsEnabled
		{
			get { return _controlsEnabled; }
			set
			{
				_controlsEnabled = value;
				OnPropertyChanged("ControlsEnabled");
			}
		}

		/// <summary>
		/// Gets or sets the load animation visibility.
		/// </summary>
		/// <value>
		/// The load animation visibility.
		/// </value>
		public Visibility LoadImageVisibility
		{
			get { return _loadImageVisibility; }
			set
			{
				_loadImageVisibility = value;
				ControlsEnabled = _loadImageVisibility == Visibility.Hidden;	
				OnPropertyChanged("LoadImageVisibility");
			}
		}

		/// <summary>
		/// Gets or sets the error message (Used at a model validation).
		/// </summary>
		public string ErrorMsg
		{
			get { return _errorMsg; }
			set
			{
				_errorMsg = value;
				ErrorVisibility = string.IsNullOrEmpty(value)
					? Visibility.Hidden
					: Visibility.Visible;
				OnPropertyChanged("ErrorMsg");
			}
		}

		/// <summary>
		/// Gets the error message visibility.
		/// </summary>
		public Visibility ErrorVisibility
		{
			get { return _errorVisibility; }
			private set
			{
				_errorVisibility = value;
				OnPropertyChanged("ErrorVisibility");
			}
		}

		#endregion

		#region Methods

		/// <summary>
		/// Called when property changed.
		/// </summary>
		/// <param name="propertyName">Name of the property.</param>
		protected virtual void OnPropertyChanged(string propertyName)
		{
			if (PropertyChanged != null)
			{
				PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
			}
		}

		/// <summary>
		/// Updates the data of veiw model.
		/// </summary>
		public virtual void UpdateData()
		{
			ErrorMsg = "";
			LoadImageVisibility = Visibility.Visible;
		}

		/// <summary>
		/// Callback of request for update data.
		/// </summary>
		protected virtual void UpdateDataCallBack()
		{
			LoadImageVisibility = Visibility.Hidden;
		}

		/// <summary>
		/// Callback of request for update data.
		/// </summary>
		/// <param name="ar">Sate of asynchronous operation</param>
		protected virtual void UpdateDataCallBack(IAsyncResult ar)
		{
			UpdateDataCallBack();
		}

		#endregion
	}
}
