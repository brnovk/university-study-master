using Pochasovka.Entities;
using System.Collections.Generic;
using System.Data.Common;
using System.Data.SQLite;

namespace Pochasovka.Database
{
    /// <summary>
    /// Класс обработчик для таблицы БД "Лимиты"
    /// </summary>
    public class LimitHandler
    {
        private static LimitHandler instance;
        
        private LimitHandler() { }

        public static LimitHandler getInstance()
        {
            if (instance == null)
            {
                instance = new LimitHandler();
            }
            return instance;
        }

        public List<Limit> getLimits()
        {
            ConsumptionSourceHandler consumptionSourceHandler = ConsumptionSourceHandler.getInstance();
            List<ConsumptionSource> consumptionSources = consumptionSourceHandler.getConsumptionSources();

            RateHandler rateHandler = RateHandler.getInstance();
            List<Rate> rates = rateHandler.getRates();

            List<Limit> result = new List<Limit>();
            SQLiteConnection connection = DBControl.getConnection();
            using (SQLiteCommand command = new SQLiteCommand(connection))
            {
                command.CommandText = "SELECT * FROM limits";
                using (SQLiteDataReader reader = command.ExecuteReader())
                {
                    foreach (DbDataRecord record in reader)
                    {
                        int id = int.Parse(record["id"].ToString());
                        int dayOfMonth = int.Parse(record["dayOfMonth"].ToString());
                        int volumeProducts = int.Parse(record["volumeProducts"].ToString());
                        double norm = double.Parse(record["norm"].ToString());
                        double consumptionPowerElectric = double.Parse(record["consumptionPowerElectric"].ToString());
                        double consumptionPowerLight = double.Parse(record["consumptionPowerLight"].ToString());
                        double totalPower = double.Parse(record["totalPower"].ToString());
                        double consumedOneDayEnergy = double.Parse(record["consumedOneDayEnergy"].ToString());
                        double cost = double.Parse(record["cost"].ToString());
                        int consumptionSourceId = int.Parse(record["consumptionSourceId"].ToString());
                        int rateId = int.Parse(record["rateId"].ToString());
                        ConsumptionSource insertSource = null;
                        foreach (ConsumptionSource current in consumptionSources)
                        {
                            if (current.Id == consumptionSourceId)
                            {
                                insertSource = current;
                                break;
                            }
                        }
                        Rate insertRate = null;
                        foreach (Rate current in rates)
                        {
                            if (current.Id == rateId)
                            {
                                insertRate = current;
                                break;
                            }
                        }
                        result.Add(new Limit(id, dayOfMonth, volumeProducts, norm, consumptionPowerElectric,
                            consumptionPowerLight, totalPower, consumedOneDayEnergy, cost, insertSource, insertRate));
                    }
                }
            }
            DBControl.close();
            return result;
        }

        public void addLimit(int dayOfMonth, int volumeProducts, double norm, double consumptionPowerElectric, 
            double consumptionPowerLight, double totalPower, double consumedOneDayEnergy, double cost, 
            ConsumptionSource consumptionSource, Rate rate)
        {
            SQLiteConnection connection = DBControl.getConnection();
            using (SQLiteCommand command = new SQLiteCommand(connection))
            {
                command.CommandText = @"INSERT INTO limits (dayOfMonth, volumeProducts, norm, consumptionPowerElectric, 
                    consumptionPowerLight, totalPower, consumedOneDayEnergy, cost, consumptionSourceId, rateId) 
                    VALUES (@dayOfMonth, @volumeProducts, @norm, @consumptionPowerElectric, 
                    @consumptionPowerLight, @totalPower, @consumedOneDayEnergy, @cost, 
                    (SELECT consumptionSources.id FROM consumptionSources WHERE consumptionSources.id = @consumptionSourceId), 
                    (SELECT rates.id FROM rates WHERE rates.id = @rateId))";
                command.Parameters.AddWithValue("@dayOfMonth", dayOfMonth);
                command.Parameters.AddWithValue("@volumeProducts", volumeProducts);
                command.Parameters.AddWithValue("@norm", norm);
                command.Parameters.AddWithValue("@consumptionPowerElectric", consumptionPowerElectric);
                command.Parameters.AddWithValue("@consumptionPowerLight", consumptionPowerLight);
                command.Parameters.AddWithValue("@totalPower", totalPower);
                command.Parameters.AddWithValue("@consumedOneDayEnergy", consumedOneDayEnergy);
                command.Parameters.AddWithValue("@cost", cost);
                command.Parameters.AddWithValue("@consumptionSourceId", consumptionSource.Id);
                command.Parameters.AddWithValue("@rateId", rate.Id);
                command.ExecuteNonQuery();
            }
            DBControl.close();
        }

