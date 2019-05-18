#pragma warning disable 0659    // hasCode не нужен

namespace Pochasovka.Entities
{
    /// <summary>
    /// Сущность "Источник потребления"
    /// </summary>
    public class ConsumptionSource
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

        private string name;
        public string Name
        {
            get
            {
                return name;
            }
            set
            {
                name = value;
            }
        }

        private Structural structural;
        public Structural Structural
        {
            get
            {
                return structural;
            }
            set
            {
                structural = value;
            }
        }

        public ConsumptionSource() { }

        public ConsumptionSource(int id, string name, Structural structural)
        {
            this.id = id;
            this.name = name;
            this.structural = structural;
        }

        public override bool Equals(object obj)
        {
            if (obj == null || GetType() != obj.GetType())
            {
                return false;
            }
            ConsumptionSource other = obj as ConsumptionSource;
            return (other.id == id) && (other.name == name) && (other.structural.Equals(structural));
        }
    }
}
