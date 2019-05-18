using System;

namespace ClassLibrary2
{
    public class Class2
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
                double x = Convert.ToDouble(met);
                return (x / 0.3048).ToString();
            }
            catch (Exception)
            {
                return "<Error convertion>";
            }
        }

        /// <summary>
        /// Метод перевода метров в дюймы
        /// </summary>
        /// <param name="met">Строковое представления вещественного числа (метров)</param>
        /// <returns>Строковое представление дюймов</returns>
        public string MetersToInches(string met)
        {
            try
            {
                double x = Convert.ToDouble(met);
                return (x / 0.0254).ToString();
            }
            catch (Exception)
            {
                return "<Error convertion>";
            }
        }
    }
}
