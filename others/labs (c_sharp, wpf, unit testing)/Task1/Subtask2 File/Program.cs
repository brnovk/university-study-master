using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Text;

namespace Subtask2_File
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
    ///     
    /// Перенаправить ввод для запуска приложения с помощью текстового файла,
    /// содержащего данные, которые нужно отформатировать.
    /// </summary>
    class Program
    {
        static void Main(string[] args)
        {
            const string defaultFilePath = "data.txt";
            const string messageDefaultFile =
                "Аргументы коммандной строки отсутствуют или их больше двух.\n"
                + "Будет использован путь к файлу по-умолчанию:\n";
            const string messageArgParamFile =
                "Файл переданный в аргументах коммандной строки:\n";
            const string resultTip = "\nРезультат:";
            const string messageEmptyResult = "Не указано ни одной пары координат.";
            const string messageFileNotFoundException = "Указанный файл не найден.";
            const string messageGeneralException = "\nПриложение будет завершено из-за "
                + "возникшей исключительной ситуации:\n"
                + ">> {0}\n\nПожалуйста, проверьте корректность входных данных.";
            const string messageClose = "Нажмите любую клавишу для завершения...";

            string pathToFile;

            // Если в аргументах коммандной строки есть пусть к файлу, используем его
            if (args.Length == 1)
            {
                pathToFile = Path.GetFullPath(args[0]);
                Console.WriteLine(messageArgParamFile + pathToFile);
            }
            // Иначе - путь к файлу по-умолчанию
            else
            {
                pathToFile = Path.GetFullPath(defaultFilePath);
                Console.WriteLine(messageDefaultFile + pathToFile);
            }

            try
            {
                // Получаем коллекцию строк из файла
                var lines = GetDataFromFile(pathToFile);

                // Получаем отформатированную строку для вывода
                var formattedResult = GetFormattedResult(lines);
                Console.WriteLine(resultTip);

                // Строка не пустая - выводим, иначе - сообщение о отсутствии данных.
                Console.WriteLine((formattedResult != string.Empty)
                    ? formattedResult
                    : messageEmptyResult);

            }
            catch (FileNotFoundException ex)
            {
                System.Console.WriteLine(messageFileNotFoundException);
            }
            // Общий суперкласс исключений для исключений методов ReadLine() и Parse(),
            // а также исключений класса StreamReader.
            catch (SystemException ex)
            {
                System.Console.WriteLine(messageGeneralException, ex);
            }
            Console.WriteLine(messageClose);
            Console.ReadKey();
        }

        /// <summary>
        /// Метод получения коллекции строк из файла.
        /// </summary>
        static IList<string> GetDataFromFile(string pathToFile)
        {
            var resultList = new List<string>();
            using (var streamReader = new StreamReader(pathToFile))
            {
                while (streamReader.Peek() > -1)
                {
                    var currentLine = streamReader.ReadLine().Trim();
                    if (currentLine != string.Empty)
                    {
                        resultList.Add(currentLine);
                    }
                }
            }
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
