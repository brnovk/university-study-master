using System;

namespace ClassLibrary3
{
    public class Class3 : MarshalByRefObject
    {
        /// <summary>
        /// Метод замены одной подстроки другой.
        /// </summary>
        /// <param name="s1">Исходная строка</param>
        /// <param name="substring">Подстрока для замены</param>
        /// <param name="beginSelect">Начало выделения</param>
        /// <param name="countSelect">Количество выделенных символов</param>
        public string ReplacingSubstring(string s1, string substring, int beginSelect,
            int countSelect)
        {
            Console.WriteLine("Called method \"ReplacingSubstring\" from"
            + " library \"ClassLibrary3.dll\";");
            // Проверка входных параметров (Начало выделения)
            if ((beginSelect) > (s1.Length))
            {
                return "";
            }
            // Проверка входных параметров (Количество выделенных символов)
            if ((beginSelect + countSelect) > (s1.Length))
            {
                return ""; 
            }
            // Удаляем из исходной строки выделенный фрагмент
            s1 = s1.Remove(beginSelect, countSelect);

            // Вставляем подстроку для замены
            s1 = s1.Insert(beginSelect, substring);

            return s1;
        }

        /// <summary>
        /// Метод назначения плагина.
        /// </summary>
        public string AppointmentPlugin()
        {
            Console.WriteLine("Called method \"AppointmentPlugin\" from"
                + " library \"ClassLibrary3.dll\";");
            return "Плагин \"ClassLibrary3.dll\" реализует функцию замены одной подстроки другой:"
                + " string ReplacingSubstring(string s1, string substring, " 
                + "int beginSelect, int countSelect)";
        }
    }
}
