using System;

namespace ClassLibrary3
{
    public class Class3 : MarshalByRefObject
    {
        /// <summary>
        /// Метод перевода метров в ярды
        /// </summary>
        /// <param name="met">Строковое представления вещественного числа (метров)</param>
        /// <returns>Строковое представление ярдов</returns>
        public string MetersToYards(string met)
        {
            try
            {
                Console.WriteLine("Был вызван метод \"MetersToYards\" " 
                    + "из библиотеки \"ClassLibrary3\";");
                double x = Convert.ToDouble(met);
                return (x / 0.9144).ToString();
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
            Console.WriteLine("Был вызван метод \"MetersToYards\" " 
                + "из библиотеки \"ClassLibrary3\";");
            return "Плагин \"ClassLibrary3.dll\" реализует функцию перевода " 
                + "метров в ярды: string MetersToYards(string met)";
        }
    }
}
