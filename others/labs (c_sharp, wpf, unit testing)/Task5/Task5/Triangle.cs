using System;

namespace Task5
{
    /// <summary>
    /// Треугольник
    /// </summary>
    public class Triangle
    {
        private double _firstSide;
        private double _secondSide;
        private double _thirdSide;

        public Triangle(double firstSide, double secondSide, double thirdSide)
        {
            if (!isTriangleExists(firstSide, secondSide, thirdSide))
            {
                throw new ArgumentException("Треугольник с такими сторонами не существует");
            }
            _firstSide = firstSide;
            _secondSide = secondSide;
            _thirdSide = thirdSide;
        }

        /// <summary>
        /// Проверка существования треугольника
        /// </summary>
        public static bool isTriangleExists(double firstSide, double secondSide,
                double thirdSide)
        {
            return (0 > thirdSide.CompareTo(firstSide + secondSide)) &&
                (0 > secondSide.CompareTo(firstSide + thirdSide)) &&
                (0 > firstSide.CompareTo(secondSide + thirdSide));
        }

        /// <summary>
        /// Рассчёт периметра треугольника
        /// </summary>
        public double Perimeter()
        {
            return _firstSide + _secondSide + _thirdSide;
        }

        /// <summary>
        /// Рассчёт площади треугольника
        /// </summary>
        public double Area()
        {
            double semiPerimeter = Perimeter() / 2;
            double buffer = semiPerimeter * (semiPerimeter - _firstSide)
                                          * (semiPerimeter - _secondSide)
                                          * (semiPerimeter - _thirdSide);
            return Math.Sqrt(buffer);
        }

        public double FirstSide
        {
            get
            {
                return _firstSide;
            }
        }

        public double SecondSide
        {
            get
            {
                return _secondSide;
            }
        }

        public double ThirdSide
        {
            get
            {
                return _thirdSide;
            }
        }
    }
}
