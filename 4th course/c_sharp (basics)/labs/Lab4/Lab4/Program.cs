using System;
using System.Collections.Generic;
using Lab4.ifaces;
using Lab4.entities;

namespace Lab4
{
    /// <summary>
    /// Реализовать для иерархии из лабораторной работы №3 механизм интерфейсов, 
    /// при этом один из классов должен реализовывать как минимум 2 интерфейса. 
    /// Использовать для проверки всех методов данного класса многоадресный делегат.
    /// </summary>
    class Program
    {
        private delegate void TestDelegate();

        private static String FAREWELL_MESSAGE = "\nProgram will be completed...";
        private static String LABEL_OUT_COST = "Current cost: ";
        private static String LABEL_OUT_DELEGATE = "\nInvoking delegate:";

        static void Main(string[] args)
        {
            List<ICost> productCosts = new List<ICost>();
            productCosts.Add(new Product(500000));
            productCosts.Add(new Component(456222));
            productCosts.Add(new Unit(879777));
            productCosts.Add(new Mechanism(56000));

            // Так как суперкласс Product реализует интерфейс ICost, 
            // подклассы тоже могут вызывать метод printCost.
            foreach (ICost currentCost in productCosts)
            {
                System.Console.Write(LABEL_OUT_COST);
                currentCost.printCost();
            }

            // Проверка всех методов класса Component, используя 
            // многоадресный делегат
            Component component = new Component("White", 45, 1505000);
            TestDelegate componentDel;

            // Класс Component реализует интерфейс IColor
            componentDel = component.printColor;

            // Класс Component реализует интерфейс IWeight
            componentDel += component.printWeigth;

            // Класс Component реализует интерфейс ICost
            componentDel += component.printCost;

            System.Console.WriteLine(LABEL_OUT_DELEGATE);
            componentDel();

            System.Console.WriteLine(FAREWELL_MESSAGE);
            System.Console.ReadKey();
        }
    }
}
