using System;
using System.Windows;

namespace Task3
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
                // Очистка поля рельтата (двоичного числа)
                textBoxBinaryNumber.Text = string.Empty;

                // Валидация параметра десятичного числа
                validation(textBoxDecimalNumber.Text);

                // Парсинг(извлечение из строки) десятичного числа
                var decimalNumber = long.Parse(textBoxDecimalNumber.Text);

                // Создание экземпляра класса конвертера и получение преобразование 
                // в строку двоичного значения.
                var converter = new DecimalToBinaryConverter();
                var binaryNumberString = converter.convert(decimalNumber);

                // Установка значения в поле двоичного числа
                textBoxBinaryNumber.Text = binaryNumberString;
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
        private void validation(string rawDecimalNumber)
        {

            const string messageEmpty = "Пустое поле десятичного числа";
            const string messageIllegalAndInvalidRange = "Значение в поле ввода "
                + "числа, для корректной работы алгоритма, "
                + "должно быть целым числом от {0} до {1}";

            // Проверка параметра на пустоту
            if (rawDecimalNumber.Trim() == string.Empty)
            {
                throw new ArgumentException(messageEmpty);
            }

            // Проверка параметра на преобразование из строки в число
            long decimalNumber;
            if (!long.TryParse(rawDecimalNumber, out decimalNumber))
            {
                throw new ArgumentException(string.Format(messageIllegalAndInvalidRange,
                    0, long.MaxValue));
            }

            // Проверка корректности диапазона
            if ((decimalNumber > long.MaxValue) || (decimalNumber < 0))
            {
                throw new ArgumentException(string.Format(messageIllegalAndInvalidRange,
                    0, long.MaxValue));
            }
        }

        /// <summary>
        /// Обработчик нажатия кнопки "Задание".
        /// </summary>
        private void menuAboutButton_Click(object sender, RoutedEventArgs e)
        {
            const string aboutMessage =
                "Разработать тип, позволяющий конвертировать неотрицательное\n"
                + "десятичное значение целого числа в строку,\n"
                + "содержащую двоичное представление этого значения.\n"
                + "В качестве UI-интерфейса использовать консольное приложение\n"
                + "с интерфейсом командной строки, WinForms или WPF-приложение.";
            const string aboutMessageHeader =
                "Задание к работе №3";
            MessageBox.Show(aboutMessage, aboutMessageHeader, MessageBoxButton.OK,
                MessageBoxImage.Information);
        }
    }
}
