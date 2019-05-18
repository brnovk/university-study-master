using System;
using System.Reflection;

namespace ScheduleWriter.Model.Enums {

    public class EnumDescription : Attribute {

        private readonly string _text;

        public EnumDescription(string text) {
            _text = text;
        }

        public static string GetEnumDescription(Enum en) {
            Type type = en.GetType();
            MemberInfo[] memInfo = type.GetMember(en.ToString());
            if (memInfo.Length > 0) {
                object[] attrs = memInfo[0].GetCustomAttributes(
                    typeof(EnumDescription), false);
                if (attrs.Length > 0) {
                    return ((EnumDescription)attrs[0])._text;
                }
            }
            return en.ToString();
        }

        public static NumberPair GetNumberPair(int number) {
            if ((number < 0) || (number >= 6)) {
                throw new ArgumentException(number.ToString());
            }
            return (NumberPair)number;
        }

        public static WeekDay GetWeekDay(int weekDay) {
            if ((weekDay < 0) || (weekDay >= 6)) {
                throw new ArgumentException(weekDay.ToString());
            }
            return (WeekDay)weekDay;
        }
    }
}
