using ScheduleWriter.Model.Enums;

namespace ScheduleWriter.Model.Beans {

    /// <summary>
    /// Класс описания части учебной пары. Описывает название предмета,
    /// аудиторию, лектрора(ов) и тип этой части пары.
    /// </summary>
    public class PartPair {

        /// <summary>
        /// Название предмета
        /// </summary>
        public string SubjectName { get; set; }

        /// <summary>
        /// Аудитория
        /// </summary>
        public string Audience { get; set; }

        /// <summary>
        /// Лектор 1
        /// </summary>
        public string Lecturer1 { get; set; }

        /// <summary>
        /// Лектор 2
        /// </summary>
        public string Lecturer2 { get; set; }

        /// <summary>
        /// Тип этой части пары
        /// </summary>
        public PartPairType Type { get; set; }

        public PartPair() { }

        public PartPair(string subjectName, string audience, string lecturer1,
            string lecturer2, PartPairType type) {
            SubjectName = subjectName;
            Audience = audience;
            Lecturer1 = lecturer1;
            Lecturer2 = lecturer2;
            Type = type;
        }

        protected bool Equals(PartPair other) {
            return string.Equals(SubjectName, other.SubjectName)
                && string.Equals(Audience, other.Audience)
                && string.Equals(Lecturer1, other.Lecturer1)
                && string.Equals(Lecturer2, other.Lecturer2)
                && Type == other.Type;
        }

        public override int GetHashCode() {
            unchecked {
                var hashCode =
                    (SubjectName != null ? SubjectName.GetHashCode() : 0);
                hashCode = (hashCode * 397)
                    ^ (Audience != null ? Audience.GetHashCode() : 0);
                hashCode = (hashCode * 397)
                    ^ (Lecturer1 != null ? Lecturer1.GetHashCode() : 0);
                hashCode = (hashCode * 397)
                    ^ (Lecturer2 != null ? Lecturer2.GetHashCode() : 0);
                hashCode = (hashCode * 397) ^ (int)Type;
                return hashCode;
            }
        }

        public override string ToString() {
            const string format = "{0}, {1}, {2}, {3}, {4}";
            return string.Format(format, SubjectName, Audience, Lecturer1,
                Lecturer2, EnumDescription.GetEnumDescription(Type));
        }
    }
}
