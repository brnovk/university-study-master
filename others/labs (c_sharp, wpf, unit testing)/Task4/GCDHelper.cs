using System;
using System.Diagnostics;

namespace Task4
{

    /// <summary>
    /// Класс helper для вычисления НОД.
    /// </summary>
    class GCDHelper
    {

        /// <summary>
        /// Вычисление НОД обычным алгоритмом Евклида для 2-ух чисел.
        /// </summary>
        public int calculateGCDEuclid(int firstNumber, int secondNumber)
        {
            var maxNumber = Math.Max(firstNumber, secondNumber);
            var minNumber = Math.Min(firstNumber, secondNumber);
            var gcd = minNumber;
            while (maxNumber % minNumber != 0)
            {
                gcd = maxNumber % minNumber;
                maxNumber = minNumber;
                minNumber = gcd;
            }
            return gcd;
        }

        /// <summary>
        /// Вычисление НОД обычным алгоритмом Евклида для любого количество чисел.
        /// </summary>
        public int calculateGCDEuclid(params int[] numbers)
        {
            int result = numbers[0];
            for (int i = 1; i < numbers.Length; i++)
            {
                result = calculateGCDEuclid(result, numbers[i]);
            }
            return result;
        }

        /// <summary>
        /// Вычисление НОД бинарным алгоритмом Евклида для 2 чисел.
        /// </summary>
        /// <param name="elapsedTime">Выходной параметер времени выполнения</param>
        public int calculateBinaryGCD(int firstNumber, int secondNumber,
            out TimeSpan elapsedTime)
        {
            // Инициализаци и старт таймера
            Stopwatch stopWatch = new Stopwatch();
            stopWatch.Start();

            // Выполнение алгоритма
            int gcd = binaryGCD(firstNumber, secondNumber);

            // Остановка таймера и запись значения в выходной параметр
            stopWatch.Stop();
            elapsedTime = stopWatch.Elapsed;

            return gcd;
        }

        /// <summary>
        /// Вычисление НОД бинарным алгоритмом Евклида для 2 чисел.
        /// </summary>
        private int binaryGCD(int first, int second)
        {
            if (second == 0)
                return first;
            if (first == 0)
                return second;
            if ((first & 1) == 0 && (second & 1) == 0)
            {
                return binaryGCD(first >> 1, second >> 1) << 1;
            }
            else if ((first & 1) == 0)
            {
                return binaryGCD(first >> 1, second);
            }
            else if ((second & 1) == 0)
            {
                return binaryGCD(first, second >> 1);
            }
            else if (first >= second)
            {
                return binaryGCD((first - second) >> 1, second);
            }
            else
            {
                return binaryGCD(first, (second - first) >> 1);
            }
        }
    }
}
