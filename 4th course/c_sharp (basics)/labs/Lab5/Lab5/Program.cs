using System;
using Lab5.entities;
using Lab5.exceptions;

namespace Lab5
{
    /// <summary>
    /// Реализовать обработку ошибок для лабораторной работы №4, при этом 
    /// переопределив с помощью наследования событие IndexOutOfRangeException.
    /// 
    /// Я не понял что именно требуется сделать в этом задании. 
    /// От IndexOutOfRangeException унаследоваться нельзя, он sealed. 
    /// Сделал свой Exception с похожим именем и выбрасываю в случае 
    /// возникновения системного IndexOutOfRangeException.
    /// </summary>
    class Program
    {
        private const String FAREWELL_MESSAGE = "\nProgram will be completed...";

        static void Main(string[] args)
        {
            Product[] products = new Product[] { new Product(),
                                                 new Component(),
                                                 new Unit(),
                                                 new Component()};
            try
            {
                try
                {
                    System.Console.WriteLine(products[100500]);
                }
                catch (System.IndexOutOfRangeException ex)
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
