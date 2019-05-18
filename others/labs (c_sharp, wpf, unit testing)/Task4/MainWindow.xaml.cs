using System;
using System.Collections.Generic;
using System.Windows;

namespace Task4
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {

        const string errorMessageHeader = "Сообщение об ошибке";
        const string errorGeneralMessage =
            "В приложении возникла исключительная ситуация:\n\n{0}";

        private GCDHelper helper = new GCDHelper();

        public MainWindow()
        {
            InitializeComponent();
        }

        /// <summary>
        /// Обработчик нажатия кнопки "Выполнить" для 
        /// обычного алгоритма Евклида для 2 чисел.
        /// </summary>
        private void normalAlgForPairButton_Click(object sender, RoutedEventArgs e)
        {

            try
            {
                // Очистка полей результатов
                resultTextBox.Text = string.Empty;
                executionTimeTextBox.Text = string.Empty;

                // Валидация параметров
                validation(normalAlgForPairTextBox1.Text, normalAlgForPairTextBox2.Text);

                // Парсинг(извлечение из строки) значений
                var firstNumber = Int32.Parse(normalAlgForPairTextBox1.Text);
                var secondNumber = Int32.Parse(normalAlgForPairTextBox2.Text);

                // Вычисление НОД алгоритмом Евклида для 2 чисел
                var gcd = helper.calculateGCDEuclid(firstNumber, secondNumber);

                // Запись результата в поле окна
                resultTextBox.Text = gcd.ToString();

            }
            catch (SystemException ex)
            {
                MessageBox.Show(string.Format(errorGeneralMessage, ex.Message),
                    errorMessageHeader, MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        /// <summary>
        /// Обработчик нажатия кнопки "Выполнить" для 
        /// обычного алгоритма Евклида для 3, 4 и 5 чисел.
        /// </summary>
        private void normalAlgForManyButton_Click(object sender, RoutedEventArgs e)
        {
            const string errorLess3Param =
                "Для выполнения данной задачи требуется не менее 3 параметров";
            try
            {
                // Очистка полей результатов
                resultTextBox.Text = string.Empty;
                executionTimeTextBox.Text = string.Empty;

                // Коллекция для хранения строковых параметров, полученных из окна
                var rawParameters = new List<string>();

                // Получение не пустых полей из 5 полей окна
                if (normalAlgForManyTextBox1.Text.Trim() != string.Empty)
                {
                    rawParameters.Add(normalAlgForManyTextBox1.Text);
                }
                if (normalAlgForManyTextBox2.Text.Trim() != string.Empty)
                {
                    rawParameters.Add(normalAlgForManyTextBox2.Text);
                }
                if (normalAlgForManyTextBox3.Text.Trim() != string.Empty)
                {
                    rawParameters.Add(normalAlgForManyTextBox3.Text);
                }
                if (normalAlgForManyTextBox4.Text.Trim() != string.Empty)
                {
                    rawParameters.Add(normalAlgForManyTextBox4.Text);
                }
                if (normalAlgForManyTextBox5.Text.Trim() != string.Empty)
                {
                    rawParameters.Add(normalAlgForManyTextBox5.Text);
                }

                // Если параметров меньше 3 - бросаем исключение
                if (rawParameters.Count < 3)
                {
                    throw new ArgumentException(errorLess3Param);
                }

                // Валидация параметров
                validation(rawParameters.ToArray());

                // Парсинг значений строк коллекции и запись в коллекцию чисел.
                var parameters = new List<int>();
                foreach (string currentLine in rawParameters)
                {
                    parameters.Add(Int32.Parse(currentLine));
                }

                // Вычисление НОД алгоритмом Евклида для 3,4 или 5 чисел
                var gcd = helper.calculateGCDEuclid(parameters.ToArray());

                // Запись результата в поле окна
                resultTextBox.Text = gcd.ToString();
            }
            catch (SystemException ex)
            {
                MessageBox.Show(string.Format(errorGeneralMessage, ex.Message),
                    errorMessageHeader, MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        /// <summary>
        /// Обработчик нажатия кнопки "Выполнить" для 
        /// бинарного алгоритма Евклида (Стейна) для 2 чисел.
        /// </summary>
        private void binaryAlgForPairButton_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                // Очистка полей результатов
                resultTextBox.Text = string.Empty;
                executionTimeTextBox.Text = string.Empty;

                // Валидация параметров
                validation(binaryAlgForPairTextBox1.Text, binaryAlgForPairTextBox2.Text);

                // Парсинг(извлечение из строки) значений
                var firstNumber = Int32.Parse(binaryAlgForPairTextBox1.Text);
                var secondNumber = Int32.Parse(binaryAlgForPairTextBox2.Text);

                // Создание ссылки на объект класса для хранения времени выполнения алгоритма.
                // Ссылку будет передана в возвращаемом параметре метода вычисления.
                TimeSpan timeSpan;

                // Вычисление НОД алгоритмом Стейна для 2 чисел
                var gcd = helper.calculateBinaryGCD(firstNumber, secondNumber, out timeSpan);

                // Запись результата вычисления в поле окна
                resultTextBox.Text = gcd.ToString();

                // Запись времени выполнения алгоритма в соответствующее поле окна
                executionTimeTextBox.Text = String.Format("s:{0:00}, ms:{1:00}, ns:{2:000000}",
                    timeSpan.TotalSeconds,
                    timeSpan.TotalMilliseconds,
                    timeSpan.TotalMilliseconds * 1000000);
            }
            catch (SystemException ex)
            {
                MessageBox.Show(string.Format(errorGeneralMessage, ex.Message),
                    errorMessageHeader, MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        /// <summary>
        /// Метод валидации(проверки корректности) данных, введённых пользователем
        /// </summary>
        /// <param name="rawDecimalNumber">
        ///     Любое количество строк, содержащих целые числа
        /// </param>
        private void validation(params string[] rawNumbers)
        {
            const string messageEmpty = "Пустое поле ввода числа";
            const string messageIllegalAndInvalidRange = "Значение в поле ввода "
                + "числа, для корректной работы алгоритма, "
                + "должно быть целым числом больше {0} и меньше {1}";

            foreach (string currentRawNumber in rawNumbers)
            {
                // Проверка параметра на пустоту
                if (currentRawNumber.Trim() == string.Empty)
                {
                    throw new ArgumentException(messageEmpty);
                }

                // Проверка параметра на преобразование из строки в число
                long currentNumber;
                if (!long.TryParse(currentRawNumber, out currentNumber))
                {
                    throw new ArgumentException(
                        string.Format(messageIllegalAndInvalidRange, 0, Int32.MaxValue));
                }

                // Проверка корректности диапазона
                if ((currentNumber > Int32.MaxValue) || (currentNumber <= 0))
                {
                    throw new ArgumentException(
                        string.Format(messageIllegalAndInvalidRange, 0, Int32.MaxValue));
                }
            }
        }

        /// <summary>
        /// Обработчик нажатия кнопки "Задание".
        /// </summary>
        private void menuAboutButton_Click(object sender, RoutedEventArgs e)
        {
            const string aboutMessage =
                "Разработать тип, реализующий алгоритм Евклида\n"
                + "для вычисления НОД двух целых.\n\n"
                + "Добавить к разработанному типу дополнительную функциональность "
                + "в виде перегруженных методов вычисления НОД для трех, "
                + "четырех или пяти целых чисел.\n\n"
                + "Добавить к разработанному типу метод, реализующий\n"
                + "алгоритм Стейна (бинарный алгоритм Эвклида) для расчета НОД двух"
                + "целых чисел. Метод должен принимать выходной параметр, содержащий"
                + "значение времени, необходимое для выполнения расчетов.\n\n"
                + "В качестве UI-интерфейса использовать консольное приложение\n"
                + "с интерфейсом командной строки, WinForms или WPF-приложение.";
            const string aboutMessageHeader =
                "Задание к работе №4";
            MessageBox.Show(aboutMessage, aboutMessageHeader, MessageBoxButton.OK,
                MessageBoxImage.Information);
        }
    }
}
