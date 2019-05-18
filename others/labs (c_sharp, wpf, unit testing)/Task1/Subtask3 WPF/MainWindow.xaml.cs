using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Text;
using System.Windows;

namespace Subtask3_WPF
{

    /// <summary>
    /// Класс логики взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {

        const string messageEmptyResult = "Не указано ни одной пары координат";
        const string errorMessageHeader = "Сообщение об ошибке";

        /// <summary>
        /// Общее сообщение об ошибке в исключительных ситуациях
        /// </summary>
        const string errorGeneralMessage = "В приложении возникла исключительная ситуация:"
                    + "\n\n{0}\n\nПожалуйста, проверьте корректность входных данных.";

        /// <summary>
        /// Путь к файлу
        /// </summary>
        private string pathToFile = string.Empty;

        public MainWindow()
        {
            InitializeComponent();
        }

        /// <summary>
        /// Обработчик нажатия кнопки "Задание".
        /// </summary>
        private void menuAboutButton_Click(object sender, RoutedEventArgs e)
        {

            const string aboutMessage =
                "Реализовать WPF приложение для чтения небольшого набора входных "
                + "данных, форматирования этих данных удобными "
                + "для чтения образом и отображения отформатированных результатов.\n"
                + "Данные представляют собой текст, содержащий пары чисел,"
                + "представляющие х и у-координаты объекта.\n"
                + "Каждая строка текста содержит один набор координат.\n"
                + "Пример типичного набора данных:\n"
                + "\t23.8976,12.3218\n"
                + "\t25.7639,11.9463\n"
                + "\t24.8293,12.2134\n"
                + "Эти данные в отформатированном виде:\n"
                + "\tX: 23,8976 Y: 12,3218\n"
                + "\tX: 25,7639 Y: 11,9463\n"
                + "\tX: 24,8293 Y: 12,2134\n"
                + "Предусмотреть 2 источника данных:\n"
                + " - ввод данных пользователем;\n - данные из текстового файла.";

            const string aboutMessageHeader = "Задание к работе №1, часть 3";

            MessageBox.Show(aboutMessage, aboutMessageHeader, MessageBoxButton.OK,
                MessageBoxImage.Information);
        }

        /// <summary>
        /// Обработчик нажатия кнопки "Форматировать данные из поля ввода"
        /// </summary>
        private void formatUserInputButton_Click(object sender, RoutedEventArgs e)
        {

            // Разделитель данных, введённых пользователем.
            const char userInputDataSplitter = '\n';

            // Очистка результирующего TextBox
            resultTextBox.Text = string.Empty;

            // Получение строки данных, введённых пользователем.
            var userInputData = userInputTextBox.Text;

            try
            {
                // Разделение полученной строки на коллекцию строк для обработки.
                var lines = userInputData.Split(userInputDataSplitter);

                // Получаем отформатированную строку для вывода
                var formattedResult = GetFormattedResult(lines);

                // Строка не пустая - выводим, иначе - сообщение о отсутствии данных.
                resultTextBox.Text = ((formattedResult != string.Empty)
                    ? formattedResult
                    : messageEmptyResult);
            }
            catch (SystemException ex)
            {
                MessageBox.Show(string.Format(errorGeneralMessage, ex.Message),
                    errorMessageHeader, MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        /// <summary>
        /// Обработчик нажатия кнопки "Форматировать данные из файла"
        /// </summary>
        private void formatFromFileButton_Click(object sender, RoutedEventArgs e)
        {

            const string emptyFileMessage = "Не указан файл-источник данных";

            // Очистка результирующего TextBox
            resultTextBox.Text = string.Empty;

            // Получения пути к файлу из поля в окне.
            pathToFile = pathFileTextBox.Text.Trim();

            // Если поле пустое, выводим сообщение об ошибке и выходим из метода.
            if (pathToFile == string.Empty)
            {
                MessageBox.Show(emptyFileMessage, errorMessageHeader,
                    MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }
            pathToFile = Path.GetFullPath(pathToFile);

            try
            {
                // Получаем коллекцию строк из файла
                var lines = GetDataFromFile(pathToFile);

                // Получаем отформатированную строку для вывода
                var formattedResult = GetFormattedResult(lines);

                // Строка не пустая - выводим, иначе - сообщение о отсутствии данных.
                resultTextBox.Text = ((formattedResult != string.Empty)
                    ? formattedResult
                    : messageEmptyResult);

            }
            catch (FileNotFoundException)
            {
                const string messageFileNotFoundException = "Указанный файл не найден.";
                MessageBox.Show(messageFileNotFoundException,
                    errorMessageHeader, MessageBoxButton.OK, MessageBoxImage.Error);
            }
            // Общий суперкласс исключений для исключений методов ReadLine() и Parse(),
            // а также исключений класса StreamReader.
            catch (SystemException ex)
            {
                MessageBox.Show(string.Format(errorGeneralMessage, ex.Message),
                    errorMessageHeader, MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        /// <summary>
        /// Обработчик нажатия кнопки "Выбрать файл"
        /// </summary>
        private void openFileButton_Click(object sender, RoutedEventArgs e)
        {
            OpenFileDialog openFileDialog = new OpenFileDialog();
            openFileDialog.Filter = "Text files (*.txt)|*.txt|All files (*.*)|*.*";
            openFileDialog.InitialDirectory =
                Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments);
            if (openFileDialog.ShowDialog() == true)
            {
                // Путь файла заносится в pathFileTextBox в окне приложения.
                pathFileTextBox.Text = openFileDialog.FileName;
            }
        }


        /// <summary>
        /// Метод получения коллекции строк из файла.
        /// </summary>
        private IList<string> GetDataFromFile(string pathToFile)
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
        private string GetFormattedResult(IList<string> sourceLines)
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
                if (currentValue.Trim() != string.Empty)
                {
                    var buffer = currentValue.Split(lineDelimeter);

                    float xCoordinate = Single.Parse(buffer[0], CultureInfo.InvariantCulture);
                    result.AppendFormat(OutputPatternPart1, xCoordinate.ToString(numberFormatInfo));

                    float yCoordinate = Single.Parse(buffer[1], CultureInfo.InvariantCulture);
                    result.AppendFormat(OutputPatternPart2, yCoordinate.ToString(numberFormatInfo));
                }
            }
            return result.ToString();
        }
    }
}
