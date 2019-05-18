using System;
using System.Windows.Forms;
using System.Reflection;       // Для рефлексии
using System.Threading;        // Для потоков
using System.Collections;      // Для очереди

namespace MainApplication
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            MainFunc();
        }

        ManualResetEvent StopEvent;                        // Обьявляем event завершения

        Queue Qe = new Queue(0, 1);                        // Создаём очередь из 20-ти элементов

        static Semaphore s1 = new Semaphore(1, 2); // Создаём семафор для потоков-производителей
        static Semaphore s2 = new Semaphore(1, 1); // Создаём семафор для потока-потребителя

        Thread p1;                                 // Обьявляем первый поток-производитель
        Thread p2;                                 // Обьявляем второй поток-производитель
        Thread p3;                                 // Обьявляем третий поток-потребитель


        public void MainFunc()
        {
            Qe.TrimToSize();
            StopEvent = new ManualResetEvent(false); // Создаём event завершения
            p1 = new Thread(Producer1);              // Создаём первый поток-производитель
            p2 = new Thread(Producer2);              // Создаём второй поток-производитель
            p3 = new Thread(Consumer);               // Создаём поток-потребитель
            p1.Start();                              // Запускаем первый поток-производитель
            p2.Start();                              // Запускаем второй поток-производитель
            p3.Start();                              // Запускаем поток-потребитель
        }

        /// <summary>
        /// Метод 1-го потока производителя
        /// </summary>
        private void Producer1()
        {
            Assembly asm = LoadingPlugin("ClassLibrary1.dll");
            if (asm == null)                      // Если не загрузилась DLL
            {
                DisplayedErrorLoad(1);            // Отображаем ошибку загрузки на форме
                return;
            }
            string res = null;
            // Получаем массив типов, находящийся в сборке(И классов тоже)
            Type[] alltypes = asm.GetTypes();
            // Получаем информацию о первом единственном конструкторе из загруженных типов
            ConstructorInfo[] ci = alltypes[0].GetConstructors();
            // Используем первый и единственный обнаруженный конструктор
            object reflectOb = ci[0].Invoke(null);
            // Получаем массив методов из этого класса, используя фильтрующие флаги
            MethodInfo[] mi = alltypes[0].GetMethods(
                BindingFlags.DeclaredOnly | BindingFlags.Instance | BindingFlags.Public);
            while (NeedWorksStream())     // Выполняем пока не произойдёт событие выхода
            {
                s1.WaitOne();             // Используем Semafor
                Monitor.Enter(Qe);        // Используем Monitor
                if (Qe.Count < 20)        // Если очередь не заполнена
                {
                    foreach (MethodInfo m in mi)
                    {
                        if (m.Name.CompareTo("AdditionOctalNumbers") == 0)
                        // Если имя метода "AdditionOctalNumbers"
                        {
                            object[] args = new object[2]; // Массив обьектов параметров
                            args[0] = textBox1.Text;       // Первый параметр метода 
                            args[1] = textBox2.Text;       // Второй параметр метода
                            if (NeedWorksStream())
                            {
                                res = '1' + (string)m.Invoke(reflectOb, args); // Вызываем метод
                                Qe.Enqueue(res);                  // Заносим результат в очередь
                            }
                        }

                        if (m.Name.CompareTo("DifferenceOctalNumbers") == 0)
                        // Если имя метода "DifferenceOctalNumbers"
                        {
                            object[] args1 = new object[2];
                            args1[0] = textBox3.Text;
                            args1[1] = textBox4.Text;
                            if (NeedWorksStream())
                            {
                                res = '2' + (string)m.Invoke(reflectOb, args1);
                                Qe.Enqueue(res);
                            }
                        }
                    }
                }
                else
                    Thread.Sleep(1);    // На 1 мс приостанавливаем поток
                Monitor.Exit(Qe);       // Выходим из Монитора
                s1.Release(1);          // Освобождаем Semafor
            }
        }

        /// <summary>
        /// Метод 2-го потока производителя
        /// </summary>
        private void Producer2()
        {
            Assembly asm = LoadingPlugin("ClassLibrary2.dll");
            if (asm == null)
            {
                DisplayedErrorLoad(2);            // Отображаем ошибку загрузки на форме
                return;
            }
            string res = null;
            // Получаем массив типов, находящийся в сборке(И классов тоже)
            Type[] alltypes = asm.GetTypes();
            // Получаем информацию о первом единственном конструкторе из загруженных типов
            ConstructorInfo[] ci = alltypes[0].GetConstructors();
            // Используем первый и единственный обнаруженный конструктор
            object reflectOb = ci[0].Invoke(null);
            // Получаем массив методов из этого класса, используя фильтрующие флаги
            MethodInfo[] mi = alltypes[0].GetMethods(
                BindingFlags.DeclaredOnly | BindingFlags.Instance | BindingFlags.Public);
            while (NeedWorksStream())    // Выполняем пока не произойдёт событие выхода
            {
                s1.WaitOne();
                Monitor.Enter(Qe);       // Используем Monitor
                if (Qe.Count < 20)       // Если очередь не заполнена
                {
                    foreach (MethodInfo m in mi)
                    {
                        if (m.Name.CompareTo("MultiplicationOctalNumbers") == 0)
                        // Если имя метода "MultiplicationOctalNumbers"
                        {
                            object[] args = new object[2];            // Массив обьектов параметров
                            args[0] = textBox5.Text;                  // Первый параметр метода 
                            args[1] = textBox6.Text;                  // Второй параметр метода
                            if (NeedWorksStream())
                            {
                                res = '3' + (string)m.Invoke(reflectOb, args); // Вызываем метод
                                Qe.Enqueue(res);                  // Заносим результат в очередь
                            }
                        }

                        if (m.Name.CompareTo("ModuloOctalNumbers") == 0)
                        // Если имя метода "ModuloOctalNumbers"
                        {
                            object[] args1 = new object[2];
                            args1[0] = textBox7.Text;
                            args1[1] = textBox8.Text;
                            if (NeedWorksStream())
                            {
                                res = '4' + (string)m.Invoke(reflectOb, args1);
                                Qe.Enqueue(res);
                            }
                        }
                    }
                }
                else
                    Thread.Sleep(1);        // На 1 мс приостанавливаем поток
                Monitor.Exit(Qe);
                s1.Release(1);
            }
        }

        /// <summary>
        /// Метод потока потребителя
        /// </summary>
        public void Consumer()
        {
            string sa = null;
            while (NeedWorksStream())       // Выполняем пока не произойдёт событие выхода
            {
                s2.WaitOne();               // Входим в семафор
                if (Qe.Count < 1)           // Если отсутствуют результаты в очереди
                    Thread.Sleep(1);        // На 1 мс приостанавливаем поток
                else
                {
                    sa = (string)Qe.Dequeue(); // Извлекаем результат из очереди в буферную строку

                    if (sa != null)
                    {
                        if (sa[0] == '1')             // Если строка из первого задания задания
                        {
                            sa = sa.Remove(0, 1);     // Удаляем первый символ
                            if (textBox9.InvokeRequired)  // И выводим её на экран (В textBox9)
                              textBox9.BeginInvoke(new Action<string>((s) =>
                                  textBox9.Text = s), sa);
                        }
                        else if (sa[0] == '2')
                        {
                            sa = sa.Remove(0, 1);
                            if (textBox10.InvokeRequired)
                              textBox10.BeginInvoke(new Action<string>((s1) =>
                                  textBox10.Text = s1), sa);
                        }
                        else if (sa[0] == '3')
                        {
                            sa = sa.Remove(0, 1);
                            if (textBox11.InvokeRequired)
                               textBox11.BeginInvoke(new Action<string>((s22) =>
                                   textBox11.Text = s22), sa);
                        }
                        else if (sa[0] == '4')
                        {
                            sa = sa.Remove(0, 1);
                            if (textBox12.InvokeRequired)
                               textBox12.BeginInvoke(new Action<string>((s23) =>
                                   textBox12.Text = s23), sa);
                        }
                    }
                }
                s2.Release();               // Выходим из семафора
            }
        }

        /// <summary>
        /// Метод загрузки dll
        /// </summary>
        private Assembly LoadingPlugin(string FileName)
        {
            try
            {
                Assembly asm;
                asm = Assembly.LoadFrom(FileName);
                return asm;
            }
            catch (Exception)
            {
                return null;
            }
        }

        /// <summary>
        /// Отображение на форме ошибки загрузки DLL-библиотек.
        /// </summary>
        /// <param name="b">Порядковый номер плагина</param>
        private void DisplayedErrorLoad(uint b)
        {
            if (b == 1)        // Если не загрузилась "ClassLibrary1.dll"
            {
                textBox9.Text = "<Ошибка загрузки \"ClassLibrary1.dll\">";
                textBox9.ReadOnly = true;
                textBox10.Text = "<Ошибка загрузки \"ClassLibrary1.dll\">";
                textBox10.ReadOnly = true;
                textBox1.Visible = false;
                textBox2.Visible = false;
                textBox3.Visible = false;
                textBox4.Visible = false;
                return;
            }
            else if (b == 2)   // Если не загрузилась "ClassLibrary2.dll"
            {
                textBox11.Text = "<Ошибка загрузки \"ClassLibrary2.dll\">";
                textBox11.ReadOnly = true;
                textBox12.Text = "<Ошибка загрузки \"ClassLibrary2.dll\">";
                textBox12.ReadOnly = true;
                textBox5.Visible = false;
                textBox6.Visible = false;
                textBox7.Visible = false;
                textBox8.Visible = false;
                return;
            }
            else
                return;
        }

        /// <summary>
        /// Метод проверки события выхода из программы(StopEvent)
        /// </summary>
        private bool NeedWorksStream()
        {
            return !StopEvent.WaitOne(1, false);
        }

        /// <summary>
        /// Событие закрытия формы.
        /// </summary>
        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (MessageBox.Show("Вы уверены, что хотите выйти?",
                                Application.ProductName,
                                MessageBoxButtons.YesNo) == DialogResult.Yes)
            {
                StopEvent.Set(); // Даём знать потокам, что надо остановиться
                int i;
                for (i = 0; i < 10; i++)
                {
                    if (p1.IsAlive) p1.Join(500);    // Ждём 500 мс завершения 1-го потока
                    if (p2.IsAlive) p2.Join(500);    // Ждём 500 мс завершения 2-го потока
                    if (p3.IsAlive) p3.Join(500);    // Ждём 500 мс завершения 3-го потока
                    if (!p1.IsAlive || !p2.IsAlive || !p3.IsAlive)
                        break;
                }
                if (i == 10) // Если за 10 раз не удалось завершить потоки...
                {
                    MessageBox.Show("Непредвиденная ошибка работы потоков!!!\n" +
                                    "Аварийное завершение программы!!!", "Ошибка",
                                    MessageBoxButtons.OK, MessageBoxIcon.Error);
                    if (p1.IsAlive) p1.Abort();
                    if (p2.IsAlive) p2.Abort();
                    if (p3.IsAlive) p3.Abort();
                }
                e.Cancel = false; // Выходим из приложения
            }
            else
                e.Cancel = true;   // Или не выходим
        }

        /// <summary>
        /// Нажатие кнопки "О программе"
        /// </summary>
        private void aAboutToolStripMenuItem_Click(object sender, EventArgs e)
        {
            MessageBox.Show("Практическая работа №1; \n" +
                            "Тема: \"Средства синхронизации на платформе .NET\";\n" +
                            "Выполнил: студент группы ПОИТ-31, _student_name;\n" +
                            "Вариант №8; \nПриложение:\n  \"Восьмеричный калькулятор\"\n",
                            "О программе", MessageBoxButtons.OK, MessageBoxIcon.Information);
        }

        /// <summary>
        /// Нажатие кнопки "Выход"
        /// </summary>
        private void exitToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }
    }
}
