using System;

namespace ClassLibrary4
{
    public class Service4 : InterfaceService4
    {
        /// <summary>
        /// Восьмеричный калькулятор.
        /// Операция взятия остатка от целочисленного деления.
        /// </summary>
        /// <param name="s1">Строковое представление первого восьмеричного числа</param>
        /// <param name="s2">Строковое представление второго восьмеричного числа</param>
        /// <returns>Строковое восьмеричного числа результата</returns>
        public string ModuloOctalNumbers(string s1, string s2)
        {
            try
            {
                Console.WriteLine("Был вызван метод \"ModuloOctalNumbers\" " 
                    + "из библиотеки \"ClassLibrary4.dll\";");
                int i = Convert.ToInt32(s1, 8);
                int j = Convert.ToInt32(s2, 8);
                return (Convert.ToString((i % j), 8));
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
                + "из библиотеки \"ClassLibrary4\";");
            return "Плагин \"ClassLibrary4.dll\" реализует функцию остатка от деления " 
                + "восьмеричных чисел: public string ModuloOctalNumbers(string s1, string s2)";
        }
    }
}
