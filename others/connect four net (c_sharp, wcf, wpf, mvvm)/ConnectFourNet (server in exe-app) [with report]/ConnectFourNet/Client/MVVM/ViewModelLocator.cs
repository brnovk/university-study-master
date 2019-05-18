using System.Diagnostics.CodeAnalysis;
using ConnectNNet.Client.Models;
using ConnectNNet.Client.ViewModels;

namespace ConnectNNet.Client.MVVM
{
	/// <summary>
	/// This class contains static references to all the view models in the
	/// application and provides an entry point for the bindings.  ViewModels 
	/// are only created when first called.
	/// </summary>
	public class ViewModelLocator
	{
		#region Fields

		private static MainViewModel _main;
		private static GameViewModel _game;
		private static SettingsViewModel _settings;
		private static ISettingsModel Config { set; get; }

		#endregion

		#region Constructors

		/// <summary>
		/// Initializes a new instance of the ViewModelLocator class.
		/// </summary>
		static ViewModelLocator()
		{
			Config = new SettingsModel();
		}

		#endregion

		#region Properties

		/// <summary>
		/// Gets the Main property which defines the main viewmodel.
		/// </summary>
		[SuppressMessage("Microsoft.Performance",
			"CA1822:MarkMembersAsStatic",
			Justification = "This non-static member is needed for data binding purposes.")]
		public MainViewModel Main
		{
			get { return _main ?? (_main = new MainViewModel(Config)); }
		}

		public static GameViewModel Game
		{
			get { return _game ?? (_game = new GameViewModel(Config)); }
		}

		public static SettingsViewModel Settings
		{
			get { return _settings ?? (_settings = new SettingsViewModel(Game.Logic)); }
		}


		#endregion

	}
}