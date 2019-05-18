using System.IO;
using System.Reflection;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;

namespace Pochasovka
{
    /// <summary>
    /// Логика взаимодействия для PasswordWindow.xaml
    /// </summary>
    public partial class PasswordWindow : Window
    {
        const string editPassword = "Введите новый пароль:";
        const string inputPassword = "Введите пароль:";

        /// <summary>
        /// Путь к каталогу, в котором находится exe-файл программы + AppData
        /// </summary>
        private string passwordFilePatch = 
            (new FileInfo(Assembly.GetEntryAssembly().Location)).Directory.ToString() + "/AppData/";
        private string passwordFileName = "password";

        /// <summary>
        /// Флаг указывающий на назначение этого окна - ввод пароля при старте программы или 
        /// изменение пароля в процессе работы
        /// </summary>
        private bool isEdit;

        public PasswordWindow(bool isEdit)
        {
            this.isEdit = isEdit;
            InitializeComponent();
            label.Content = (isEdit) ? editPassword : inputPassword;

            // Если файла с паролем не существует, создаётся новый файл с пустым паролем
            if (!File.Exists(passwordFilePatch + passwordFileName)) {
                if (!Directory.Exists(passwordFilePatch))
                {
                    Directory.CreateDirectory(passwordFilePatch);
                }
                File.Create(passwordFilePatch + passwordFileName);
            }
            // Изменение Title окна
            Title = (isEdit) ? "Редактирование пароля" : "Введите пароль для входа";
        }

        /// <summary>
        /// Клик по кнопке Ок.
        /// </summary>
        private void button_Click(object sender, RoutedEventArgs e)
        {
            if (isEdit)
            {
                changePassword();
                Close();
            } else
            {
                if (checkPassword())
                {
                    Close();
                }
                else
                {
                    label.Content = "Некорректный пароль";
                }
            }

        }

        /// <summary>
        /// Клик по кнопке отмена
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void button1_Click(object sender, RoutedEventArgs e)
        {
            if (isEdit)
            {
                Close();
            }
            else
            {
                Application.Current.Shutdown();
            }
        }

        /// <summary>
        /// Клик проверка введённого пароля на идентичность с сохранённым в файле
        /// </summary>
        /// <returns></returns>
        private bool checkPassword()
        {
            string input = textBox.Text.Trim();
            string pass = File.ReadAllText(passwordFilePatch + passwordFileName).Trim();
            return input == pass;
        }

        /// <summary>
        /// Изменение пароля в файле
        /// </summary>
        private void changePassword()
        {
            File.WriteAllText(passwordFilePatch + passwordFileName, textBox.Text.Trim());
            MessageBox.Show("Пароль \"" + File.ReadAllText(passwordFilePatch + passwordFileName).Trim() + "\"успешно установлен.");
        }

        /// <summary>
        /// Обработка нажатия Enter в поле ввода (Нажатие кнопки Ок)
        /// </summary>
        private void textBox_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Return)
            {
                button.RaiseEvent(new RoutedEventArgs(Button.ClickEvent));
            }
        }
    }
}
