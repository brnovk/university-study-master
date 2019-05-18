using System;

namespace ClassLibrary1
{
    public class Class1 : MarshalByRefObject
    {

        /// <summary>
        /// Метод перевода метров в километры
        /// </summary>
        /// <param name="met">Строковое представления вещественного числа (метров)</param>
        /// <returns>Строковое представление километров</returns>
        public string MetersToKilometers(string met)
        {
            try
            {
                Console.WriteLine("Был вызван метод \"MetersToKilometers\" " 
                    + "из библиотеки \"ClassLibrary1\";");
                double x = Convert.ToDouble(met);
                return (x / 1000).ToString();
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
            Console.WriteLine("Был вызван метод \"MetersToKilometers\" " 
                + "из библиотеки \"ClassLibrary1\";");
            return "Плагин \"ClassLibrary1.dll\" реализует функцию перевода " 
                + "метров в километры: string MetersToKilometers(string met)";
        }
    }
}
