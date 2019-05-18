using System;
using System.Collections.Generic;
using System.Globalization;
using System.Windows;

namespace Task5
{

    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {

        const string errorMessageHeader = "Сообщение об ошибке";
        const string errorGeneralMessage =
            "В приложении возникла исключительная ситуация:\n\n{0}";

        public MainWindow()
        {
            InitializeComponent();
        }

        /// <summary>
        /// Обработчик нажатия кнопки 
        /// "Проверить стороны на возможность существования треугольника".
        /// </summary>
        private void triangleExistButton_Click(object sender, RoutedEventArgs e)
        {
            const string messageExistHeader = "Сообщение о существовании треугольника";
            const string triangleExist = "Треугольник существует.";
            const string triangleDoNotExist = "Треугольник не существует, так как\n"
                + "сумма двух сторон меньше или равно третьей.";

            try
            {
                // Получение строк со сторонами треугольника из окна приложения
                var rawParameters = getStringParametersFromWindow();

                // Парсинг и валидация (проверка корректности) чисел из этих строк 
                var sideNumbers = parsingParameters(rawParameters);

                // Использование статического метода класса для проверки существования.
                // Вывод MessageBox с сообщением.
                if (Triangle.isTriangleExists(sideNumbers[0], sideNumbers[1], sideNumbers[2]))
                {
                    MessageBox.Show(triangleExist, messageExistHeader, MessageBoxButton.OK,
                        MessageBoxImage.Asterisk);
                }
                else
                {
                    MessageBox.Show(triangleDoNotExist, messageExistHeader, MessageBoxButton.OK,
                        MessageBoxImage.Warning);
                }

            }
            catch (SystemException ex)
            {
                MessageBox.Show(string.Format(errorGeneralMessage, ex.Message),
                    errorMessageHeader, MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        /// <summary>
        /// Обработчик нажатия кнопки "Вычислить периметер".
        /// </summary>
        private void calculatePerimeterButton_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                // Очистка поля периметра в окне приложения
                resultPerimeterTextBox.Text = string.Empty;

                // Получение строк со сторонами треугольника из окна приложения
                var rawParameters = getStringParametersFromWindow();

                // Парсинг и валидация (проверка корректности) чисел из этих строк
                var sideNumbers = parsingParameters(rawParameters);

                // Создание экземпляра класса треугольника
                Triangle triangle = new Triangle(sideNumbers[0], sideNumbers[1], sideNumbers[2]);

                // Создание вспомогательно класса для форматирования вещественных чисел.
                // Требуется для вывода десятичного разделителя точки в русской локали.
                var numberFormatInfo = new NumberFormatInfo();
                numberFormatInfo.NumberDecimalSeparator = ".";

                // Вычисление периметра и запись результата в поле окна
                resultPerimeterTextBox.Text = triangle.Perimeter().ToString(numberFormatInfo);
            }
            catch (SystemException ex)
            {
                MessageBox.Show(string.Format(errorGeneralMessage, ex.Message),
                    errorMessageHeader, MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        /// <summary>
        /// Обработчик нажатия кнопки "Вычислить площадь".
        /// </summary>
        private void calculateAreaButton_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                // Очистка поля площади в окне приложения
                resultAreaTextBox.Text = string.Empty;

                // Получение строк со сторонами треугольника из окна приложения
                var rawParameters = getStringParametersFromWindow();

                // Парсинг и валидация (проверка корректности) чисел из этих строк 
                var sideNumbers = parsingParameters(rawParameters);

                // Создание экземпляра класса треугольника
                Triangle triangle = new Triangle(sideNumbers[0], sideNumbers[1], sideNumbers[2]);

                // Создание вспомогательно класса для форматирования вещественных чисел.
                // Требуется для вывода десятичного разделителя точки в русской локали.
                var numberFormatInfo = new NumberFormatInfo();
                numberFormatInfo.NumberDecimalSeparator = ".";

                // Вычисление площади и запись результата в поле окна
                resultAreaTextBox.Text = triangle.Area().ToString(numberFormatInfo);
            }
            catch (SystemException ex)
            {
                MessageBox.Show(string.Format(errorGeneralMessage, ex.Message),
                    errorMessageHeader, MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        /// <summary>
        /// Метод получения коллекции строк, содержащих стороны треугольника,
        /// полученные в окне приложения.
        /// В случае, если сторона не указана, выбрасывается исключение.
        /// </summary>
        /// <returns>Коллекция строк, содержащая стороны треугольника</returns>
        private IList<string> getStringParametersFromWindow()
        {
            var rawParameters = new List<string>();

            // Если параметры не пустые, добавляем в коллекцию
            if (sideATextBox.Text.Trim() == string.Empty)
            {
                throw new ArgumentException("Сторона A треугольника не указана.");
            }
            rawParameters.Add(sideATextBox.Text);

            if (sideBTextBox.Text.Trim() == string.Empty)
            {
                throw new ArgumentException("Сторона B треугольника не указана.");
            }
            rawParameters.Add(sideBTextBox.Text);

            if (sideCTextBox.Text.Trim() == string.Empty)
            {
                throw new ArgumentException("Сторона C треугольника не указана.");
            }
            rawParameters.Add(sideCTextBox.Text);

            return rawParameters;
        }

        /// <summary>
        /// Метод получения коллекции чисел сторон треукгольника, из 
        /// коллекции строк, содержащей эти числа.
        /// В случае ошибки извечения числа или некорректности диапазона значений,
        /// выбрасывается исключение.
        /// </summary>
        private IList<double> parsingParameters(IList<string> rawParameters)
        {
            const string messageIllegalAndInvalidRange = "Значение в поле ввода "
                + "стороны, для корректной работы алгоритма, должно быть целым "
                + "или вещественным числом от {0} до {1}\n"
                + "Десятичный разделитель вещественного числа - точка.";

            var resultParameters = new List<double>();
            foreach (string currentRawNumber in rawParameters)
            {
                // Проверка параметра на преобразование из строки в число
                double currentNumber;
                if (!double.TryParse(currentRawNumber, NumberStyles.Float,
                    CultureInfo.InvariantCulture, out currentNumber))
                {
                    throw new ArgumentException(
                        string.Format(messageIllegalAndInvalidRange, 0, double.MaxValue));
                }

                // Проверка корректности диапазона
                if ((currentNumber > double.MaxValue) || (currentNumber < 0))
                {
                    throw new ArgumentException(
                        string.Format(messageIllegalAndInvalidRange, 0, double.MaxValue));
                }

                // Добавление извлечённого числа в коллекцию
                resultParameters.Add(currentNumber);
            }
            return resultParameters;
        }

        /// <summary>
        /// Обработчик нажатия кнопки "Задание".
        /// </summary>
        private void menuAboutButton_Click(object sender, RoutedEventArgs e)
        {
            const string aboutMessage =
                "Разработать класс «треугольник» для работы с треугольником, "
                + "заданным на плоскости сторонами сторонами a, b, c.\n\n"
                + "Предусмотреть возможность проверки существования треугольника,"
                + "реализовать функции подсчета его площади и периметра.\n\n"
                + "Создать unit-тесты для тестирования методов разработанного типа.\n\n"
                + "В качестве UI-интерфейса использовать консольное приложение\n"
                + "с интерфейсом командной строки, WinForms или WPF-приложение.";
            const string aboutMessageHeader =
                "Задание к работе №5";
            MessageBox.Show(aboutMessage, aboutMessageHeader, MessageBoxButton.OK,
                MessageBoxImage.Information);
        }
    }
}
