using System;

namespace Task3.entities
{
    /// <summary>
    /// Продукт
    /// </summary>
    class Product : Merchandise
    {
        private const String objectName = "Product";

        public override String polymorphicMethod()
        {
            return objectName;
        }
    }
}
