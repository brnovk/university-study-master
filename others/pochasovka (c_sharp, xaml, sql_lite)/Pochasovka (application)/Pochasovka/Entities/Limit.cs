#pragma warning disable 0659    // hasCode не нужен

namespace Pochasovka.Entities
{
    /// <summary>
    /// Сущность "Лимит"
    /// </summary>
    public class Limit
    {
        private int id;
        public int Id
        {
            get
            {
                return id;
            }
            set
            {
                id = value;
            }
        }

        private ConsumptionSource consumptionSource;
        public ConsumptionSource ConsumptionSource
        {
            get
            {
                return consumptionSource;
            }
            set
            {
                consumptionSource = value;
            }
        }

        private int dayOfMonth;
        public int DayOfMonth
        {
            get
            {
                return dayOfMonth;
            }
            set
            {
                dayOfMonth = value;
            }
        }

        private int volumeProducts;
        public int VolumeProducts
        {
            get
            {
                return volumeProducts;
            }
            set
            {
                volumeProducts = value;
            }
        }

        private double norm;
        public double Norm
        {
            get
            {
                return norm;
            }
            set
            {
                norm = value;
            }
        }

        private Rate rate;
        public Rate Rate
        {
            get
            {
                return rate;
            }
            set
            {
                rate = value;
            }
        }

        private double consumptionPowerElectric;
        public double ConsumptionPowerElectric
        {
            get
            {
                return consumptionPowerElectric;
            }
            set
            {
                consumptionPowerElectric = value;
            }
        }

        private double consumptionPowerLight;
        public double ConsumptionPowerLight
        {
            get
            {
                return consumptionPowerLight;
            }
            set
            {
                consumptionPowerLight = value;
            }
        }

        private double totalPower;
        public double TotalPower
        {
            get
            {
                return totalPower;
            }
            set
            {
                totalPower = value;
            }
        }

        private double consumedOneDayEnergy;
        public double ConsumedOneDayEnergy
        {
            get
            {
                return consumedOneDayEnergy;
            }
            set
            {
                consumedOneDayEnergy = value;
            }
        }

        public double cost;
        public double Cost
        {
            get
            {
                return cost;
            }
            set
            {
                cost = value;
            }
        }

        public Limit() { }

        public Limit(int id, int dayOfMonth, int volumeProducts, double norm, double consumptionPowerElectric, 
            double consumptionPowerLight, double totalPower, double consumedOneDayEnergy, double cost,
            ConsumptionSource consumptionSource, Rate rate)
        {
            this.id = id;
            this.dayOfMonth = dayOfMonth;
            this.volumeProducts = volumeProducts;
            this.norm = norm;
            this.consumptionPowerElectric = consumptionPowerElectric;
            this.consumptionPowerLight = consumptionPowerLight;
            this.totalPower = totalPower;
            this.consumedOneDayEnergy = consumedOneDayEnergy;
            this.cost = cost;
            this.consumptionSource = consumptionSource;
            this.rate = rate;
        }
        
        public override bool Equals(object obj)
        {
            if (obj == null || GetType() != obj.GetType())
            {
                return false;
            }
            Limit other = obj as Limit;
            return (other.id == id)
                && (other.dayOfMonth == dayOfMonth)
                && (other.volumeProducts == volumeProducts)
                && (other.norm == norm)
                && (other.consumptionPowerElectric == consumptionPowerElectric)
                && (other.consumptionPowerLight == consumptionPowerLight)
                && (other.totalPower == totalPower)
                && (other.consumedOneDayEnergy == consumedOneDayEnergy)
                && (other.cost == cost)
                && (other.consumptionSource.Equals(consumptionSource))
                && (other.rate.Equals(rate));
        }
    }
}
