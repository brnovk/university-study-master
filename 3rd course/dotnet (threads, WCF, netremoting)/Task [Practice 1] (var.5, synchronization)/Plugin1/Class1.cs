namespace Plugin1
{
    public class Class1
    {

        /// <summary>
        /// Метод сложения строк.
        /// </summary>
        public string FoldString(string s1, string s2)
        {
            return s1 + s2;
        }

        /// <summary>
        /// Метод замены строчных букв прописными (в т.ч. для русских букв)
        /// </summary>
        public string Shift(string s1)
        {
            return s1.ToUpperInvariant();
        }
    }
}
