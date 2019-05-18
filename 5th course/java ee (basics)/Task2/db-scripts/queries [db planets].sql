/*

1. Вывести информацию обо всех планетах, на которых присутствует жизнь, 
   и их спутниках в заданной галактике.
2. Вывести информацию о планетах и их спутниках, имеющих наименьший радиус и
   наибольшее количество спутников.
3. Вывести информацию о планете, галактике, в которой она находится, и ее 
   спутниках, имеющей максимальное количество спутников, но с наименьшим общим 
   объемом этих спутников.
4. Найти галактику, сумма ядерных температур планет которой наибольшая.

*/


-- 1 На примере галактики 'Волопас I'

SELECT 
  planets.name, planets.radius, planets.coreTemperature, planets.existAtmosphere, 
  satellites.name, satellites.radius, distanceToPlanet 
FROM satellites, planets, galaxies
WHERE galaxies.name = 'Boötes Dwarf Galaxy' 
  AND galaxies.id = planets.galaxiesId 
  AND planets.existLife = 1  
  AND satellites.planetsId = planets.id;


-- 2 - некорректое условие!
-- somePlanet1 - радиус 20 км - 3 спутника
-- somePlanet2 - радиус 19 км - 2 спутника


-- 3

SELECT 
  planets.name, planets.radius, planets.coreTemperature, 
  planets.existAtmosphere, planets.existLife, galaxies.name,
  COUNT(satellites.planetsId) AS count_satellites,
  SUM(satellites.radius) AS min_sum_radius_satellites
FROM satellites, planets, galaxies
WHERE galaxies.id = planets.galaxiesId 
  AND planets.id = satellites.planetsId
GROUP BY satellites.planetsId
ORDER BY count_satellites DESC, 
  min_sum_radius_satellites ASC 
LIMIT 1;


-- 4

SELECT DISTINCT  
  galaxies.name, SUM(planets.coreTemperature) AS sum_core_temp 
FROM planets, galaxies
WHERE galaxies.id = planets.galaxiesId
GROUP BY galaxies.id
ORDER BY sum_core_temp DESC LIMIT 1;
