
namespace ClassLibrary1
{
    public class Class1
    {
        public bool CheckingForDivisibilityByTwo(int number)
        {
            if (number < 0)
                number = -number;
            else if (number == 0)
                return false;
            number %= 2;
            return number == 0;
        }

        public bool CheckingForDivisibilityByThree(int number)
        {
            if (number < 0)
                number = -number;
            else if (number == 0)
                return false;
            number %= 3;
            return number == 0;
        }
    }
}
