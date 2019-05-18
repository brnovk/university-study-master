using System;

namespace Task2
{

    /// <summary>
    /// Класс helper для вычисления корня n-ой степени из числа методом Ньютона
    /// с заданной точностью.
    /// </summary>
    class NthRootNewton
    {

        /// <summary>
        /// Метод вычисления корня
        /// </summary>
        /// <param name="number">Число</param>
        /// <param name="degree">Степень</param>
        /// <param name="accuracy">Точность</param>
        /// <returns></returns>
        public double calculate(double number, int degree, double accuracy)
        {
            var result = 1.0;
            var precision = Math.Min(accuracy, 0.5);
            while (true)
            {
                var power = powDouble(result, degree - 1);
                var delta = (number / power - result) / degree;
                if (Math.Abs(delta) < precision)
                {
                    break;
                }
                result = result + delta;
            }
            return result;
        }

        /// <summary>
        /// Вспомогательный метод вычисления степени
        /// </summary>
        /// <param name="number">Число</param>
        /// <param name="power">Степень</param>
        /// <returns></returns>
        private double powDouble(double number, int power)
        {
            double result = 1;
            while (power > 0)
            {
                if ((power & 1) == 1)
                {
                    result = (result * number);
                }
                number = (number * number);
                power /= 2;
            }
            return result;
        }
    }
}
