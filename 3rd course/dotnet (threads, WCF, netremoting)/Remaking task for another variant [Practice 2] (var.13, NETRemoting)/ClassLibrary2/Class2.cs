using System;

namespace ClassLibrary2
{
    public class Class2 : MarshalByRefObject
    {
        /// <summary>
        /// Метод перевода метров в мили
        /// </summary>
        /// <param name="met">Строковое представления вещественного числа (метров)</param>
        /// <returns>Строковое представление миль</returns>
        public string MetersToMiles(string met)
        {
            try
            {
                Console.WriteLine("Был вызван метод \"MetersToMiles\" " 
                    + "из библиотеки \"ClassLibrary2\";");
                double x = Convert.ToDouble(met);
                return (x / 1609.344).ToString();
            }
            catch (Exception)
            {
                return "<Error convertion>";
            }
        }

        /// <summary>
        /// Метод назначения плагина.
        /// </summary>
        public string AppointmentPlugin()
        {
            Console.WriteLine("Был вызван метод \"MetersToMiles\" " 
                + "из библиотеки \"ClassLibrary2\";");
            return "Плагин \"ClassLibrary2.dll\" реализует функцию перевода " 
                + "метров в мили: string MetersToMiles(string met)";
        }
    }
}
