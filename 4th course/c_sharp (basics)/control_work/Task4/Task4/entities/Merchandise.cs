using Task4.ifaces;

namespace Task4.entities
{
    /// <summary>
    /// Товар
    /// </summary>
    class Merchandise : ICost
    {
        protected int cost;

        public Merchandise()
        {
        }

        public Merchandise(int cost)
        {
            this.cost = cost;
        }

        public void printCost()
        {
            System.Console.WriteLine(cost);
        }
    }
}
