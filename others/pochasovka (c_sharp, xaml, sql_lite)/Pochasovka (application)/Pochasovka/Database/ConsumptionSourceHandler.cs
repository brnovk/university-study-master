using Pochasovka.Entities;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Data.SQLite;

namespace Pochasovka.Database
{
    /// <summary>
    /// Класс обработчик для таблицы БД "Источники потребления"
    /// </summary>
    class ConsumptionSourceHandler
    {
        private static ConsumptionSourceHandler instance;

        public static ConsumptionSourceHandler getInstance()
        {
            if (instance == null)
            {
                instance = new ConsumptionSourceHandler();
            }
            return instance;
        }

        public List<ConsumptionSource> getConsumptionSources()
        {
            StructuralHandler structuralHandler = StructuralHandler.getInstance();
            List<Structural> structurals = structuralHandler.getStructurals();

            List<ConsumptionSource> result = new List<ConsumptionSource>();
            SQLiteConnection connection = DBControl.getConnection();
            using (SQLiteCommand command = new SQLiteCommand(connection))
            {
                command.CommandText = "SELECT * FROM consumptionSources";
                using (SQLiteDataReader reader = command.ExecuteReader())
                {
                    foreach (DbDataRecord record in reader)
                    {
                        int id = int.Parse(record["id"].ToString());
                        string name = record["name"].ToString();
                        int structuralId = int.Parse(record["structuralId"].ToString());
                        foreach (Structural structural in structurals)
                        {
                            if (structural.Id == structuralId)
                            {
                                result.Add(new ConsumptionSource(id, name, structural));
                            }
                        }
                    }
                }
            }
            DBControl.close();
            return result;
        }

        public void addConsumptionSources(Structural structural, string name)
        {
            SQLiteConnection connection = DBControl.getConnection();
            using (SQLiteCommand command = new SQLiteCommand(connection))
            {
                command.CommandText = @"INSERT INTO consumptionSources (name, structuralId) 
                    VALUES (@name, (SELECT structurals.id FROM structurals WHERE structurals.id = @id))";
                command.Parameters.AddWithValue("@name", name);
                command.Parameters.AddWithValue("@id", structural.Id);
                command.ExecuteNonQuery();
            }
            DBControl.close();
        }

        public void deleteConsumptionSourceById(int id)
        {
            LimitHandler limitHandler = LimitHandler.getInstance();
            List<Limit> limits = limitHandler.getLimits();
            foreach (Limit limit in limits)
            {
                if (limit.ConsumptionSource.Id == id)
                {
                    throw new InvalidOperationException("На этот источник потребления есть ссылки в таблице \"Лимиты\"");
                }
            }
            SQLiteConnection connection = DBControl.getConnection();
            using (SQLiteCommand command = new SQLiteCommand(connection))
            {
                command.CommandText = "DELETE FROM consumptionSources WHERE id = @id";
                command.Parameters.AddWithValue("@id", id);
                command.ExecuteNonQuery();
            }
            DBControl.close();
        }
    }
}
