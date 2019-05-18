using System;

namespace ClassLibrary2
{
    public class Class2
    {
        /// <summary>
        /// Восьмеричный калькулятор.
        /// Операция умножения.
        /// </summary>
        /// <param name="s1">Строковое представление восьмеричного числа делимого</param>
        /// <param name="s2">Строковое представление восьмеричного числа делителя</param>
        /// <returns>Строковое восьмеричного числа результата</returns>
        public string MultiplicationOctalNumbers(string s1, string s2)
        {
            try
            {
                // Конвертируем первый аргумент в восьмеричное число
                int i = Convert.ToInt32(s1, 8);
                // Конвертируем второй аргумент в восьмеричное число
                int j = Convert.ToInt32(s2, 8);
                return (Convert.ToString((i * j), 8));   // Возвращаем результат умножения
            }
            catch (Exception)
            {
                // Возвращаем строку "<Error>" в случае неудачного преобразования, или умножения
                return "<Error>";
            }
        }

        /// <summary>
        /// Восьмеричный калькулятор.
        /// Операция взятия остатка от целочисленного деления.
        /// </summary>
        /// <param name="s1">Строковое представление первого восьмеричного числа</param>
        /// <param name="s2">Строковое представление второго восьмеричного числа</param>
        /// <returns>Строковое восьмеричного числа результата</returns>
        public string ModuloOctalNumbers(string s1, string s2)
        {
            try
            {
                // Конвертируем первый аргумент в восьмеричное число
                int i = Convert.ToInt32(s1, 8);
                // Конвертируем второй аргумент в восьмеричное число
                int j = Convert.ToInt32(s2, 8);
                return (Convert.ToString((i % j), 8));  // Возвращаем результат остатка от деления
            }
            catch (Exception)
            {
                // Возвращаем строку "<Error>" в случае неудачного преобразования, или деления
                return "<Error>";
            }
        }
    }
}
