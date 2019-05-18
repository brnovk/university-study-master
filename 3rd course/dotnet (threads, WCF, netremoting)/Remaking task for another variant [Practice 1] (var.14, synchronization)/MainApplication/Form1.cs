using System;
using System.Windows.Forms;
using System.Reflection;   // Для рефлексии
using System.Threading;    // Для потоков
using System.Collections;  // Для очереди

namespace MainApplication
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            MainFunction();
        }

        public struct EntryQueue
        {
            public UInt16 NumberReference;
            public bool ResultOperation;
        };

        ManualResetEvent StopEvent;                        // Обьявляем event завершения

        Queue Qe = new Queue(0, 1);                        // Создаём очередь

        static Semaphore s1 = new Semaphore(1, 2); // Создаём семафор для потоков-производителей
        static Semaphore s2 = new Semaphore(1, 1); // Создаём семафор для потока-потребителя

        Thread p1;                                 // Обьявляем первый поток-производитель
        Thread p2;                                 // Обьявляем второй поток-производитель
        Thread p3;                                 // Обьявляем третий поток-потребитель


        public void MainFunction()
        {
            maskedTextBox1.Mask = "000000000"; // 
            maskedTextBox2.Mask = "000000000"; // Маски для ввода целых чисел
            maskedTextBox3.Mask = "000000000"; // 
            maskedTextBox4.Mask = "000000000"; // 
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
            // Получаем массив типов, находящийся в сборке(И классов тоже)
            Type[] alltypes = asm.GetTypes();
            // Получаем информацию о первом единственном конструкторе из загруженных типов
            ConstructorInfo[] ci = alltypes[0].GetConstructors();
            // Используем первый и единственный обнаруженный конструктор
            object reflectOb = ci[0].Invoke(null);
            // Получаем массив методов из этого класса, используя фильтрующие флаги
            MethodInfo[] mi = alltypes[0].GetMethods(
                BindingFlags.DeclaredOnly | BindingFlags.Instance | BindingFlags.Public);
            while (NeedWorksStream())      // Выполняем пока не произойдёт событие выхода
            {
                s1.WaitOne();              // Используем Semafor
                Monitor.Enter(Qe);         // Используем Monitor
                if (Qe.Count < 20)         // Если очередь не заполнена
                {
                    foreach (MethodInfo m in mi)
                    {
                        if (m.Name.CompareTo("CheckingForDivisibilityByTwo") == 0)
                        // Если имя метода "CheckingForDivisibilityByTwo"
                        {
                            // Массив параметров вызываемого из dll метода
                            object[] args = new object[1];
                            try
                            {
                                // Первый(и единственный) параметр
                                args[0] = Convert.ToInt32(maskedTextBox1.Text);
                            }                     
                            catch (Exception)
                            {
                                // Если к label нельзя подключиться из этого потока
                                // используем BeginInvoke и подключаемся
                                // Отображаем ошибку в label
                                if (ResultPerformingForBaseTwo.InvokeRequired)
                                    ResultPerformingForBaseTwo.BeginInvoke(new Action<string>((ts)
                                        => ResultPerformingForBaseTwo.Text = ts), "<Error conversion>");
                                continue;
                            }
                            // Создаём экземпляр структуры
                            EntryQueue tmp;
                            // Заносим номер метода в структуру
                            tmp.NumberReference = 1;
                            // Выполнение метода из dll и занесение результата в экземпляр структуры
                            tmp.ResultOperation = (bool)m.Invoke(reflectOb, args);
                            // Занесение экземпляра структуры в очередь
                            Qe.Enqueue(tmp);
                        }

                        if (m.Name.CompareTo("CheckingForDivisibilityByThree") == 0)
                        // Если имя метода "CheckingForDivisibilityByThree"
                        {
                            // Массив параметров вызываемого из dll метода
                            object[] args1 = new object[1];
                            try
                            {
                                // Первый(и единственный) параметр
                                args1[0] = Convert.ToInt32(maskedTextBox2.Text);
                            }
                            catch (Exception)
                            {
                                // Если к label нельзя подключиться из этого потока
                                // используем BeginInvoke и подключаемся
                                // Отображаем ошибку в label
                                if (ResultPerformingForBaseThree.InvokeRequired)
                                    ResultPerformingForBaseThree.BeginInvoke(
                                        new Action<string>((ts)
                                            => ResultPerformingForBaseThree.Text = ts), 
                                                "<Error conversion>");
                                continue;
                            }
                            // Создаём экземпляр структуры
                            EntryQueue tmp;
                            // Заносим номер метода в структуру
                            tmp.NumberReference = 2;
                            // Выполнение метода из dll и занесение результата в экземпляр структуры
                            tmp.ResultOperation = (bool)m.Invoke(reflectOb, args1);
                            // Занесение экземпляра структуры в очередь
                            Qe.Enqueue(tmp);
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
            Type[] alltypes = asm.GetTypes();                                   
            ConstructorInfo[] ci = alltypes[0].GetConstructors();         
            object reflectOb = ci[0].Invoke(null);                             
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
                        if (m.Name.CompareTo("CheckingForDivisibilityByFive") == 0)
                        // Если имя метода "CheckingForDivisibilityByFive"
                        {
                            object[] args = new object[1];       
                            try {
                                args[0] = Convert.ToInt32(maskedTextBox3.Text);
                            } 
                            catch (Exception)
                            {
                                if (ResultPerformingForBaseFive.InvokeRequired)
                                    ResultPerformingForBaseFive.BeginInvoke(
                                        new Action<string>((ts)
                                            => ResultPerformingForBaseFive.Text = ts),
                                                "<Error conversion>");
                                continue;
                            }
                            EntryQueue tmp;
                            tmp.NumberReference = 3;
                            tmp.ResultOperation = (bool)m.Invoke(reflectOb, args);
                            Qe.Enqueue(tmp);
                        }

                        if (m.Name.CompareTo("CheckingForDivisibilityByTen") == 0)
                        // Если имя метода "CheckingForDivisibilityByTen"
                        {
                            object[] args1 = new object[1];
                            try {
                                args1[0] = Convert.ToInt32(maskedTextBox4.Text);
                            }
                            catch (Exception) 
                            {
                                if (ResultPerformingForBaseTen.InvokeRequired)
                                    ResultPerformingForBaseTen.BeginInvoke(new Action<string>((ts)
                                        => ResultPerformingForBaseTen.Text = ts),
                                            "<Error conversion>");
                                continue;
                            }
                            EntryQueue tmp;
                            tmp.NumberReference = 4;
                            tmp.ResultOperation = (bool)m.Invoke(reflectOb, args1);
                            Qe.Enqueue(tmp);
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
            EntryQueue tmp;
            while (NeedWorksStream())           // Выполняем пока не произойдёт событие выхода
            {
                s2.WaitOne();                   // Входим в семафор
                if (Qe.Count < 1)               // Если отсутствуют результаты в очереди
                    Thread.Sleep(1);            // На 1 мс приостанавливаем поток
                else
                {
                    // Извлекаем результат из очереди в буферную структуру
                    tmp = (EntryQueue)Qe.Dequeue();
                    switch (tmp.NumberReference)       
                    {
                        case 1:
                            // Если к label нельзя подключиться из этого потока
                            // используем BeginInvoke и подключаемся
                            // Отображаем результат из очереди на форме (в label)
                            if (ResultPerformingForBaseTwo.InvokeRequired)
                                ResultPerformingForBaseTwo.BeginInvoke(new Action<string>((ts)
                                    => ResultPerformingForBaseTwo.Text = ts),
                                        tmp.ResultOperation.ToString());
                            break;
                        case 2:
                            if (ResultPerformingForBaseThree.InvokeRequired)
                                ResultPerformingForBaseThree.BeginInvoke(new Action<string>((ts2)
                                    => ResultPerformingForBaseThree.Text = ts2),
                                        tmp.ResultOperation.ToString());
                            break;
                        case 3:
                            if (ResultPerformingForBaseFive.InvokeRequired)
                                ResultPerformingForBaseFive.BeginInvoke(new Action<string>((ts3)
                                    => ResultPerformingForBaseFive.Text = ts3),
                                        tmp.ResultOperation.ToString());
                            break;
                        case 4:
                            if (ResultPerformingForBaseTen.InvokeRequired)
                                ResultPerformingForBaseTen.BeginInvoke(new Action<string>((ts4)
                                    => ResultPerformingForBaseTen.Text = ts4),
                                        tmp.ResultOperation.ToString());
                            break;
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
        /// Метод проверки события выхода из программы(StopEvent)
        /// </summary>
        private bool NeedWorksStream()
        {
            return !StopEvent.WaitOne(1, false);
        }

        /// <summary>
        /// Отображение на форме ошибки загрузки DLL-библиотек.
        /// </summary>
        /// <param name="b">Порядковый номер плагина</param>
        private void DisplayedErrorLoad(uint b)
        {
            if (b == 1)        // Если не загрузилась "ClassLibrary1.dll"
            {
                maskedTextBox1.ReadOnly = true;
                maskedTextBox2.ReadOnly = true;
                label4.Text = "<Ошибка загрузки \"ClassLibrary1.dll\">";
                label5.Text = "<Ошибка загрузки \"ClassLibrary1.dll\">";
                ResultPerformingForBaseTwo.Visible = false;
                ResultPerformingForBaseThree.Visible = false;
                return;
            }
            else if (b == 2)   // Если не загрузилась "ClassLibrary2.dll"
            {
                maskedTextBox3.ReadOnly = true;
                maskedTextBox4.ReadOnly = true;
                label6.Text = "<Ошибка загрузки \"ClassLibrary2.dll\">";
                label7.Text = "<Ошибка загрузки \"ClassLibrary2.dll\">";
                ResultPerformingForBaseFive.Visible = false;
                ResultPerformingForBaseTen.Visible = false;
                return;
            }
            else
                return;
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
                e.Cancel = true;   // Или не выходим..
        }

        /// <summary>
        /// Нажатие кнопки "О программе"
        /// </summary>
        private void aboutToolStripMenuItem_Click(object sender, EventArgs e)
        {
            MessageBox.Show("Практическая работа №1; \n" +
                            "Тема:\n  \"Средства синхронизации на платформе .NET\";\n" +
                            "Выполнил:\n  студент группы ПОИТ-31, _student_name;\n" +
                            "Вариант №14; \nПриложение:\n  \"Проверка делимости чисел\"\n",
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
