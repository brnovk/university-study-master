using Lab4.ifaces;

namespace Lab4.entities
{
    /// <summary>
    /// Изделие
    /// </summary>
    class Product : ICost
    {
        protected int cost;

        public Product()
        {
        }

        public Product(int cost)
        {
            this.cost = cost;
        }

        public void printCost()
        {
            System.Console.WriteLine(cost);
        }
    }
}
