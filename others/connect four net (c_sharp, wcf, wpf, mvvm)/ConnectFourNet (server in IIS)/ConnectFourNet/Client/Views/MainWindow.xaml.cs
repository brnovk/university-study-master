using System.ComponentModel;
using System.Windows;
using ConnectNNet.Client.MVVM;

namespace ConnectNNet.Client.Views
{
	/// <summary>
	/// Interaction logic for MainWindow.xaml
	/// </summary>
	public partial class MainWindow : Window
	{
		public MainWindow()
		{
			InitializeComponent();
			this.Closing += OnClosing;
		}

		private void OnClosing(object sender, CancelEventArgs e)
		{
			ViewModelLocator.Game.Logic.Stop();
		}
	}
}
