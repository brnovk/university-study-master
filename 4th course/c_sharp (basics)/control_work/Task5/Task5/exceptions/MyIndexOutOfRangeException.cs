using System;

namespace Task5.exceptions
{
    class MyIndexOutOfRangeException : ApplicationException
    {
        public MyIndexOutOfRangeException() : base()
        {
        }

        public MyIndexOutOfRangeException(string message) : base(message)
        {
        }

        public MyIndexOutOfRangeException(string message, System.Exception inner)
            : base(message, inner)
        {
        }
    }
}
