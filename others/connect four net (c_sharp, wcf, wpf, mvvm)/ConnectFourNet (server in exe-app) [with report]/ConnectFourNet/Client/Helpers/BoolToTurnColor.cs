using System;
using System.Globalization;
using System.Windows;
using System.Windows.Data;

namespace ConnectNNet.Client.Helpers
{
	public class BoolToTurnColor : IValueConverter
	{
		public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
		{
			if (value is Boolean && (bool) value)
			{
				return SystemColors.HighlightBrush;
			}
			return SystemColors.WindowColor;
		}

		public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
		{
			throw new NotImplementedException();
		}
	}
}
