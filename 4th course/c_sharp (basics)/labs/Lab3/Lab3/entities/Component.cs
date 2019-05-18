using System;

namespace Lab3.entities
{
    /// <summary>
    /// Деталь
    /// </summary>
    class Component : Product
    {
        private const String objectName = "Component";

        public override String polymorphicMethod()
        {
            return objectName;
        }
    }
}
