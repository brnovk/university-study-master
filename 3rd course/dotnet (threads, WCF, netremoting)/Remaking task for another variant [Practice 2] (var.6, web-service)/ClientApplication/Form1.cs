using System;
using System.Windows.Forms;

using ClientApplication.MyService1;
using ClientApplication.MyService2;
using ClientApplication.MyService3;

namespace ClientApplication
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                Service1 webservice = new Service1();
                textBox2.Text = webservice.ReverseString(textBox1.Text);
                webservice.Dispose();
            }
            catch (Exception ex)
            {
                textBox2.Text = ex.Message;
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            try {
                Service2 webservice = new Service2();
                textBox4.Text = webservice.Shift(textBox3.Text);
                webservice.Dispose();
            }
            catch (Exception ex)
            {
                textBox4.Text = ex.Message;
            }
        }

        private void button5_Click(object sender, EventArgs e)
        {
            try {
                Service3 webservice = new Service3();
                textBox6.Text = webservice.Transliteration(textBox5.Text);
                webservice.Dispose();
            }
            catch (Exception ex)
            {
                textBox6.Text = ex.Message;
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            try {
                Service1 webservice = new Service1();
                MessageBox.Show(webservice.AppointmentPlugin());
                webservice.Dispose();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void button4_Click(object sender, EventArgs e)
        {
            try {
                Service2 webservice = new Service2();
                MessageBox.Show(webservice.AppointmentPlugin());
                webservice.Dispose();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void button6_Click(object sender, EventArgs e)
        {
            try {
                Service3 webservice = new Service3();
                MessageBox.Show(webservice.AppointmentPlugin());
                webservice.Dispose();
            }
            catch (Exception ex)
            { 
                MessageBox.Show(ex.Message);
            }
        }

        private void aboutToolStripMenuItem_Click(object sender, EventArgs e)
        {  
            MessageBox.Show("Практическая работа №2; \n" +
                "Тема:\n  \"Технология Web-служб\";\n" +
                "Приложение:\n  \"Редактор строки\"\n", "О программе",
                MessageBoxButtons.OK, MessageBoxIcon.Information);
        }

        private void exitToolStripMenuItem_Click_1(object sender, EventArgs e)
        {
            Application.Exit();
        }
    }
}
