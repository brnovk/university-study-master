#pragma warning disable 0659    // hasCode не нужен

namespace Pochasovka.Entities
{
    /// <summary>
    /// Сущность "Тариф"
    /// </summary>
    public class Rate 
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

        private double value;

        public double Value
        {
            get
            {
                return value;
            }
            set
            {
                this.value = value;
            }
        }

        public Rate() { }

        public Rate(int id, string name)
        {
            this.id = id;
            this.name = name;
        }

        public Rate(int id, string name, double value) 
            : this(id, name)
        {
            this.value = value;
        }
        
        public override bool Equals(object obj)
        {
            if (obj == null || GetType() != obj.GetType())
            {
                return false;
            }
            Rate other = obj as Rate;
            return (other.id == id)
                && (other.name == name)
                && (value.Equals(other.Value));
        }
    }
}
