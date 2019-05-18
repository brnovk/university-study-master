using System;
using System.Windows.Forms;
using System.Runtime.Remoting.Channels.Ipc;

namespace ClientApplication
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            if (!CheckingDLLFiles())
            {
                if (MessageBox.Show("В папке с програмой отсутствуют файлы плагинов!\n" 
                        + "Приложение будет завершено",
                        Application.ProductName, MessageBoxButtons.OK,
                        MessageBoxIcon.Error) == DialogResult.OK)
                    Application.Exit();
                else
                    Application.Exit();
            }
            MainFunc();
        }

        ClassLibrary1.Class1 service1;
        ClassLibrary2.Class2 service2;
        ClassLibrary3.Class3 service3;

        public void MainFunc()
        {
            // Создаём каналы
            IpcChannel channel1 = new IpcChannel();
            IpcChannel channel2 = new IpcChannel();
            IpcChannel channel3 = new IpcChannel();

            // Регистрируем канал.
            System.Runtime.Remoting.Channels.ChannelServices.
                RegisterChannel(channel1, false);

            // Регистрируем клиентские удалённые обьекты.
            System.Runtime.Remoting.WellKnownClientTypeEntry remoteType1 =
                new System.Runtime.Remoting.WellKnownClientTypeEntry(
                    typeof(ClassLibrary1.Class1),
                    "ipc://localhost:9090/RemoteObject1.rem");

            System.Runtime.Remoting.WellKnownClientTypeEntry remoteType2 =
                new System.Runtime.Remoting.WellKnownClientTypeEntry(
                    typeof(ClassLibrary2.Class2),
                    "ipc://localhost:9090/RemoteObject2.rem");

            System.Runtime.Remoting.WellKnownClientTypeEntry remoteType3 =
                new System.Runtime.Remoting.WellKnownClientTypeEntry(
                    typeof(ClassLibrary3.Class3),
                    "ipc://localhost:9090/RemoteObject3.rem");

            System.Runtime.Remoting.RemotingConfiguration.
                RegisterWellKnownClientType(remoteType1);
            System.Runtime.Remoting.RemotingConfiguration.
                RegisterWellKnownClientType(remoteType2);
            System.Runtime.Remoting.RemotingConfiguration.
                RegisterWellKnownClientType(remoteType3);

            // Создаём приемники сообщений
            string objectUri;
            System.Runtime.Remoting.Messaging.IMessageSink messageSink1 =
                channel1.CreateMessageSink(
                    "ipc://localhost:9090/RemoteObject1.rem", null,
                    out objectUri);
            System.Runtime.Remoting.Messaging.IMessageSink messageSink2 =
                 channel2.CreateMessageSink(
                     "ipc://localhost:9090/RemoteObject2.rem", null,
                     out objectUri);
            System.Runtime.Remoting.Messaging.IMessageSink messageSink3 =
                 channel3.CreateMessageSink(
                     "ipc://localhost:9090/RemoteObject3.rem", null,
                     out objectUri);

            // Создание экземпляра удаленного объекта
            service1 = new ClassLibrary1.Class1();
            service2 = new ClassLibrary2.Class2();
            service3 = new ClassLibrary3.Class3();

            return;
        }

        public bool CheckingDLLFiles()
        {
            if ((System.IO.File.Exists("ClassLibrary1.dll")) &&
               (System.IO.File.Exists("ClassLibrary2.dll")) &&
               (System.IO.File.Exists("ClassLibrary3.dll")))
                return true;
            else
                return false;
        }

        /// <summary>
        /// Кнопка "Выполнить" во вкладке "Сложение строк"
        /// </summary>
        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                textBox3.Text = service1.FoldString(textBox1.Text, textBox2.Text);
            }
            catch (Exception)
            { textBox3.Text = "Не удалось выполнить метод из ClassLibrary1.dll"; }
        }

        /// <summary>
        /// Кнопка "Выполнить" во вкладке "Перевод и строчных букв в прописные"
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void button3_Click(object sender, EventArgs e)
        {
            try
            {
                textBox5.Text = service2.Shift(textBox4.Text);
            }
            catch (Exception)
            { textBox5.Text = "Не удалось выполнить метод из ClassLibrary2.dll"; }
        }

        /// <summary>
        /// Кнопка "Выполнить" во вкладке "Замена одной подстроки другой"
        /// </summary>
        private void button5_Click(object sender, EventArgs e)
        {
            try
            {
                textBox8.Text = service3.ReplacingSubstring(textBox6.Text, 
                    textBox7.Text, textBox6.SelectionStart, textBox6.SelectionLength);
            }
            catch (Exception)
            { textBox8.Text = "Не удалось выполнить метод из ClassLibrary2.dll"; }
        }

        /// <summary>
        /// Кнопка "О плагине" во вкладке "Сложение строк"
        /// </summary>
        private void button2_Click(object sender, EventArgs e)
        {
            try
            {
                MessageBox.Show(service1.AppointmentPlugin());
            }
            catch (Exception)
            { MessageBox.Show("Не удалось выполнить метод из ClassLibrary1.dll"); }
        }

        /// <summary>
        /// Кнопка "О плагине" во вкладке "Перевод и строчных букв в прописные"
        /// </summary>
        private void button4_Click(object sender, EventArgs e)
        {
            try
            {
                MessageBox.Show(service2.AppointmentPlugin());
            }
            catch (Exception)
            { MessageBox.Show("Не удалось выполнить метод из ClassLibrary2.dll"); }
        }

        /// <summary>
        /// Кнопка "О плагине" во вкладке "Замена одной подстроки другой"
        /// </summary>
        private void button6_Click(object sender, EventArgs e)
        {
            try
            {
                MessageBox.Show(service3.AppointmentPlugin());
            }
            catch (Exception)
            { MessageBox.Show("Не удалось выполнить метод из ClassLibrary3.dll"); }
        }

        private void оПланинеClassLibrary1ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            button2_Click(sender, e);
        }

        private void оПланинеClassLibrary2ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            button4_Click(sender, e);
        }

        private void оПланинеClassLibrary3ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            button6_Click(sender, e);
        }

        private void выходToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void оПрограммеToolStripMenuItem_Click(object sender, EventArgs e)
        {
            MessageBox.Show("Практическая работа №2; \n" +
                "Тема:\n  \"Технология удаленного вызова объектов .NET Remoting\";\n" +
                "Выполнил:\n  студент группы ПОИТ-31, Баранов В.Ф;\n" +
                "Вариант №5; \nПриложение:\n  \"Редактор строки\"\n", "О программе",
                MessageBoxButtons.OK, MessageBoxIcon.Information);
        }
    }
}
