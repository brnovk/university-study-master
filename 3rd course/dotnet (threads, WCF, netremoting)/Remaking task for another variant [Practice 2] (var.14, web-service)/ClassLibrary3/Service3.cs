using System;

namespace ClassLibrary3
{
    public class Service3 : InterfaceService3
    {
        /// <summary>
        /// Проверка делимости целого числа на 5
        /// </summary>
        public bool CheckingForDivisibilityByFive(int number)
        {
            Console.WriteLine("Called method \"CheckingForDivisibilityByFive\" " 
                + "from library \"ClassLibrary3.dll\";");
            if (number < 0)
                number = -number;
            else if (number == 0)
                return false;
            number %= 5;
            return number == 0;
        }

        /// <summary>
        /// Метод назначения плагина.
        /// </summary>
        public string AppointmentPlugin()
        {
            Console.WriteLine("Called method \"AppointmentPlugin\" " 
                + "from library \"ClassLibrary3.dll\";");
            return "Плагин \"ClassLibrary3.dll\" реализует функции:\n"
                + "bool CheckingForDivisibilityByFive(int number) - " 
                + "проверка делимости числа на \"5\";\n"
                + "string AppointmentPlugin() - функция назначения плагина.";
        }
    }
}
