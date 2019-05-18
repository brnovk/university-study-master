using Pochasovka.Entities;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Data.SQLite;

namespace Pochasovka.Database
{
    /// <summary>
    /// Класс обработчик для таблицы БД "Структурные подразделения"
    /// </summary>
    class StructuralHandler
    {
        private static StructuralHandler instance;

        private StructuralHandler() {}

        public static StructuralHandler getInstance()
        {
            if (instance == null)
            {
                instance = new StructuralHandler();
            }
            return instance;
        }

        public List<Structural> getStructurals()
        {
            List<Structural> structurals = new List<Structural>();
            SQLiteConnection connection = DBControl.getConnection();
            using (SQLiteCommand command = new SQLiteCommand(connection))
            {
                command.CommandText = "SELECT * FROM structurals";
                using (SQLiteDataReader reader = command.ExecuteReader())
                {
                    foreach (DbDataRecord record in reader)
                    {
                        int id = int.Parse(record["id"].ToString());
                        string name = record["name"].ToString();
                        structurals.Add(new Structural(id, name));
                    }
                }
            }
            DBControl.close();
            return structurals;
        }

        public void addStructural(string name)
        {
            SQLiteConnection connection = DBControl.getConnection();
            using (SQLiteCommand command = new SQLiteCommand(connection))
            {
                command.CommandText = "INSERT INTO structurals (name) VALUES (@name)";
                command.Parameters.AddWithValue("@name", name);
                command.ExecuteNonQuery();
            }
            DBControl.close();
        }

        public void deleteStructuralById(int id)
        {
            ConsumptionSourceHandler consumptionSourceHandler = ConsumptionSourceHandler.getInstance();
            List<ConsumptionSource> consumptionSources = consumptionSourceHandler.getConsumptionSources();
            foreach (ConsumptionSource consumptionSource in consumptionSources)
            {
                if (consumptionSource.Structural.Id == id)
                {
                    throw new InvalidOperationException(
                        "На указанную структуру есть ссылки в таблице \"Источников потребления\"");
                }
            }
            SQLiteConnection connection = DBControl.getConnection();
            using (SQLiteCommand command = new SQLiteCommand(connection))
            {

                command.CommandText = "DELETE FROM structurals WHERE id = @id";
                command.Parameters.AddWithValue("@id", id);
                command.ExecuteNonQuery();
            }
            DBControl.close();
        }
    }
}
