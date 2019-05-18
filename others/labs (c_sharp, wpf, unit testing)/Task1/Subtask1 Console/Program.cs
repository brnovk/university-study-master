using System;
using System.Collections.Generic;
using System.Globalization;
using System.Text;

namespace Subtask1_Console
{
    /// <summary>
    /// Разработать консольное приложение для чтения небольшого набора входных
    /// данных, форматирования этих данных удобным для чтения образом и отображения
    /// отформатированных результатов. Данные представляют собой текст, содержащий
    /// пары чисел, представляющие x и y-координаты месторасположения объекта.
    /// Каждая строка текста содержит один набор координат.
    /// 
    /// Пример входных данных:
    ///     23.8976,12.3218
    ///     25.7639,11.9463
    ///     24.8293,12.2134
    /// 
    /// Результат:
    ///     X: 23,8976 Y: 12,3218
    ///     X: 25,7639 Y: 11,9463
    ///     X: 24,8293 Y: 12,2134
    /// </summary>
    class Program
    {
        static void Main(string[] args)
        {
            const string resultTip = "\nРезультат:";
            const string messageEmptyResult = "Не указано ни одной пары координат.";
            const string messageException = "\nПриложение будет завершено из-за "
                + "возникшей исключительной ситуации:\n"
                + ">> {0}\n\nПожалуйста, проверьте корректность входных данных.";
            const string messageClose = "Нажмите любую клавишу для завершения...";

            try
            {
                // Получаем введённую пользователем коллекцию строк
                var lines = GetDataEnteredByUser();

                // Получаем отформатированную строку для вывода
                var formattedResult = GetFormattedResult(lines);
                Console.WriteLine(resultTip);

                // Строка не пустая - выводим, иначе - сообщение о отсутствии данных.
                Console.WriteLine((formattedResult != string.Empty)
                    ? formattedResult
                    : messageEmptyResult);
            }
            // Общий суперкласс исключений для исключений методов ReadLine() и Parse()
            catch (SystemException ex)
            {
                System.Console.WriteLine(messageException, ex.Message);
            }
            Console.WriteLine(messageClose);
            Console.ReadKey();
        }

        /// <summary>
        /// Метод получения коллекции строк, введённой пользователем.
        /// </summary>
        static IList<string> GetDataEnteredByUser()
        {
            const string topTip =
                "Введите одну или несколько пар координат, разделённых запятой.\n"
                + "Пример входных данных:\n"
                + "\t23.8976, 12.3218\n"
                + "\t24.8293, 12.2134\n"
                + "(CTRL+Z для завершения ввода)\n";
            const string lineTip = "> ";
            Console.WriteLine(topTip);

            var resultList = new List<string>();
            string bufferLine;
            do
            {
                Console.Write(lineTip);
                bufferLine = Console.ReadLine();
                // Если полученная строка нe null и не состоит из одних пробелов,
                // добавляем её в коллекцию.
                if ((bufferLine != null) && (bufferLine.Trim() != string.Empty))
                {
                    resultList.Add(bufferLine.Trim());
                }
            } while (bufferLine != null);
            return resultList;
        }

        /// <summary>
        /// Метод преобразования списка строк, содержащего пары координат,
        /// разделённых запятой в отформатированную строку вида 
        /// X: число Y: число
        /// X: число Y: число
        /// // more
        /// Десятичным разделителем результирующих вещественных чисел является запятая.
        /// Результирующая отформатированная строка предназначена для вывода в
        /// консоль, логгер, файл и т.п.
        /// </summary>
        /// <param name="sourceLines">
        ///     Список строк, содержащий пары координат, разделённые запятой.
        /// </param>
        /// <returns>Отформатированную строку.</returns>
        static string GetFormattedResult(IList<string> sourceLines)
        {
            const string OutputPatternPart1 = "X: {0, -15} ";
            const string OutputPatternPart2 = "Y: {0, -15}\n";
            const char lineDelimeter = ',';
            const string outDecimalSeparator = ",";

            var result = new StringBuilder();

            // Создание вспомогательно класса для форматирования вещественных чисел.
            // Требуется для изменения десятичного разделителя с точки на запятую.
            var numberFormatInfo = new NumberFormatInfo();
            numberFormatInfo.NumberDecimalSeparator = outDecimalSeparator;

            foreach (string currentValue in sourceLines)
            {
                var buffer = currentValue.Split(lineDelimeter);

                float xCoordinate = Single.Parse(buffer[0], CultureInfo.InvariantCulture);
                result.AppendFormat(OutputPatternPart1, xCoordinate.ToString(numberFormatInfo));

                float yCoordinate = Single.Parse(buffer[1], CultureInfo.InvariantCulture);
                result.AppendFormat(OutputPatternPart2, yCoordinate.ToString(numberFormatInfo));
            }
            return result.ToString();
        }
    }
}
