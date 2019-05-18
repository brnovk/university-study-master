using System;

namespace ClassLibrary2
{
    public class Service2 : InterfaceService2
    {
        /// <summary>
        /// Восьмеричный калькулятор.
        /// Операция разности.
        /// </summary>
        /// <param name="s1">Строковое представление первого восьмеричного числа</param>
        /// <param name="s2">Строковое представление второго восьмеричного числа</param>
        /// <returns>Строковое восьмеричного числа результата</returns>
        public string DifferenceOctalNumbers(string s1, string s2)
        {
            try
            {
                Console.WriteLine("Был вызван метод \"DifferenceOctalNumbers\" " 
                    + "из библиотеки \"ClassLibrary2.dll\";");
                int i = Convert.ToInt32(s1, 8);
                int j = Convert.ToInt32(s2, 8);
                return (Convert.ToString((i - j), 8));
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
                + "из библиотеки \"ClassLibrary2\";");
            return "Плагин \"ClassLibrary2.dll\" реализует функцию разности " 
                + "восьмеричных чисел: public string DifferenceOctalNumbers(string s1, string s2)";
        }
    }
}
