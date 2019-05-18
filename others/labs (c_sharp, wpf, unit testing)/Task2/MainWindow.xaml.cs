using System;
using System.Globalization;
using System.Windows;

namespace Task2
{

    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {

        public MainWindow()
        {
            InitializeComponent();
        }

        /// <summary>
        /// Обработчик нажатия кнопки "Вычислить".
        /// </summary>
        private void buttonCalculate_Click(object sender, RoutedEventArgs e)
        {

            try
            {
                // Очистка поля результата
                textBoxResult.Text = string.Empty;

                // Валидация данных, введённых пользователем
                validation(textBoxNumber.Text, textBoxDegree.Text, textBoxAccuracy.Text);

                // Парсинг(извлечение из строки) числа, степени и точности
                var number = Single.Parse(textBoxNumber.Text, CultureInfo.InvariantCulture);
                var degree = Int32.Parse(textBoxDegree.Text);
                var accuracy = Single.Parse(textBoxAccuracy.Text, CultureInfo.InvariantCulture);

                // Создание экземпляра класса вычисления и получение корня
                var nthRoot = new NthRootNewton();
                var resultRoot = nthRoot.calculate(number, degree, accuracy);

                // Создание вспомогательно класса для форматирования вещественных чисел.
                // Требуется для вывода десятичного разделителя точки в русской локали.
                var numberFormatInfo = new NumberFormatInfo();
                numberFormatInfo.NumberDecimalSeparator = ".";

                // Установка значения в поле результата
                textBoxResult.Text = resultRoot.ToString(numberFormatInfo);

            }
            catch (SystemException ex)
            {
                string errorMessageHeader = "Сообщение об ошибке";
                string errorGeneralMessage = "В приложении возникла исключительная ситуация:"
                    + "\n\n{0}";
                MessageBox.Show(string.Format(errorGeneralMessage, ex.Message),
                    errorMessageHeader, MessageBoxButton.OK, MessageBoxImage.Error);
            }

        }

        /// <summary>
        /// Метод валидации(проверки корректности) данных, введённых пользователем
        /// </summary>
        /// <param name="rawNumber">Строка, содержащая число</param>
        /// <param name="rawDegree">Строка, содержащая степень</param>
        /// <param name="rawAccuracy">Строка, содержащая точность</param>
        private void validation(string rawNumber, string rawDegree, string rawAccuracy)
        {

            const string messageNumberEmpty = "Пустое поле \"Число\"";
            const string messageDegreeEmpty = "Пустое поле \"Степень\"";
            const string messageAccuracyEmpty = "Пустое поле \"Точность\"";

            const string messageNumberIllegal = "Значение в поле \"Число\" должно "
                + "быть целым или вещественным числом.\n"
                + "Десятичный разделитель вещественного числа - точка.";
            const string messageDegreeIllegal = "Значение в поле \"Степень\" должно "
                + "быть положительным целым числом.";
            const string messageAccuracyIllegal = "Значение в поле \"Точность\" должно "
                + "быть положительным целым или вещественным числом.\n"
                + "Десятичный разделитель вещественного числа - точка.";

            const string messageNumberInvalidRange = "Значение в поле \"Число\" должно"
                + " быть\nне больше {0} и не меньше {1}";
            const string messageDegreeInvalidRange = "Значение в поле \"Степень\" должно"
                + " быть\nне больше {0} и не меньше {1}";
            const string messageAccuracyInvalidRange = "Значение в поле \"Точность\" должно"
                + " быть\nне больше {0} и не меньше {1}";

            // Проверка параметров на пустоту
            if (rawNumber.Trim() == string.Empty)
            {
                throw new ArgumentException(messageNumberEmpty);
            }
            if (rawDegree.Trim() == string.Empty)
            {
                throw new ArgumentException(messageDegreeEmpty);
            }
            if (rawAccuracy.Trim() == string.Empty)
            {
                throw new ArgumentException(messageAccuracyEmpty);
            }

            // Проверка параметров на преобразование из строк в числа
            double number;
            if (!double.TryParse(rawNumber, NumberStyles.Float,
                    CultureInfo.InvariantCulture, out number))
            {
                throw new ArgumentException(messageNumberIllegal);
            }
            int degree;
            if (!Int32.TryParse(rawDegree, out degree))
            {
                throw new ArgumentException(messageDegreeIllegal);
            }
            double accuracy;
            if (!double.TryParse(rawAccuracy, NumberStyles.Float,
                    CultureInfo.InvariantCulture, out accuracy))
            {
                throw new ArgumentException(messageAccuracyIllegal);
            }

            // Проверка корректности диапазонов
            if ((number > long.MaxValue) || (number < long.MinValue))
            {
                throw new ArgumentException(string.Format(messageNumberInvalidRange,
                        long.MaxValue, long.MinValue));
            }
            if ((degree > int.MaxValue) || (degree < 1))
            {
                throw new ArgumentException(string.Format(messageDegreeInvalidRange,
                        int.MaxValue, 1));
            }
            if ((accuracy > int.MaxValue) || (accuracy < 0))
            {
                throw new ArgumentException(string.Format(messageAccuracyInvalidRange,
                        int.MaxValue, 0));
            }
        }

        /// <summary>
        /// Обработчик нажатия кнопки "Задание".
        /// </summary>
        private void menuAboutButton_Click(object sender, RoutedEventArgs e)
        {
            const string aboutMessage =
                "Разработать тип, позволяющий вычислять корень n-ой степени из\n"
                + "числа методом Ньютона с заданной точностью.\n"
                + "В качестве UI-интерфейса использовать консольное приложение\n"
                + "с интерфейсом командной строки, WinForms или WPF-приложение.";
            const string aboutMessageHeader =
                "Задание к работе №2";
            MessageBox.Show(aboutMessage, aboutMessageHeader, MessageBoxButton.OK,
                MessageBoxImage.Information);
        }
    }
}
