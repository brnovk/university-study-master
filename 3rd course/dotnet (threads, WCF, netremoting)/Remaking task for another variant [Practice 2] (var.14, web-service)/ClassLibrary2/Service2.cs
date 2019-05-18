using System;

namespace ClassLibrary2
{
    public class Service2 : InterfaceService2
    {
        /// <summary>
        /// Проверка делимости целого числа на 3
        /// </summary>
        public bool CheckingForDivisibilityByThree(int number)
        {
            Console.WriteLine("Called method \"CheckingForDivisibilityByThree\" " 
                + "from library \"ClassLibrary2.dll\"");
            if (number < 0)
                number = -number;
            else if (number == 0)
                return false;
            number %= 3;
            return number == 0;
        }

        /// <summary>
        /// Метод назначения плагина.
        /// </summary>
        public string AppointmentPlugin()
        {
            Console.WriteLine("Called method \"AppointmentPlugin\" " 
                + "from library \"ClassLibrary2.dll\";");
            return "Плагин \"ClassLibrary2.dll\" реализует функции:\n"
                + "bool CheckingForDivisibilityByThree(int number) - " 
                + "проверка делимости числа на \"3\";\n"
                + "string AppointmentPlugin() - функция назначения плагина.";
        }
    }
}
