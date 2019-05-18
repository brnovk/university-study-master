using System;

namespace Lab3.entities
{
    /// <summary>
    /// Изделие
    /// </summary>
    class Product
    {
        private const String objectName = "Product";

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
