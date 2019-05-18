using System;
using Task4.ifaces;

namespace Task4.entities
{
    /// <summary>
    /// Молочный продукт
    /// </summary>
    class DairyProduct : Product, IName, IWeight
    {
        private String name;

        private int weigth;

        public DairyProduct() : base()
        {
        }

        public DairyProduct(int cost) : base(cost)
        {
        }

        public DairyProduct(String name, int weigth)
        {
            this.name = name;
            this.weigth = weigth;
        }

        public DairyProduct(String name, int weigth, int cost)
        {
            this.name = name;
            this.weigth = weigth;
            base.cost = cost;
        }

        public void printWeigth()
        {
            System.Console.WriteLine(weigth);
        }

        public void printName()
        {
            System.Console.WriteLine(name);
        }
    }
}
