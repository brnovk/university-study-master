
namespace ClassLibrary2
{
    public class Class2
    {
        public bool CheckingForDivisibilityByFive(int number)
        {
            if (number < 0)
                number = -number;
            else if (number == 0)
                return false;
            number %= 5;
            return number == 0;
        }

        public bool CheckingForDivisibilityByTen(int number)
        {
            if (number < 0)
                number = -number;
            else if (number == 0)
                return false;
            number %= 10;
            return number == 0;
        }
    }
}
