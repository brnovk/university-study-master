using System;
using System.Globalization;
using System.Windows;
using System.Windows.Data;

namespace ConnectNNet.Client.Helpers
{
	public class BoolToVisibilityConverter : IValueConverter
	{
		public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
		{
			if (value is Boolean && (bool)value)
			{
				return Visibility.Visible;
			}
			return Visibility.Collapsed;
		}

		public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
		{
			return (value is Visibility && (Visibility)value == Visibility.Visible);
		}
	}
}
