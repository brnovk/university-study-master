using System;
using System.Windows.Forms;

using MainApplication.MyService1;
using MainApplication.MyService2;
using MainApplication.MyService3;
using MainApplication.MyService4;

namespace MainApplication
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            Func();
        }

        Service1 webservice1 = new Service1();
        Service2 webservice2 = new Service2();
        Service3 webservice3 = new Service3();
        Service4 webservice4 = new Service4();

        public void Func()
        {
            maskedTextBox1.Mask = "000000000"; // 
            maskedTextBox2.Mask = "000000000"; // Маски для ввода целых чисел
            maskedTextBox3.Mask = "000000000"; // 
            maskedTextBox4.Mask = "000000000"; // 
        }

        /// <summary>
        /// Нажатие О программе
        /// </summary>
        private void aboutToolStripMenuItem_Click(object sender, EventArgs e)
        {
            MessageBox.Show("Практическая работа №2; \n" +
                            "Тема:\n  \"Технология Web-служб\";\n" +
                            "Выполнил:\n  студент группы ПОИТ-31, _student_name;\n" +
                            "Вариант №14; \nПриложение:\n  " 
                            + "\"Проверка делимости чисел\"\n", "О программе",
                            MessageBoxButtons.OK, MessageBoxIcon.Information);
        }

        /// <summary>
        /// Нажание Выход
        /// </summary>
        private void exitToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void PerformFunctionPlug1_Click(object sender, EventArgs e)
        {
            try
            {
                bool tmp, f = false;
                webservice1.CheckingForDivisibilityByTwo(Convert.ToInt32(maskedTextBox1.Text), 
                                                        true, out tmp, out f);
                ResultPerformingForBaseTwo.Text = tmp.ToString();
            }
            catch (Exception ex)
            {
                ResultPerformingForBaseTwo.Text = ex.Message;
            }
        }

        private void PerformFunctionPlug2_Click(object sender, EventArgs e)
        {
            try
            {
                bool tmp, f = false;
                webservice2.CheckingForDivisibilityByThree(Convert.ToInt32(maskedTextBox2.Text),
                                                        true, out tmp, out f);
                ResultPerformingForBaseThree.Text = tmp.ToString();
            }
            catch (Exception ex)
            {
                ResultPerformingForBaseThree.Text = ex.Message;
            }
        }

        private void PerformFunctionPlug3_Click(object sender, EventArgs e)
        {
            try
            {
                bool tmp, f = false;
                webservice3.CheckingForDivisibilityByFive(Convert.ToInt32(maskedTextBox3.Text),
                                                        true, out tmp, out f);
                ResultPerformingForBaseFive.Text = tmp.ToString();
            }
            catch (Exception ex)
            {
                ResultPerformingForBaseFive.Text = ex.Message;
            }
        }

        private void PerformFunctionPlug4_Click(object sender, EventArgs e)
        {
            try
            {
                bool tmp, f = false;
                webservice4.CheckingForDivisibilityByTen(Convert.ToInt32(maskedTextBox4.Text),
                                                        true, out tmp, out f);
                ResultPerformingForBaseTen.Text = tmp.ToString();
            }
            catch (Exception ex)
            {
                ResultPerformingForBaseTen.Text = ex.Message;
            }
        }

        private void ButtonAboutPlugin1_Click(object sender, EventArgs e)
        {
            try
            {
                MessageBox.Show(webservice1.AppointmentPlugin());
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void ButtonAboutPlugin2_Click(object sender, EventArgs e)
        {
            try
            {
                MessageBox.Show(webservice2.AppointmentPlugin());
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void ButtonAboutPlugin3_Click(object sender, EventArgs e)
        {
            try
            {
                MessageBox.Show(webservice3.AppointmentPlugin());
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void ButtonAboutPlugin4_Click(object sender, EventArgs e)
        {
            try
            {
                MessageBox.Show(webservice4.AppointmentPlugin());
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
    }
}
