using System;
using Lab2.entities;

namespace Lab2
{
    /// <summary>
    /// Построить иерархию классов: "Деталь", "Механизм", "Изделие", "Узел".
    /// 
    /// Так как сущности весьма специфические, в корректности иеархии я не уверен:
    /// Суперкласс: "Изделие".
    /// Наследники: "Деталь", "Изделие" и "Узел".
    /// </summary>
    class Program
    {
        private static String FAREWELL_MESSAGE = "\nProgram will be completed...";

        static void Main(string[] args)
        {
            // Массив "суперклассов", который заполняется объектами подклассов.
            Product[] products = new Product[] { new Product(),
                                                 new Component(),
                                                 new Unit(),
                                                 new Component()};

            foreach (Product currentProduct in products)
            {
                System.Console.WriteLine(currentProduct.ToString());
            }

            System.Console.WriteLine(FAREWELL_MESSAGE);
            System.Console.ReadKey();
        }
    }
}