        public void editLimit(int id, int dayOfMonth, int volumeProducts, double norm, double consumptionPowerElectric,
            double consumptionPowerLight, double totalPower, double consumedOneDayEnergy, double cost,
            ConsumptionSource consumptionSource, Rate rate)
        {
            SQLiteConnection connection = DBControl.getConnection();
            using (SQLiteCommand command = new SQLiteCommand(connection))
            {
                command.CommandText = @"UPDATE limits SET 
                    dayOfMonth = @dayOfMonth, 
                    volumeProducts = @volumeProducts, 
                    norm = @norm, 
                    consumptionPowerElectric = @consumptionPowerElectric, 
                    consumptionPowerLight = @consumptionPowerLight, 
                    totalPower = @totalPower, 
                    consumedOneDayEnergy = @consumedOneDayEnergy, 
                    cost = @cost, 
                    consumptionSourceId = (SELECT consumptionSources.id FROM consumptionSources 
                    WHERE consumptionSources.id = @consumptionSourceId), 
                    rateId = (SELECT rates.id FROM rates WHERE rates.id = @rateId) 
                    WHERE limits.id = @id";
                command.Parameters.AddWithValue("@dayOfMonth", dayOfMonth);
                command.Parameters.AddWithValue("@volumeProducts", volumeProducts);
                command.Parameters.AddWithValue("@norm", norm);
                command.Parameters.AddWithValue("@consumptionPowerElectric", consumptionPowerElectric);
                command.Parameters.AddWithValue("@consumptionPowerLight", consumptionPowerLight);
                command.Parameters.AddWithValue("@totalPower", totalPower);
                command.Parameters.AddWithValue("@consumedOneDayEnergy", consumedOneDayEnergy);
                command.Parameters.AddWithValue("@cost", cost);
                command.Parameters.AddWithValue("@consumptionSourceId", consumptionSource.Id);
                command.Parameters.AddWithValue("@rateId", rate.Id);
                command.Parameters.AddWithValue("@id", id);
                command.ExecuteNonQuery();
            }
            DBControl.close();
        }

        public void deleteLimitById(int id)
        {
            SQLiteConnection connection = DBControl.getConnection();
            using (SQLiteCommand command = new SQLiteCommand(connection))
            {
                command.CommandText = "DELETE FROM limits WHERE id = @id";
                command.Parameters.AddWithValue("@id", id);
                command.ExecuteNonQuery();
            }
            DBControl.close();
        }

        public void deleteAllLimits()
        {
            SQLiteConnection connection = DBControl.getConnection();
            using (SQLiteCommand command = new SQLiteCommand(connection))
            {
                command.CommandText = "DELETE FROM limits";
                command.ExecuteNonQuery();
            }
            DBControl.close();
        }

        public Limit getLimitById(int findId)
        {
            ConsumptionSourceHandler consumptionSourceHandler = ConsumptionSourceHandler.getInstance();
            List<ConsumptionSource> consumptionSources = consumptionSourceHandler.getConsumptionSources();

            RateHandler rateHandler = RateHandler.getInstance();
            List<Rate> rates = rateHandler.getRates();

            Limit result = null;
            SQLiteConnection connection = DBControl.getConnection();
            using (SQLiteCommand command = new SQLiteCommand(connection))
            {
                command.CommandText = "SELECT * FROM limits WHERE id = @id";
                command.Parameters.AddWithValue("@id", findId);
                using (SQLiteDataReader reader = command.ExecuteReader())
                {
                    foreach (DbDataRecord record in reader)
                    {
                        int id = int.Parse(record["id"].ToString());
                        int dayOfMonth = int.Parse(record["dayOfMonth"].ToString());
                        int volumeProducts = int.Parse(record["volumeProducts"].ToString());
                        double norm = double.Parse(record["norm"].ToString());
                        double consumptionPowerElectric = double.Parse(record["consumptionPowerElectric"].ToString());
                        double consumptionPowerLight = double.Parse(record["consumptionPowerLight"].ToString());
                        double totalPower = double.Parse(record["totalPower"].ToString());
                        double consumedOneDayEnergy = double.Parse(record["consumedOneDayEnergy"].ToString());
                        double cost = double.Parse(record["cost"].ToString());
                        int consumptionSourceId = int.Parse(record["consumptionSourceId"].ToString());
                        int rateId = int.Parse(record["rateId"].ToString());
                        ConsumptionSource insertSource = null;
                        foreach (ConsumptionSource current in consumptionSources)
                        {
                            if (current.Id == consumptionSourceId)
                            {
                                insertSource = current;
                                break;
                            }
                        }
                        Rate insertRate = null;
                        foreach (Rate current in rates)
                        {
                            if (current.Id == rateId)
                            {
                                insertRate = current;
                                break;
                            }
                        }
                        result = new Limit(id, dayOfMonth, volumeProducts, norm, consumptionPowerElectric,
                            consumptionPowerLight, totalPower, consumedOneDayEnergy, cost, insertSource, insertRate);
                        break;
                    }
                }
            }
            DBControl.close();
            return result;
        }
    }
}
