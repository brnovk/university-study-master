using System.Data.SQLite;
using System.IO;

namespace Pochasovka.Database
{
    /// <summary>
    /// Класс-хелпер для работы с БД.
    /// </summary>
    class DBControl
    {
        private const string createTableRate = @"CREATE TABLE IF NOT EXISTS rates 
            (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, name NVARCHAR(255) NOT NULL, value DOUBLE NOT NULL)";

        private const string createTableStructural = @"CREATE TABLE IF NOT EXISTS structurals 
            (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, name NVARCHAR(255) NOT NULL)";

        private const string createTableConsumptionSource = @"CREATE TABLE IF NOT EXISTS consumptionSources 
            (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, name NVARCHAR(255) NOT NULL, 
            structuralId INTEGER NOT NULL, FOREIGN KEY(structuralId) REFERENCES structurals(id))";

        private const string createTableLimit = @"CREATE TABLE IF NOT EXISTS limits 
            (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, dayOfMonth INTEGER NOT NULL, 
            volumeProducts INTEGER NOT NULL, norm DOUBLE NOT NULL, consumptionPowerElectric DOUBLE NOT NULL, 
            consumptionPowerLight DOUBLE NOT NULL, totalPower DOUBLE NOT NULL, consumedOneDayEnergy DOUBLE NOT NULL,
            cost DOUBLE NOT NULL, consumptionSourceId INTEGER NOT NULL, rateId INTEGER NOT NULL, 
            FOREIGN KEY(consumptionSourceId) REFERENCES consumptionSources(id), 
            FOREIGN KEY(rateId) REFERENCES rates(id))";

        private const string dbPath = @"AppData/";
        private const string dbFile = @"DB.Pochasovka.s3db";
        private const string connString = @"Data Source="+ dbPath + dbFile + @";Version=3;";

        private static SQLiteConnection connection;

        /// <summary>
        /// Приватный конструктор - для запрета создания больше 1 экземпляра класса (Шаблон проектирования Синглтон)
        /// </summary>
        private DBControl() { }
        
        /// <summary>
        /// Получнени соединения с БД (Если БД не существует - создаётся)
        /// </summary>
        public static SQLiteConnection getConnection()
        {
            if (!Directory.Exists(dbPath) || !File.Exists(dbPath + dbFile))
            {
                databaseInitial();
            }
            if (connection == null)
            {
                connection = new SQLiteConnection(connString);
            }
            if (connection.State == System.Data.ConnectionState.Closed)
            {
                connection.Open();
            }
            return connection;
        }

        /// <summary>
        /// Закрытие соединения
        /// </summary>
        public static void close()
        {
            close(connection);
        }

        /// <summary>
        /// Закрытие соединения
        /// </summary>
        public static void close(SQLiteConnection connection)
        {
            connection.Close();
        }

        /// <summary>
        /// Инициализация базы данных: создание каталога AppData, создание файла БД, создание таблиц
        /// </summary>
        private static void databaseInitial()
        {
            Directory.CreateDirectory(dbPath);
            SQLiteConnection.CreateFile(dbPath + dbFile);
            using (SQLiteConnection conn = new SQLiteConnection(connString))
            {
                using (SQLiteCommand command = new SQLiteCommand(conn))
                {
                    conn.Open();
                    command.CommandText = createTableRate;
                    command.ExecuteNonQuery();
                    command.CommandText = createTableStructural;
                    command.ExecuteNonQuery();
                    command.CommandText = createTableConsumptionSource;
                    command.ExecuteNonQuery();
                    command.CommandText = createTableLimit;
                    command.ExecuteNonQuery();
                    conn.Close();
                }
            }
        }
    }
}
