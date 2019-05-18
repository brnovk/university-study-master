/*

Погода. 

Таблица "осадки": тип;
Таблица "языки": язык;
Таблица "население": население, язык;
Таблица "регионы": название региона, площадь, население.
Таблица "погода": дата, температура, регион, осадки;


1. Вывести сведения о погоде в заданном регионе.
2. Вывести даты, когда в заданном регионе шел снег и температура была ниже заданной отрицательной.
3. Вывести информацию о погоде за прошедшую неделю в регионах, жители которых общаются на заданном языке.
4. Вывести среднюю температуру за прошедшую неделю в регионах с площадью больше заданной.

*/


# 1 На примере 'Великобритания'

SELECT weather.`date`, weather.temperature, rainfall.type 
FROM weather, regions, rainfall
WHERE weather.idRegion = regions.id AND 
  regions.name = 'Великобритания' AND
  weather.IdRainfall = rainfall.id;

# 2 На примере 'Австрия'
SELECT weather.`date`, weather.temperature, rainfall.type 
FROM weather, regions, rainfall
WHERE weather.idRegion = regions.id AND
  weather.IdRainfall = rainfall.id AND
  regions.name = 'Австрия' AND
  weather.temperature < 0 AND 
  rainfall.type = (
    SELECT rainfall.type 
    FROM rainfall 
    WHERE rainfall.type = 'Снег'
  );

# 3 На примере 'Английский'
SELECT `weather`.`date`, `weather`.temperature, rainfall.type, 
  regions.name
FROM weather, regions, rainfall, population, language
WHERE
  weather.idRegion = regions.id AND
  weather.IdRainfall = rainfall.id AND
  regions.idPopulation = population.id AND
  population.idLanguage = language.id AND
  language.title = 'Английский' AND
  date >= (CURDATE()-INTERVAL 1 WEEK -  INTERVAL WEEKDAY(CURDATE() - INTERVAL 1 WEEK)DAY) 
  AND date <= (CURDATE() - INTERVAL WEEKDAY(CURDATE())DAY - INTERVAL 1 DAY)
ORDER BY weather.`date`;

# 4 На примере 90000 кв.км
SELECT AVG(weather.temperature)
FROM weather, regions
WHERE
  weather.idRegion = regions.id AND
  regions.area > 90000 AND
  date >= (CURDATE()-INTERVAL 1 WEEK - INTERVAL WEEKDAY(CURDATE() - INTERVAL 1 WEEK)DAY) 
  AND date <= (CURDATE() - INTERVAL WEEKDAY(CURDATE())DAY - INTERVAL 1 DAY);
