using System;
using Task5.entities;
using Task5.exceptions;

namespace Task5
{
    /// <summary>
    /// Реализовать обработку ошибок для лабораторной работы №4, при этом 
    /// переопределив с помощью наследования событие IndexOutOfRangeException.
    /// 
    /// Я не понял что именно требуется сделать в этом задании. 
    /// От IndexOutOfRangeException унаследоваться нельзя, он sealed. 
    /// Сделал свой Exception с этим же именем и выбрасываю в случае 
    /// возникновения системного IndexOutOfRangeException.
    /// </summary>
    class Program
    {
        private const String FAREWELL_MESSAGE = "\nProgram will be completed...";

        static void Main(string[] args)
        {
            Merchandise[] goods = new Merchandise[] { new Merchandise(),
                                                      new Toy(),
                                                      new Product(),
                                                      new DairyProduct()};
            try
            {
                try
                {
                    System.Console.WriteLine(goods[100500]);
                }
                catch (IndexOutOfRangeException ex)
                {
                    printInfoException(ex);
                    throw new MyIndexOutOfRangeException(ex.Message, ex);
                }
            }
            catch (MyIndexOutOfRangeException ex)
            {
                printInfoException(ex);
            }

            System.Console.WriteLine(FAREWELL_MESSAGE);
            System.Console.ReadKey();
        }

        private static void printInfoException(Exception ex)
        {
            System.Console.WriteLine("Class: " + ex.GetType().Name);
            System.Console.WriteLine("Message: " + ex.Message);
            System.Console.WriteLine("Source: " + ex.Source);
            System.Console.WriteLine("StackTrace: " + ex.StackTrace);
            System.Console.WriteLine("TargetSite: " + ex.TargetSite);
            System.Console.WriteLine("-------------------------------");
        }
    }
}
