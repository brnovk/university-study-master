using Pochasovka.Entities;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Data.SQLite;

namespace Pochasovka.Database
{
    /// <summary>
    /// Класс обработчик для таблицы БД "Тарифы"
    /// </summary>
    class RateHandler
    {
        private static RateHandler instance;

        private RateHandler() { }

        public static RateHandler getInstance()
        {
            if (instance == null)
            {
                instance = new RateHandler();
            }
            return instance;
        }

        public List<Rate> getRates()
        {
            List<Rate> rates = new List<Rate>();
            SQLiteConnection connection = DBControl.getConnection();
            using (SQLiteCommand command = new SQLiteCommand(connection))
            {
                command.CommandText = "SELECT * FROM rates";
                using (SQLiteDataReader reader = command.ExecuteReader())
                {
                    foreach (DbDataRecord record in reader)
                    {
                        int id = int.Parse(record["id"].ToString());
                        string name = record["name"].ToString();
                        double value = double.Parse(reader["value"].ToString());

                        rates.Add(new Rate(id, name, value));
                    }
                }
            }
            DBControl.close();
            return rates;
        }

        public void addRate(string name, double value)
        {
            SQLiteConnection connection = DBControl.getConnection();
            using (SQLiteCommand command = new SQLiteCommand(connection))
            {
                command.CommandText = "INSERT INTO rates (name, value) VALUES (@name, @value)";
                command.Parameters.AddWithValue("@name", name);
                command.Parameters.AddWithValue("@value", value);
                command.ExecuteNonQuery();
            }
            DBControl.close();
        }

        public void deleteRateById(int id)
        {
            LimitHandler limitHandler = LimitHandler.getInstance();
            List<Limit> limits = limitHandler.getLimits();
            foreach (Limit limit in limits)
            {
                if (limit.Rate.Id == id)
                {
                    throw new InvalidOperationException("На этот тариф есть ссылки в таблице \"Лимиты\"");
                }
            }
            SQLiteConnection connection = DBControl.getConnection();
            using (SQLiteCommand command = new SQLiteCommand(connection))
            {
                command.CommandText = "DELETE FROM rates WHERE id = @id";
                command.Parameters.AddWithValue("@id", id);
                command.ExecuteNonQuery();
            }
            DBControl.close();
        }
    }
}
