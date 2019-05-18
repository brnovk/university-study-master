using System.Collections.Generic;
using System.Text;
using ScheduleWriter.Model.Enums;

namespace ScheduleWriter.Model.Beans {

    /// <summary>
    /// Класс описывающий пару. Содержит день недели, номер пары по счёту,
    /// и коллекцию всех частей пары.
    /// </summary>
    public class Pair {

        /// <summary>
        /// День недели
        /// </summary>
        public WeekDay WeekDay { get; set; }

        /// <summary>
        /// Номер пары
        /// </summary>
        public NumberPair NumberPair { get; set; }

        /// <summary>
        /// Коллекция частей пары
        /// </summary>
        private IList<PartPair> _partPairs;

        /// <summary>
        /// Геттер/сеттер коллекции. Геттер возвращает ReadOnlyCollection
        /// </summary>
        public IList<PartPair> PartPairs {
            get { return _partPairs; }
            set { _partPairs = value; }
        }

        public Pair() { }

        public Pair(WeekDay weekDay, NumberPair numberPair,
            IList<PartPair> partPairs) {
            WeekDay = weekDay;
            _partPairs = partPairs;
            NumberPair = numberPair;
        }

        protected bool Equals(Pair other) {
            return Equals(_partPairs, other._partPairs)
                && WeekDay == other.WeekDay
                && NumberPair == other.NumberPair;
        }

        public override string ToString() {
            const string format = " {0}, {1}, {2}\n";
            var partPairsString = new StringBuilder();
            foreach (var item in _partPairs) {
                partPairsString.AppendFormat("{0}\n", item.ToString());
            }
            return string.Format(format,
                EnumDescription.GetEnumDescription(WeekDay),
                EnumDescription.GetEnumDescription(NumberPair),
                partPairsString.ToString());
        }
    }
}