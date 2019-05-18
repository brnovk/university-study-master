using System;
using System.Collections.Generic;
using Task4.entities;
using Task4.ifaces;

namespace Task4
{
    /// <summary>
    /// Реализовать для иерархии из лабораторной работы №3 механизм интерфейсов, 
    /// при этом один из классов должен реализовывать как минимум 2 интерфейса. 
    /// Использовать для проверки всех методов данного класса многоадресный делегат.
    /// </summary>
    class Program
    {
        public delegate void TestDelegate();

        private static String FAREWELL_MESSAGE = "\nProgram will be completed...";
        private static String LABEL_OUT_COST = "Current cost: ";
        private static String LABEL_OUT_DELEGATE = "\nInvoking delegate:";

        static void Main(string[] args)
        {
            List<ICost> merchandiseCosts = new List<ICost>();
            merchandiseCosts.Add(new Merchandise(45000));
            merchandiseCosts.Add(new Toy(155000));
            merchandiseCosts.Add(new Product(239000));
            merchandiseCosts.Add(new DairyProduct(15600));

            // Так как суперкласс Merchandise реализует интерфейс ICost, 
            // подклассы тоже могут вызывать метод printCost.
            foreach (ICost currentCost in merchandiseCosts)
            {
                System.Console.Write(LABEL_OUT_COST);
                currentCost.printCost();
            }

            // Проверка всех методов класса DairyProduct, используя 
            // многоадресный делегат
            DairyProduct dairyProduct = new DairyProduct("Kefir", 1000, 15500);
            TestDelegate productDel;

            // Класс DairyProduct реализует интерфейс IName
            productDel = dairyProduct.printName;

            // Класс DairyProduct реализует интерфейс IWeight
            productDel += dairyProduct.printWeigth;

            // Класс DairyProduct реализует интерфейс ICost
            productDel += dairyProduct.printCost;

            System.Console.WriteLine(LABEL_OUT_DELEGATE);
            productDel();

            System.Console.WriteLine(FAREWELL_MESSAGE);
            System.Console.ReadKey();
        }
    }
}
