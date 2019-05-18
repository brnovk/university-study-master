using System;

namespace ClassLibrary1
{
    public class Class1
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
                double x = Convert.ToDouble(met);
                return (x / 1000).ToString();
            }
            catch (Exception)
            {
                return "<Error convertion>";
            }
        }

        /// <summary>
        /// Метод перевода метров в мили
        /// </summary>
        /// <param name="met">Строковое представления вещественного числа (метров)</param>
        /// <returns>Строковое представление миль</returns>
        public string MetersToMiles(string met)
        {
            try
            {
                double x = Convert.ToDouble(met);
                return (x / 1609.344).ToString();
            }
            catch (Exception)
            {
                return "<Error convertion>";
            }
        }

        /// <summary>
        /// Метод перевода метров в ярды
        /// </summary>
        /// <param name="met">Строковое представления вещественного числа (метров)</param>
        /// <returns>Строковое представление ярдов</returns>
        public string MetersToYards(string met)
        {
            try
            {
                double x = Convert.ToDouble(met);
                return (x / 0.9144).ToString();
            }
            catch (Exception)
            {
                return "<Error convertion>";
            }
        }
    }
}
