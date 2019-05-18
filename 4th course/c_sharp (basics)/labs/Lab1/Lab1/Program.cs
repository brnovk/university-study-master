using System;

namespace Lab1
{
    /// <summary>
    /// Реализовать функцию вычисления частного двух целых чисел.
    /// Исходные данные вводятся с клавиатуры.
    /// </summary>
    class Program
    {
        private const String TOOLTIP_INPUT = "-->";
        private const String MES1 = "Enter the first integer:";
        private const String MES2 = "Enter the second integer:";
        private const String MES3 = "Program will be completed...";
        private const String FORMAT_RESULT_MSG = "Result of dividing: {0} / {1} = {2}\n";

        static void Main(string[] args)
        {
            try
            {
                System.Console.WriteLine(MES1);
                int firstNumber = getInputNumber();

                System.Console.WriteLine(MES2);
                int secondNumber = getInputNumber();

                double result = division(firstNumber, secondNumber);
                System.Console.Write(FORMAT_RESULT_MSG, firstNumber, secondNumber, result);
            }
            // Ближайший суперкласс для FormatException и OverflowException
            catch (SystemException ex)
            {
                System.Console.WriteLine(ex.Message);
            }
            System.Console.WriteLine(MES3);
            System.Console.ReadKey();
        }

        private static double division(int firstNumber, int secondNumber)
        {
            return (double)firstNumber / (double)secondNumber;
        }

        /// <summary>
        /// Получает введённое пользователем с клавиатуры число.
        /// Выбрасывает FormatException, если введено не целое число.
        /// Выбрасывает OverflowException, если введено слишком большое число.
        /// </summary>
        private static int getInputNumber()
        {
            System.Console.Write(TOOLTIP_INPUT);
            String rawInputInt = Console.ReadLine();
            return Int32.Parse(rawInputInt);
        }
    }
}
