#pragma warning disable 0659    // hasCode не нужен

namespace Pochasovka.Entities
{
    /// <summary>
    /// Сущность "Структурное подразделение"
    /// </summary>
    public class Structural
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

        public Structural() {}

        public Structural(int id, string name)
        {
            this.id = id;
            this.name = name;
        }

        public override bool Equals(object obj)
        {
            if (obj == null || GetType() != obj.GetType())
            {
                return false;
            }
            Structural other = obj as Structural;
            return (other.id == id) && (other.name == name);
        }
    }
}
