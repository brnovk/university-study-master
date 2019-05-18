using System;
using System.Windows.Forms;
using System.Threading;       // Для мьютекса

namespace MainApplication
{
    static class Program
    {
        private static Mutex m_instance;                   
        private const string m_appName = "NameOfMyApp";    

        /// <summary>
        /// Главная точка входа для приложения.
        /// </summary>
        [STAThread]
        static void Main()
        {
            bool tryCreateNewApp;                          
            m_instance = new Mutex(true, m_appName, out tryCreateNewApp);                  
            if (tryCreateNewApp)                           
            {
                Application.EnableVisualStyles();
                Application.SetCompatibleTextRenderingDefault(false);
                Application.Run(new Form1());
            }
            else                                           
                MessageBox.Show("Уже запущен 1 экземпляр приложения");
        }
    }
}
