using System;

namespace Task3.entities
{
    /// <summary>
    /// Товар
    /// </summary>
    class Merchandise
    {
        private const String objectName = "Merchandise";

        public String getClassName()
        {
            return GetType().Name;
        }

        public virtual String polymorphicMethod()
        {
            return objectName;
        }
    }
}
