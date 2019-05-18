using System;

namespace ClassLibrary1
{
    public class Class1
    {

        /// <summary>
        /// Реверс строки («переворот»)
        /// </summary>
        public string ReverseString(string s)
        {
            char[] arr = s.ToCharArray();
            Array.Reverse(arr);
            return new string(arr);
        }
        
        /// <summary>
        /// Замена прописных букв строчными (в т.ч. для русских букв)
        /// </summary>
        public string Shift(string s1)
        {
            return s1.ToLowerInvariant();
        }
    }
}
