using System;

namespace ClassLibrary1
{
    public class Service1 : InterfaceService1
    {
        /// <summary>
        /// Восьмеричный калькулятор.
        /// Операция сложение.
        /// </summary>
        /// <param name="s1">Строковое представление первого восьмеричного числа</param>
        /// <param name="s2">Строковое представление второго восьмеричного числа</param>
        /// <returns>Строковое восьмеричного числа результата</returns>
        public string AdditionOctalNumbers(string s1, string s2)
        {
            try
            {
                Console.WriteLine("Был вызван метод \"AdditionOctalNumbers\" " 
                    + "из библиотеки \"ClassLibrary1.dll\";");
                int i = Convert.ToInt32(s1, 8);
                int j = Convert.ToInt32(s2, 8);
                return (Convert.ToString((i + j), 8));
            }
            catch (Exception)
            {
                return "<Error conversion>";
            }
        }

        /// <summary>
        /// Метод назначения плагина.
        /// </summary>
        public string AppointmentPlugin()
        {
            Console.WriteLine("Был вызван метод \"AppointmentPlugin\" " 
                + "из библиотеки \"ClassLibrary1\";");
            return "Плагин \"ClassLibrary1.dll\" реализует функцию сложения " 
                + "восьмеричных чисел: string AdditionOctalNumbers(string s1, string s2)";
        }
    }
}
