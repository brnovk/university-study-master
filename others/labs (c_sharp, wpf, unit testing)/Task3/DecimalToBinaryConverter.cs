using System;

namespace Task3
{
    class DecimalToBinaryConverter
    {
        public string convert(long decimalNumber)
        {
            const int toBase = 2;
            return Convert.ToString(decimalNumber, toBase);
        }
    }
}
