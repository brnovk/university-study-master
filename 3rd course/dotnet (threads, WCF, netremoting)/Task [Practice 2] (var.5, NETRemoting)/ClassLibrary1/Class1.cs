using System;

namespace ClassLibrary1
{
    public class Class1 : MarshalByRefObject
    {
        
        /// <summary>
        /// Метод сложения строк.
        /// </summary>
        public string FoldString(string s1, string s2)
        {
            Console.WriteLine("Called method \"FoldString\" from library \"ClassLibrary1\";");
            return s1 + s2;
        }

        /// <summary>
        /// Метод назначения плагина.
        /// </summary>
        public string AppointmentPlugin()
        {
            Console.WriteLine(
                "Called method \"AppointmentPlugin\" from library \"ClassLibrary1\";");
            return "Плагин \"ClassLibrary1.dll\" реализует функцию сложения строк: "
                + "string FoldString(string, string)";
        }
    }
}
