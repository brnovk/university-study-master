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
                if (MessageBox.Show("В папке с програмой отсутствуют файлы плагинов!" 
                    + "\nПриложение будет завершено",
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
        ClassLibrary4.Class4 service4;
        ClassLibrary5.Class5 service5;

        public void MainFunc()
        {
            // Создаём каналы
            IpcChannel channel1 = new IpcChannel();
            IpcChannel channel2 = new IpcChannel();
            IpcChannel channel3 = new IpcChannel();
            IpcChannel channel4 = new IpcChannel();
            IpcChannel channel5 = new IpcChannel();

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

            System.Runtime.Remoting.WellKnownClientTypeEntry remoteType4 =
                new System.Runtime.Remoting.WellKnownClientTypeEntry(
                    typeof(ClassLibrary4.Class4),
                    "ipc://localhost:9090/RemoteObject4.rem");

            System.Runtime.Remoting.WellKnownClientTypeEntry remoteType5 =
                new System.Runtime.Remoting.WellKnownClientTypeEntry(
                    typeof(ClassLibrary5.Class5),
                    "ipc://localhost:9090/RemoteObject5.rem");

            System.Runtime.Remoting.RemotingConfiguration.
                RegisterWellKnownClientType(remoteType1);
            System.Runtime.Remoting.RemotingConfiguration.
                RegisterWellKnownClientType(remoteType2);
            System.Runtime.Remoting.RemotingConfiguration.
                RegisterWellKnownClientType(remoteType3);
            System.Runtime.Remoting.RemotingConfiguration.
                RegisterWellKnownClientType(remoteType4);
            System.Runtime.Remoting.RemotingConfiguration.
                RegisterWellKnownClientType(remoteType5);

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
            System.Runtime.Remoting.Messaging.IMessageSink messageSink4 =
                 channel4.CreateMessageSink(
                      "ipc://localhost:9090/RemoteObject4.rem", null,
                     out objectUri);
            System.Runtime.Remoting.Messaging.IMessageSink messageSink5 =
                 channel5.CreateMessageSink(
                      "ipc://localhost:9090/RemoteObject5.rem", null,
                     out objectUri);

            // Создание экземпляра удаленного объекта
            service1 = new ClassLibrary1.Class1();
            service2 = new ClassLibrary2.Class2();
            service3 = new ClassLibrary3.Class3();
            service4 = new ClassLibrary4.Class4();
            service5 = new ClassLibrary5.Class5();

            return;
        }

        public bool CheckingDLLFiles()
        {
            if ((System.IO.File.Exists("ClassLibrary1.dll")) &&
               (System.IO.File.Exists("ClassLibrary2.dll")) &&
               (System.IO.File.Exists("ClassLibrary3.dll"))&&
               (System.IO.File.Exists("ClassLibrary4.dll"))&&
               (System.IO.File.Exists("ClassLibrary5.dll")))
                return true;
            else
                return false;
        }

        private void aboutToolStripMenuItem_Click(object sender, EventArgs e)
        {
            MessageBox.Show("Практическая работа №2; \n" +
                "Тема:\n  \"Технология удаленного вызова объектов .NET Remoting\";\n" +
                "Выполнил:\n  студент группы ПОИТ-31, _student_name;\n" +
                "Вариант №13; \nПриложение:\n  \"Конвертер единиц длины\"\n", "О программе",
                MessageBoxButtons.OK, MessageBoxIcon.Information);
        }

        private void exitToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                textBox2.Text = service1.MetersToKilometers(textBox1.Text);
            }
            catch (Exception)
            {
                textBox2.Text = "Не удалось выполнить метод из ClassLibrary1.dll";
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            try
            {
                textBox4.Text = service2.MetersToMiles(textBox3.Text);
            }
            catch (Exception)
            {
                textBox4.Text = "Не удалось выполнить метод из ClassLibrary2.dll";
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            try
            {
                textBox6.Text = service3.MetersToYards(textBox5.Text);
            }
            catch (Exception)
            {
                textBox6.Text = "Не удалось выполнить метод из ClassLibrary3.dll";
            }
        }

        private void button4_Click(object sender, EventArgs e)
        {
            try
            {
                textBox8.Text = service4.MetersToFeet(textBox7.Text);
            }
            catch (Exception)
            {
                textBox8.Text = "Не удалось выполнить метод из ClassLibrary4.dll";
            }
        }

        private void button5_Click(object sender, EventArgs e)
        {
            try
            {
                textBox10.Text = service5.MetersToInches(textBox9.Text);
            }
            catch (Exception)
            {
                textBox10.Text = "Не удалось выполнить метод из ClassLibrary5.dll";
            }
        }

        private void button6_Click(object sender, EventArgs e)
        {
            try
            {
                MessageBox.Show(service1.AppointmentPlugin());
            }
            catch (Exception)
            {
                MessageBox.Show("Не удалось выполнить метод из ClassLibrary1.dll");
            }
        }

        private void button7_Click(object sender, EventArgs e)
        {
            try
            {
                MessageBox.Show(service2.AppointmentPlugin());
            }
            catch (Exception)
            {
                MessageBox.Show("Не удалось выполнить метод из ClassLibrary2.dll");
            }
        }

        private void button8_Click(object sender, EventArgs e)
        {
            try
            {
                MessageBox.Show(service3.AppointmentPlugin());
            }
            catch (Exception)
            {
                MessageBox.Show("Не удалось выполнить метод из ClassLibrary3.dll");
            }
        }

        private void button9_Click(object sender, EventArgs e)
        {
            try
            {
                MessageBox.Show(service4.AppointmentPlugin());
            }
            catch (Exception)
            {
                MessageBox.Show("Не удалось выполнить метод из ClassLibrary4.dll");
            }
        }

        private void button10_Click(object sender, EventArgs e)
        {
            try
            {
                MessageBox.Show(service5.AppointmentPlugin());
            }
            catch (Exception)
            {
                MessageBox.Show("Не удалось выполнить метод из ClassLibrary5.dll");
            }
        }
    }
}
