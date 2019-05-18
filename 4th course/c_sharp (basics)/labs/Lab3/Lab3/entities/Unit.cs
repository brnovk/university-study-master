using System;

namespace Lab3.entities
{
    /// <summary>
    /// Узел
    /// </summary>
    class Unit : Product
    {
        private const String objectName = "Unit";

        public override String polymorphicMethod()
        {
            return objectName;
        }
    }
}
