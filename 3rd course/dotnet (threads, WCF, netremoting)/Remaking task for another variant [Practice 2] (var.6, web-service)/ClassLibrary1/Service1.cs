using System;

namespace ClassLibrary1
{
    public class Service1 : InterfaceService1
    {

        /// <summary>
        /// Реверс строки («переворот»)
        /// </summary>
        public string ReverseString(string s)
        {
            Console.WriteLine("Был вызван метод \"ReverseString\" " 
                + "из библиотеки \"ClassLibrary1.dll\";");
            char[] arr = s.ToCharArray();
            Array.Reverse(arr);
            return new string(arr);
        }

        /// <summary>
        /// Метод назначения плагина.
        /// </summary>
        public string AppointmentPlugin()
        {
            Console.WriteLine("Был вызван метод \"AppointmentPlugin\" " 
                + "из библиотеки \"ClassLibrary1\";");
            return "Плагин \"ClassLibrary1.dll\" реализует функцию реверса " 
                + "строки: string ReverseString(string s)";
        }
    }
}
