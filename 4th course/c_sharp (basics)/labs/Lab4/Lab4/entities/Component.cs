using System;
using Lab4.ifaces;

namespace Lab4.entities
{
    /// <summary>
    /// Деталь
    /// </summary>
    class Component : Product, IColor, IWeight
    {
        private String color;
        private int weigth;

        public Component() : base()
        {
        }

        public Component(int cost) : base(cost)
        {
        }

        public Component(String color, int weigth)
        {
            this.color = color;
            this.weigth = weigth;
        }

        public Component(String color, int weigth, int cost)
        {
            this.color = color;
            this.weigth = weigth;
            base.cost = cost;
        }

        public void printColor()
        {
            System.Console.WriteLine(color);
        }

        public void printWeigth()
        {
            System.Console.WriteLine(weigth);
        }
    }
}
