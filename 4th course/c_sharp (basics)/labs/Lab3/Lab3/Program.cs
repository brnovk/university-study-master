using System;
using System.Collections.Generic;
using Lab3.entities;

namespace Lab3
{
    /// <summary>
    /// Расширить иерархию классов из лабораторной работы №2 с использованием 
    /// виртуального класса в качестве основы иерархии. 
    /// Показать пример использования полиморфизма методов.
    /// 
    /// В C# нету виртуальных классов. Как я понял, здесь подразумевается класс
    /// с виртуальным методом.
    /// </summary>
    class Program
    {
        private static String FAREWELL_MESSAGE = "\nProgram will be completed...";
        private static String FORMAT_OUT1 = "\nClass of an object: \"{0}\";";
        private static String FORMAT_OUT2 =
            "Call method from the class: \"{0}\";";

        static void Main(string[] args)
        {
            List<Product> products = new List<Product>();
            products.Add(new Product());
            products.Add(new Component());
            products.Add(new Unit());
            products.Add(new Mechanism());

            foreach (Product currentProduct in products)
            {
                System.Console.WriteLine(FORMAT_OUT1,
                    currentProduct.getClassName());

                // Если в подклассе переопределён данный метод, то вызывается он.
                // Если нет, то вызывается метод супер-класса.
                System.Console.WriteLine(FORMAT_OUT2,
                    currentProduct.polymorphicMethod());
            }

            System.Console.WriteLine(FAREWELL_MESSAGE);
            System.Console.ReadKey();
        }
    }
}
