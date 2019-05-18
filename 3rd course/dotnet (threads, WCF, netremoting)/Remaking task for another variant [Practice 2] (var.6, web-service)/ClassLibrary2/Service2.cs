using System;

namespace ClassLibrary2
{
    public class Service2 : InterfaceService2
    {
        /// <summary>
        /// Замена прописных букв строчными (в т.ч. для русских букв)
        /// </summary>
        public string Shift(string s1)
        {
            Console.WriteLine("Был вызван метод \"Shift\" " 
                + "из библиотеки \"ClassLibrary2.dll\";");
            return s1.ToLowerInvariant();
        }

        /// <summary>
        /// Метод назначения плагина.
        /// </summary>
        public string AppointmentPlugin()
        {
            Console.WriteLine("Был вызван метод \"AppointmentPlugin\" из " 
                + "библиотеки \"ClassLibrary2\";");
            return "Плагин \"ClassLibrary2.dll\" реализует функцию замены" 
                + " прописных букв на строчные: string Shift(string s1)";
        }
    }
}
