using System;

namespace ClassLibrary3
{
    public class Service3 : InterfaceService3
    {
        /// <summary>
        /// Восьмеричный калькулятор.
        /// Операция умножения.
        /// </summary>
        /// <param name="s1">Строковое представление восьмеричного числа делимого</param>
        /// <param name="s2">Строковое представление восьмеричного числа делителя</param>
        /// <returns>Строковое восьмеричного числа результата</returns>
        public string MultiplicationOctalNumbers(string s1, string s2)
        {
            try
            {
                Console.WriteLine("Был вызван метод \"MultiplicationOctalNumbers\" " 
                    + "из библиотеки \"ClassLibrary3.dll\";");
                int i = Convert.ToInt32(s1, 8);
                int j = Convert.ToInt32(s2, 8);
                return (Convert.ToString((i * j), 8));
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
                + "из библиотеки \"ClassLibrary3\";");
            return "Плагин \"ClassLibrary3.dll\" реализует функцию умножения восьмеричных " 
                + "чисел: public string MultiplicationOctalNumbers(string s1, string s2)";
        }
    }
}
