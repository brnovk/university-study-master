using System;
using Task2.entities;

namespace Task2
{
    /// <summary>
    /// Построить иерархию классов: 
    /// "Товар", "Игрушка", "Продукт", "Молочный продукт".
    /// 
    /// Суперкласс: "Товар"
    /// Наследники: "Продукт" и "Игрушка".
    /// Наследник класса "Продукт": "Молочный продукт"
    /// </summary>
    class Program
    {
        private static String FAREWELL_MESSAGE = "\nProgram will be completed...";

        static void Main(string[] args)
        {
            // Массив "суперклассов", который заполняется объектами подклассов.
            Merchandise[] goods = new Merchandise[] { new Merchandise(),
                                                      new Toy(),
                                                      new Product(),
                                                      new DairyProduct()};
            foreach (Merchandise currentMerchandise in goods)
            {
                System.Console.WriteLine(currentMerchandise.ToString());
            }

            System.Console.WriteLine(FAREWELL_MESSAGE);
            System.Console.ReadKey();
        }
    }
}
