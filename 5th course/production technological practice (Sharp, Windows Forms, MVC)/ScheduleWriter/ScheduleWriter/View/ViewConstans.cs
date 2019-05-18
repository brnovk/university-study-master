namespace ScheduleWriter.View {

    public static class ViewConstans {

        public const int ColumnCount = 16;
        public const int RowCount = 12;

        public static readonly string[] LabelsWeekDay = { "ПТ", "ВТ", "СР", "ЧТ", "ПТ", "СБ" };

        public static readonly string[] PairNumbers = { "1 пара", "2 пара", "3 пара", "4 пара", "5 пара", "6 пара" };

        public static readonly string[] PairTime =
        {
            "8:20 – 9:05",   "9:10 – 9:55",   "10:10 – 10:55", "11:00 – 11:45",
            "12:05 – 12.50", "12:55 – 13:40", "14:10 – 14:55", "15:00 – 15:45",
            "15:55 – 16:40", "16:45 – 17:30", "17:40 – 18:25", "18:30 – 19:15"
        };

        public const string EmptyValue = "";

        public const int WidthColumnPair = 20;
        public const int WidthColumnTime = 37;
        public const int WidthColumnWeekday = 72;

        public static bool FirstInitialize = true;
    }
}