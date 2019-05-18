using System;

namespace ClassLibrary4
{
    public class Service4 : InterfaceService4
    {
        /// <summary>
        /// Проверка делимости целого числа на 10
        /// </summary>
        public bool CheckingForDivisibilityByTen(int number)
        {
            Console.WriteLine("Called method \"CheckingForDivisibilityByTen\" " 
                + "from library \"ClassLibrary4.dll\";");
            if (number < 0)
                number = -number;
            else if (number == 0)
                return false;
            number %= 10;
            return number == 0;
        }

        /// <summary>
        /// Метод назначения плагина.
        /// </summary>
        public string AppointmentPlugin()
        {
            Console.WriteLine("Called method \"AppointmentPlugin\" " 
                + "from library \"ClassLibrary4.dll\";");
            return "Плагин \"ClassLibrary4.dll\" реализует функции:\n"
                + "bool CheckingForDivisibilityByTen(int number) - " 
                + "проверка делимости числа на \"10\";\n"
                + "string AppointmentPlugin() - функция назначения плагина.";
        }
    }
}
