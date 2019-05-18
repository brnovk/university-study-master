using System;

namespace ClassLibrary4
{
    public class Class4 : MarshalByRefObject
    {
        /// <summary>
        /// Метод перевода метров в футы
        /// </summary>
        /// <param name="met">Строковое представления вещественного числа (метров)</param>
        /// <returns>Строковое представление футов</returns>
        public string MetersToFeet(string met)
        {
            try
            {
                Console.WriteLine("Был вызван метод \"MetersToFeet\" " 
                    + "из библиотеки \"ClassLibrary4\";");
                double x = Convert.ToDouble(met);
                return (x / 0.3048).ToString();
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
            Console.WriteLine("Был вызван метод \"MetersToFeet\" " 
                + "из библиотеки \"ClassLibrary4\";");
            return "Плагин \"ClassLibrary4.dll\" реализует функцию перевода " 
                + "метров в футы: string MetersToFeet(string met)";
        }
    }
}
