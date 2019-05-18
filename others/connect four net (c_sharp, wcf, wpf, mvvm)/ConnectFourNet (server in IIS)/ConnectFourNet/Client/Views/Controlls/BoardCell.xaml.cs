using System.Drawing;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Media;
using ConnectNNet.Client.MVVM;
using ConnectNNet.Client.Views;
using Color = System.Windows.Media.Color;
using ColorConverter = System.Windows.Media.ColorConverter;
using Image = System.Windows.Controls.Image;

namespace TicTacToeNet.Views.Controlls
{
	/// <summary>
	/// Interaction logic for BoardCell.xaml
	/// </summary>
	public partial class BoardCell : UserControl
	{

		#region Constructors

		/// <summary>Initializing constructor.</summary>
		public BoardCell()
		{
			InitializeComponent();
		}					

		#endregion Constructors

		#region Properties



		#endregion Properties

		#region Methods

		private void HandleMouseEnter(object sender, MouseEventArgs e)
		{
			BorderBrush = new SolidColorBrush((Color)ColorConverter.ConvertFromString("black"));
		}

		private void HandleMouseLeave(object sender, MouseEventArgs e)
		{
			BorderBrush = new SolidColorBrush((Color)ColorConverter.ConvertFromString("#FFAAAAAA"));
		}

		private void HandleMouseUp(object sender, MouseButtonEventArgs e)
		{
			if (GameScreen.PrewDrawCellB != null)
				return;
			BoardCell me = (sender is Image ? this : sender as BoardCell);
			if (me == null)
				return;
			ViewModelLocator.Game.CellClick((Point)me.Tag);
		}

		#endregion Methods

	}
}
