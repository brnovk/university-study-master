using System;

namespace ClassLibrary1
{
    public class Class1
    {
        /// <summary>
        /// Восьмеричный калькулятор.
        /// Операция сложение.
        /// </summary>
        /// <param name="s1">Строковое представление первого восьмеричного числа</param>
        /// <param name="s2">Строковое представление второго восьмеричного числа</param>
        /// <returns>Строковое восьмеричного числа результата</returns>
        public string AdditionOctalNumbers(string s1, string s2)
        {
            try
            {
                // Конвертируем первый аргумент в восьмеричное число
                int i = Convert.ToInt32(s1, 8);
                // Конвертируем второй аргумент в восьмеричное число
                int j = Convert.ToInt32(s2, 8);
                return (Convert.ToString((i + j), 8));   // Возвращаем результат сложения
            }
            catch (Exception)
            {
                // Возвращаем строку "<Error>" в случае неудачного преобразования, или сложения
                return "<Error>";
            }
        }

        /// <summary>
        /// Восьмеричный калькулятор.
        /// Операция разности.
        /// </summary>
        /// <param name="s1">Строковое представление первого восьмеричного числа</param>
        /// <param name="s2">Строковое представление второго восьмеричного числа</param>
        /// <returns>Строковое восьмеричного числа результата</returns>
        public string DifferenceOctalNumbers(string s1, string s2)
        {
            try
            {
                // Конвертируем первый аргумент в восьмеричное число
                int i = Convert.ToInt32(s1, 8);
                // Конвертируем второй аргумент в восьмеричное число
                int j = Convert.ToInt32(s2, 8);
                return (Convert.ToString((i - j), 8));  // Возвращаем результат разности чисел
            }
            catch (Exception)
            {
                // Возвращаем строку "<Error>" в случае неудачного преобразования, или разности
                return "<Error>";
            }
        }
    }
}
