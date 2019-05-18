using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Task5;

namespace Task5TestProject
{
    /// <summary>
    /// Класс тестов класса Triangle
    /// </summary>
    [TestClass]
    public class TriangleTest
    {

        /// <summary>
        /// Тест конструктора класса Triangle
        /// </summary>
        [TestMethod]
        [ExpectedException(typeof(ArgumentException))]
        public void TriangleConstructorTest()
        {
            // Создаётся объект класса Triangle с недопустимыми сторонами, с
            // которыми треугольник не может существовать.
            // Должно выброситься исключение ArgumentException.
            Triangle triangle = new Triangle(45.0, 42.0, 3.0);
        }

        /// <summary>
        /// Тест метода isTriangleExist()
        /// </summary>
        [TestMethod]
        public void TriangleExistTest()
        {
            // Корректные значение - ожидается true
            Assert.IsTrue(Triangle.isTriangleExists(45.0, 42.00001, 3.0));

            // Некорректные значения - ожидается false
            Assert.IsFalse(Triangle.isTriangleExists(45.0, 42.0, 3.0));
        }

        /// <summary>
        /// Тест метода Perimeter()
        /// </summary>
        [TestMethod]
        public void PerimeterTest()
        {
            // Ожидаемое значение
            double expected = 15.0;

            Triangle triangle = new Triangle(4.0, 5.0, 6.0);

            // Полученное значение
            double actual = triangle.Perimeter();

            // Точность для сравнения чисел типа double
            double delta = 0.0000000001;

            Assert.AreEqual(expected, actual, delta);
        }

        /// <summary>
        /// Тест метода Area()
        /// </summary>
        [TestMethod]
        public void AreaTest()
        {
            // Ожидаемое значение
            double expected = 9.921567416496;

            Triangle triangle = new Triangle(4.0, 5.0, 6.00000000001);

            // Полученное значение
            double actual = triangle.Area();

            // Точность для сравнения чисел типа double
            double delta = 0.0000000001;

            Assert.AreEqual(expected, actual, delta);
        }
    }
}
