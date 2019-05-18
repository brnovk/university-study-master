using System;

namespace ClassLibrary2
{
    public class Class2 : MarshalByRefObject
    {
        /// <summary>
        /// Метод замены строчных букв прописными.
        /// </summary>
        public string Shift(string s1)
        {
            Console.WriteLine("Called method \"Shift\" from library \"ClassLibrary2.dll\";");
            return s1.ToUpperInvariant();
        }

        /// <summary>
        /// Метод назначения плагина.
        /// </summary>
        public string AppointmentPlugin()
        {
            Console.WriteLine("Called method \"AppointmentPlugin\" "
                + "from library \"ClassLibrary2.dll\";");
            return "Плагин \"ClassLibrary2.dll\" реализует функцию замены " 
                + "строчных букв прописными : string Shift(string)";
        }
    }
}
