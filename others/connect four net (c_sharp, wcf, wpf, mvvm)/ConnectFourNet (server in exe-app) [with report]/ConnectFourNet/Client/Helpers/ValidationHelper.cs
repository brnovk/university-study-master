using System.Text;
using System.Text.RegularExpressions;

namespace ConnectNNet.Client.Helpers
{
	/// <summary>
	/// Contains static methods for validation properies of view models.
	/// </summary>
	public static class ValidationHelper
	{
		/// <summary>
		/// The sign of marker.
		/// </summary>
		const string Marker = "● ";



		/// <summary>
		/// Checks whether the length of value in the specified range.
		/// </summary>
		/// <param name="propName">Name of the property.</param>
		/// <param name="value">The value.</param>
		/// <param name="errorContainer">The error container.</param>
		/// <param name="maxSize">The maximum length.</param>
		/// <param name="minSize">The minimum length.</param>
		/// <param name="needMark">if set to <c>true</c> then appent mark to start of error message.</param>
		public static void InRange(string propName, string value, StringBuilder errorContainer, 
			int maxSize, int minSize = 0, bool needMark = true)
		{
			if (!string.IsNullOrEmpty(value) && (value.Length > maxSize || value.Length < minSize))
				errorContainer.AppendLine(string.Format((needMark ? Marker : "") +
					"Длина поля «{0}» должна быть в пределах диапазона от {2} до {1} символов.", propName, maxSize, minSize));
		}

		/// <summary>
		/// Checks whether satisfies value to regular expression.
		/// </summary>
		/// <param name="propName">Name of the property.</param>
		/// <param name="value">The value.</param>
		/// <param name="errorContainer">The error container.</param>
		/// <param name="expr">The regular expression.</param>
		public static void RegularExpression(string propName, string value, StringBuilder errorContainer, string expr)
		{
			if (value != null)
			{
				Regex regex = new Regex("(" + expr + ")|(^$)");
				Match match = regex.Match(value);
				if (!match.Success)
					errorContainer.AppendLine(string.Format(Marker + 
						"Поле «{0}» содержит запрещенные символы (можно использовать цифры и латинские буквы, первый символ - буква).",
						propName));
			}
		}
	}
}
