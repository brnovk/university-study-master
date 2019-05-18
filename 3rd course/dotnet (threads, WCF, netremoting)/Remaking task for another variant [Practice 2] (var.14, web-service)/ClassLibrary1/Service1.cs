using System;

namespace ClassLibrary1
{
    public class Service1 : InterfaceService1
    {
        /// <summary>
        /// Проверка делимости целого числа на 2
        /// </summary>
        public bool CheckingForDivisibilityByTwo(int number)
        {
            Console.WriteLine("Called method \"CheckingForDivisibilityByTwo\" " 
                + "from library \"ClassLibrary1.dll\";");
            if (number < 0)
                number = -number;
            else if (number == 0)
                return false;
            number %= 2;
            return number == 0;
        }

        /// <summary>
        /// Метод назначения плагина.
        /// </summary>
        public string AppointmentPlugin()
        {
            Console.WriteLine("Called method \"AppointmentPlugin\" " 
                + "from library \"ClassLibrary1.dll\";");
            return "Плагин \"ClassLibrary1.dll\" реализует функции:\n"
                   + "bool CheckingForDivisibilityByTwo(int number) - " 
                   + "проверка делимости числа на \"2\";\n"
                   + "string AppointmentPlugin() - функция назначения плагина.";
        }
    }
}
