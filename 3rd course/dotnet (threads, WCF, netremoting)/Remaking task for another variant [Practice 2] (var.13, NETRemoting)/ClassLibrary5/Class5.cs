using System;

namespace ClassLibrary5
{
    public class Class5 : MarshalByRefObject
    {
        /// <summary>
        /// Метод перевода метров в дюймы
        /// </summary>
        /// <param name="met">Строковое представления вещественного числа (метров)</param>
        /// <returns>Строковое представление дюймов</returns>
        public string MetersToInches(string met)
        {
            try
            {
                Console.WriteLine("Был вызван метод \"MetersToInches\" " 
                    + "из библиотеки \"ClassLibrary5\";");
                double x = Convert.ToDouble(met);
                return (x / 0.0254).ToString();
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
            Console.WriteLine("Был вызван метод \"MetersToInches\" " 
                + "из библиотеки \"ClassLibrary5\";");
            return "Плагин \"ClassLibrary5.dll\" реализует функцию перевода " 
                + "метров в дюймы: double MetersToInches(double p)";
        }
    }
}
