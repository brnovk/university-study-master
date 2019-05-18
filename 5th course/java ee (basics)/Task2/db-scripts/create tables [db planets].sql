DROP DATABASE IF EXISTS db_planet;
CREATE DATABASE IF NOT EXISTS db_planet;

USE db_planet;

-- -------------- Удаление таблиц, если они существуют -----------------------
-- -------------- Сначала дочерние, затем родительские. ----------------------

DROP TABLE IF EXISTS db_planet.satellites;
DROP TABLE IF EXISTS db_planet.planets;
DROP TABLE IF EXISTS db_planet.galaxies;


-- ----------------------- Создание таблиц. ----------------------------------
-- -------------- Сначала родительские, затем дочерние. ----------------------

-- Create Table Galaxies
CREATE TABLE db_planet.galaxies (
	id INT UNSIGNED AUTO_INCREMENT NOT NULL,
	name CHAR(50) CHARACTER SET utf8 NOT NULL,
	PRIMARY KEY (id)
) ENGINE = InnoDB ROW_FORMAT = DEFAULT CHARACTER SET utf8;

-- Create Table Planets
CREATE TABLE db_planet.planets (
	id INT UNSIGNED AUTO_INCREMENT NOT NULL,
	name CHAR(50) CHARACTER SET utf8 NOT NULL,
	radius INT UNSIGNED,
	coreTemperature INT,
	existAtmosphere TINYINT,
	existLife TINYINT,
	galaxiesId INT UNSIGNED,
	FOREIGN KEY (galaxiesId) 
	REFERENCES db_planet.galaxies (id) 
	ON UPDATE CASCADE 
	ON DELETE SET NULL,
	PRIMARY KEY (id)
) ENGINE = InnoDB ROW_FORMAT = DEFAULT CHARACTER SET utf8;

-- Create Table Satellites
CREATE TABLE db_planet.satellites (
	id INT UNSIGNED AUTO_INCREMENT NOT NULL,
	name CHAR(50) CHARACTER SET utf8 NOT NULL,
	radius INT(50) UNSIGNED,
	distanceToPlanet INT UNSIGNED,
	planetsId INT UNSIGNED,
	FOREIGN KEY (planetsId) 
	REFERENCES db_planet.planets (id) 
	ON UPDATE CASCADE 
	ON DELETE SET NULL,
	PRIMARY KEY (id)
) ENGINE = InnoDB ROW_FORMAT = DEFAULT CHARACTER SET utf8;



-- ----------------------- Заполнение таблиц. ---------------------------------
-- -------------- Сначала родительские, затем дочерние. -----------------------


-- Filling Table Galaxies

INSERT INTO galaxies (name) 
VALUES ('Milky Way');

INSERT INTO galaxies (name) 
VALUES ('Canis Major Overdensity');

INSERT INTO galaxies (name) 
VALUES ('Sagittarius Dwarf Spheroidal Galaxy');

INSERT INTO galaxies (name) 
VALUES ('Large Magellanic Cloud');

INSERT INTO galaxies (name) 
VALUES ('Boötes Dwarf Galaxy');


-- Filling Table Planets

INSERT INTO planets (name, radius, coreTemperature, existAtmosphere, 
	existLife, galaxiesId)
VALUES (
	'Earth', '6378', '5960', '1', '1',
	(SELECT galaxies.id FROM galaxies WHERE galaxies.name = 'Milky Way')
);

INSERT INTO planets (name, radius, coreTemperature, existAtmosphere, 
	existLife, galaxiesId)
VALUES (
	'Mars', '3390', '1100', '1', '0',
	(SELECT galaxies.id FROM galaxies WHERE galaxies.name = 'Milky Way')
);

INSERT INTO planets (name, radius, coreTemperature, existAtmosphere, 
	existLife, galaxiesId)
VALUES (
	'Jupiter', '69911', '30000', '1', '0',
	(SELECT galaxies.id FROM galaxies WHERE galaxies.name = 'Milky Way')
);

INSERT INTO planets (name, radius, coreTemperature, existAtmosphere, 
	existLife, galaxiesId)
VALUES (
	'Mercury','2440', null, '0', '0',
	(SELECT galaxies.id FROM galaxies WHERE galaxies.name = 'Milky Way')
);

INSERT INTO planets (name, radius, coreTemperature, existAtmosphere, 
	existLife, galaxiesId)
VALUES (
	'Neptune','24622', '7000', '1', '0',
	(SELECT galaxies.id FROM galaxies WHERE galaxies.name = 'Milky Way')
);


-- Filling Table Satellites

INSERT INTO satellites (satellites.name, satellites.radius, 
	satellites.distanceToPlanet, satellites.planetsId)
VALUES (
	'Moon', '1737', '384400',
	(SELECT planets.id FROM planets WHERE planets.name = 'Earth')
);

INSERT INTO satellites (satellites.name, satellites.radius, 
	satellites.distanceToPlanet, satellites.planetsId)
VALUES (
	'Rhea', null, '527040',
	null
);

INSERT INTO satellites (satellites.name, satellites.radius, 
	satellites.distanceToPlanet, satellites.planetsId)
VALUES (
	'Triton', '2000', '354000',
	(SELECT planets.id FROM planets WHERE planets.name = 'Neptune')
);

INSERT INTO satellites (satellites.name, satellites.radius, 
	satellites.distanceToPlanet, satellites.planetsId)
VALUES (
	'Deimos', '403', '20000',
	(SELECT planets.id FROM planets WHERE planets.name = 'Mars')
);

INSERT INTO satellites (satellites.name, satellites.radius, 
	satellites.distanceToPlanet, satellites.planetsId)
VALUES (
	'Phobos', '119', '6000',
	(SELECT planets.id FROM planets WHERE planets.name = 'Mars')
);


-- ------- Заполнение данными, которые добавляют смысл в задание -------


-- Вставка пары планет с "жизнью" в галактике Boötes Dwarf Galaxy

INSERT INTO planets (name, radius, coreTemperature, existAtmosphere, 
	existLife, galaxiesId)
VALUES (
	'somePlanet1', '42', '1313', '1', '1',
	(SELECT galaxies.id FROM galaxies WHERE galaxies.name = 'Boötes Dwarf Galaxy')
);

INSERT INTO planets (name, radius, coreTemperature, existAtmosphere, 
	existLife, galaxiesId)
VALUES (
	'somePlanet2', '3140000', '115', '1', '1',
	(SELECT galaxies.id FROM galaxies WHERE galaxies.name = 'Boötes Dwarf Galaxy')
);


-- Вставка пары спутников для одной из этих планет с жизнью

INSERT INTO satellites (satellites.name, satellites.radius, 
	satellites.distanceToPlanet, satellites.planetsId)
VALUES (
	'SomeSatellites1', '123', '45687',
	(SELECT planets.id FROM planets WHERE planets.name = 'somePlanet2')
);

INSERT INTO satellites (satellites.name, satellites.radius, 
	satellites.distanceToPlanet, satellites.planetsId)
VALUES (
	'SomeSatellites2', '321', '456456',
	(SELECT planets.id FROM planets WHERE planets.name = 'somePlanet2')
);

INSERT INTO satellites (satellites.name, satellites.radius, 
	satellites.distanceToPlanet, satellites.planetsId)
VALUES (
	'SomeSatellites3', '345', '543213',
	(SELECT planets.id FROM planets WHERE planets.name = 'somePlanet2')
);
