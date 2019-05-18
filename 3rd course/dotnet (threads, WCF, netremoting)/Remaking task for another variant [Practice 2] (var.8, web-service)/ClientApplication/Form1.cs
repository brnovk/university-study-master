using System;
using System.Windows.Forms;

using ClientApplication.MyService1;
using ClientApplication.MyService2;
using ClientApplication.MyService3;
using ClientApplication.MyService4;

namespace ClientApplication
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }
        
        private void exitToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void aboutToolStripMenuItem_Click(object sender, EventArgs e)
        {
            MessageBox.Show("Практическая работа №2; \n" +
                 "Тема:\n  \"Технология Web-служб\";\n" +
                 "Выполнил:\n  студент группы ПОИТ-31, _student_name;\n" +
                 "Вариант №8; \nПриложение:\n  \"Восьмеричный калькулятор\"\n", "О программе",
                 MessageBoxButtons.OK, MessageBoxIcon.Information);
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                Service1 webservice = new Service1();
                textBox3.Text = webservice.AdditionOctalNumbers(textBox1.Text,textBox2.Text);
                webservice.Dispose();
            }
            catch (Exception ex)
            {
                textBox3.Text = ex.Message;
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            try
            {
                Service2 webservice = new Service2();
                textBox6.Text = webservice.DifferenceOctalNumbers(textBox4.Text, textBox5.Text);
                webservice.Dispose();
            }
            catch (Exception ex)
            {
                textBox6.Text = ex.Message;
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            try
            {
                Service3 webservice = new Service3();
                textBox9.Text = 
                    webservice.MultiplicationOctalNumbers(textBox7.Text, textBox8.Text);
                webservice.Dispose();
            }
            catch (Exception ex)
            {
                textBox9.Text = ex.Message;
            }
        }

        private void button4_Click(object sender, EventArgs e)
        {
            try
            {
                Service4 webservice = new Service4();
                textBox12.Text = webservice.ModuloOctalNumbers(textBox10.Text, textBox11.Text);
                webservice.Dispose();
            }
            catch (Exception ex)
            {
                textBox12.Text = ex.Message;
            }
        }

        private void button5_Click(object sender, EventArgs e)
        {
            try
            {
                Service1 webservice = new Service1();
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
            try
            {
                Service2 webservice = new Service2();
                MessageBox.Show(webservice.AppointmentPlugin());
                webservice.Dispose();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void button7_Click(object sender, EventArgs e)
        {
            try
            {
                Service3 webservice = new Service3();
                MessageBox.Show(webservice.AppointmentPlugin());
                webservice.Dispose();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void button8_Click(object sender, EventArgs e)
        {
            try
            {
                Service4 webservice = new Service4();
                MessageBox.Show(webservice.AppointmentPlugin());
                webservice.Dispose();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
    }
}
