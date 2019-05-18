using System;

namespace Task3.entities
{
    /// <summary>
    /// Игрушка
    /// </summary>
    class Toy : Merchandise
    {
        private const String objectName = "Toy";

        public override String polymorphicMethod()
        {
            return objectName;
        }
    }
}
