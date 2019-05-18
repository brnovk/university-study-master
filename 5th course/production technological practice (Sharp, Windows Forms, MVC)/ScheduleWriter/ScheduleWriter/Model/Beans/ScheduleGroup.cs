using System.Collections.Generic;
using System.Text;

namespace ScheduleWriter.Model.Beans {

    /// <summary>
    /// Расписание группы
    /// </summary>
    public class ScheduleGroup {
        /// <summary>
        /// Имя группы
        /// </summary>
        private string GroupName { get; set; }

        /// <summary>
        /// Список всех пар этой группы
        /// </summary>
        private IList<Pair> _pairList;

        public IList<Pair> PairList {
            get { return _pairList; }
            set { _pairList = value; }
        }

        public ScheduleGroup() { }

        public ScheduleGroup(string groupName, IList<Pair> pairList) {
            GroupName = groupName;
            _pairList = pairList;
        }

        public override string ToString() {
            var pairListString = new StringBuilder();
            foreach (var item in _pairList) {
                pairListString.AppendFormat("{0}\n", item.ToString());
            }

            return string.Format("{0}\n{1}", GroupName, pairListString.ToString());
        }
    }
}
