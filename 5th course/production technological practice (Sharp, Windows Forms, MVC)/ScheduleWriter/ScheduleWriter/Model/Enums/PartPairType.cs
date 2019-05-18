namespace ScheduleWriter.Model.Enums {

    /// <summary>
    /// Тип части пары
    /// </summary>
    public enum PartPairType {

        /// <summary>
        /// Пара у всей группы
        /// </summary>
        [EnumDescription("Пара у всей группы")]
        PairWholeGroup,

        /// <summary>
        /// Пара у всей группы в неделе над чертой
        /// </summary>
        [EnumDescription("Пара у всей группы в неделе над чертой")]
        PairWholeGroupOverLine,

        /// <summary>
        /// Пара у всей группы в неделе под чертой
        /// </summary>
        [EnumDescription("Пара у всей группы в неделе под чертой")]
        PairWholeGroupBelowLine,

        /// <summary>
        /// Пара у первой подгруппы
        /// </summary>
        [EnumDescription("Пара у первой подгруппы")]
        PairSubgroupFirst,

        /// <summary>
        /// Пара у второй подгруппы
        /// </summary>
        [EnumDescription("Пара у второй подгруппы")]
        PairSubgroupSecond,

        /// <summary>
        /// Пара у первой подгруппы в неделе над чертой
        /// </summary>
        [EnumDescription("Пара у первой подгруппы в неделе над чертой")]
        PairSubgroupFirstOverLine,

        /// <summary>
        /// Пара у первой подгруппы в неделе под чертой
        /// </summary>
        [EnumDescription("Пара у первой подгруппы в неделе под чертой")]
        PairSubgroupFirstBelowLine,

        /// <summary>
        /// Пара у второй подгруппы в неделе над чертой
        /// </summary>
        [EnumDescription("Пара у второй подгруппы в неделе над чертой")]
        PairSubgroupSecondOverLine,

        /// <summary>
        /// Пара у второй подгруппы в неделе под чертой
        /// </summary>
        [EnumDescription("Пара у второй подгруппы в неделе под чертой")]
        PairSubgroupSecondBelowLine
    }
}
