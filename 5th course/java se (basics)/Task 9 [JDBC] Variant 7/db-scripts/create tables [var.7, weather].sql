
-- Создание базы данных db_weather, если её не существует
CREATE DATABASE IF NOT EXISTS `db_weather` 
CHARACTER SET utf8 COLLATE utf8_general_ci;

-- ----------------------------------------------------------------------------

-- Сначала удаляем дочерние таблицы, затем родительские (если они существуют)
DROP TABLE IF EXISTS db_weather.weather;
DROP TABLE IF EXISTS db_weather.regions;
DROP TABLE IF EXISTS db_weather.population;
DROP TABLE IF EXISTS db_weather.language;
DROP TABLE IF EXISTS db_weather.rainfall;

-- ----------------------------------------------------------------------------

USE `db_weather`;

-- Создание таблицы осадков, если её не существует
CREATE TABLE db_weather.rainfall (
	id INT UNSIGNED AUTO_INCREMENT NOT NULL,
	type CHAR(25) CHARACTER SET utf8 NOT NULL,
	PRIMARY KEY (id)
) ENGINE = InnoDB ROW_FORMAT = DEFAULT CHARACTER SET utf8;

-- Создание таблицы языков, если её не существует
CREATE TABLE db_weather.language (
	id INT UNSIGNED AUTO_INCREMENT NOT NULL,
	title CHAR(40) CHARACTER SET utf8 NOT NULL,
	PRIMARY KEY (id)
) ENGINE = InnoDB ROW_FORMAT = DEFAULT CHARACTER SET utf8;

-- Создание таблицы населения, если её не существует
-- Имеется вторичный ключ на таблицу языков
CREATE TABLE db_weather.population (
	id INT UNSIGNED AUTO_INCREMENT NOT NULL,
	population CHAR(50) CHARACTER SET utf8 NOT NULL,
	idLanguage INT UNSIGNED,
	CONSTRAINT languageLink FOREIGN KEY (idLanguage) 
		REFERENCES db_weather.language (id) 
		ON UPDATE CASCADE 
		ON DELETE SET NULL,
	PRIMARY KEY (id)
) ENGINE = InnoDB ROW_FORMAT = DEFAULT CHARACTER SET utf8;

-- Создание таблицы регионов, если её не существует
-- Имеется вторичный ключ на таблицу населения
CREATE TABLE db_weather.regions (
	id INT UNSIGNED AUTO_INCREMENT NOT NULL,
	name CHAR(50) CHARACTER SET utf8 NOT NULL,
	area BIGINT UNSIGNED,
	idPopulation INT UNSIGNED,
	CONSTRAINT populationLink FOREIGN KEY (idPopulation) 
		REFERENCES db_weather.population (id) 
		ON UPDATE CASCADE 
		ON DELETE SET NULL,
	PRIMARY KEY (id)
) ENGINE = InnoDB ROW_FORMAT = DEFAULT CHARACTER SET utf8;

-- Создание таблицы погоды, если её не существует
-- Имеется 2 вторичных ключа на таблицу регионов и осадков
CREATE TABLE db_weather.weather (
	id INT UNSIGNED AUTO_INCREMENT NOT NULL,
	`date` DATE NOT NULL,
	temperature INT NOT NULL,
	idRegion INT UNSIGNED,
	IdRainfall INT UNSIGNED,
	CONSTRAINT regionLink 
		FOREIGN KEY (idRegion) 
		REFERENCES db_weather.regions (id) 
		ON UPDATE CASCADE 
		ON DELETE CASCADE,
	CONSTRAINT rainfallLink 
		FOREIGN KEY (IdRainfall) 
		REFERENCES db_weather.rainfall (id) 
		ON UPDATE CASCADE 
		ON DELETE SET NULL,
	PRIMARY KEY (id)
) ENGINE = InnoDB ROW_FORMAT = DEFAULT CHARACTER SET utf8;



-- ----------------------------------------------------------------------------

-- Заполнение таблицы осадков

INSERT INTO db_weather.rainfall (type) VALUES ('Без осадков');
INSERT INTO db_weather.rainfall (type) VALUES ('Туман');
INSERT INTO db_weather.rainfall (type) VALUES ('Дождь');
INSERT INTO db_weather.rainfall (type) VALUES ('Снег');

-- ----------------------------------------------------------------------------

-- Заполнение таблицы языков

INSERT INTO db_weather.language (title) VALUES ('Английский');
INSERT INTO db_weather.language (title) VALUES ('Немецкий');

-- ----------------------------------------------------------------------------

-- Заполнение таблицы населения

INSERT INTO db_weather.population (population, idLanguage) 
VALUES ('Англичане',(SELECT id FROM language WHERE title='Английский'));
INSERT INTO db_weather.population (population, idLanguage) 
VALUES ('Австрийцы',(SELECT id FROM language WHERE title='Немецкий'));
INSERT INTO db_weather.population (population, idLanguage) 
VALUES ('Немцы',(SELECT id FROM language WHERE title='Немецкий'));
INSERT INTO db_weather.population (population, idLanguage) 
VALUES ('Ирландцы',(SELECT id FROM language WHERE title='Английский'));

-- ----------------------------------------------------------------------------

-- Заполнение таблицы регионов

INSERT INTO db_weather.regions (name, area, idPopulation) 
VALUES ('Германия', 357021, (SELECT id FROM population WHERE population='Немцы'));
INSERT INTO db_weather.regions (name, area, idPopulation) 
VALUES ('Ирландия', 70273, (SELECT id FROM population WHERE population='Ирландцы'));
INSERT INTO db_weather.regions (name, area, idPopulation) 
VALUES ('Австрия', 83871, (SELECT id FROM population WHERE population='Австрийцы'));
INSERT INTO db_weather.regions (name, area, idPopulation) 
VALUES ('Великобритания', 243809, (SELECT id FROM population WHERE population='Англичане'));

-- ----------------------------------------------------------------------------

-- Заполнение таблицы погоды


INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-6-29', 27, 
	(SELECT id FROM regions WHERE name='Великобритания'),
	(SELECT id FROM rainfall WHERE type='Без осадков'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-6-24', 16, 
	(SELECT id FROM regions WHERE name='Великобритания'),
	(SELECT id FROM rainfall WHERE type='Дождь'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-6-22', 14, 
	(SELECT id FROM regions WHERE name='Великобритания'),
	(SELECT id FROM rainfall WHERE type='Туман'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-6-18', 24, 
	(SELECT id FROM regions WHERE name='Великобритания'),
	(SELECT id FROM rainfall WHERE type='Без осадков'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-6-16', 18, 
	(SELECT id FROM regions WHERE name='Великобритания'),
	(SELECT id FROM rainfall WHERE type='Без осадков'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-6-12', 22, 
	(SELECT id FROM regions WHERE name='Великобритания'),
	(SELECT id FROM rainfall WHERE type='Без осадков'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-6-8', 20, 
	(SELECT id FROM regions WHERE name='Великобритания'),
	(SELECT id FROM rainfall WHERE type='Туман'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-6-5', 25, 
	(SELECT id FROM regions WHERE name='Великобритания'),
	(SELECT id FROM rainfall WHERE type='Без осадков'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-6-3', 21, 
	(SELECT id FROM regions WHERE name='Великобритания'),
	(SELECT id FROM rainfall WHERE type='Без осадков'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-5-28', 24, 
	(SELECT id FROM regions WHERE name='Великобритания'),
	(SELECT id FROM rainfall WHERE type='Без осадков'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-5-26', 22, 
	(SELECT id FROM regions WHERE name='Великобритания'),
	(SELECT id FROM rainfall WHERE type='Дождь'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-5-1', 16, 
	(SELECT id FROM regions WHERE name='Великобритания'),
	(SELECT id FROM rainfall WHERE type='Дождь'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-3-20', 4, 
	(SELECT id FROM regions WHERE name='Великобритания'),
	(SELECT id FROM rainfall WHERE type='Туман'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-2-01', -1, 
	(SELECT id FROM regions WHERE name='Великобритания'),
	(SELECT id FROM rainfall WHERE type='Снег'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-2-28', 2, 
	(SELECT id FROM regions WHERE name='Великобритания'),
	(SELECT id FROM rainfall WHERE type='Снег'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-1-10', -18, 
	(SELECT id FROM regions WHERE name='Великобритания'),
	(SELECT id FROM rainfall WHERE type='Без осадков'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2014-12-25', -6, 
	(SELECT id FROM regions WHERE name='Великобритания'),
	(SELECT id FROM rainfall WHERE type='Снег'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-6-28', 32, 
	(SELECT id FROM regions WHERE name='Австрия'),
	(SELECT id FROM rainfall WHERE type='Без осадков'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-6-27', 24, 
	(SELECT id FROM regions WHERE name='Австрия'),
	(SELECT id FROM rainfall WHERE type='Без осадков'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-6-23', 30, 
	(SELECT id FROM regions WHERE name='Австрия'),
	(SELECT id FROM rainfall WHERE type='Дождь'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-6-19', 19, 
	(SELECT id FROM regions WHERE name='Австрия'),
	(SELECT id FROM rainfall WHERE type='Без осадков'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-6-15', 18, 
	(SELECT id FROM regions WHERE name='Австрия'),
	(SELECT id FROM rainfall WHERE type='Дождь'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-6-14', 22, 
	(SELECT id FROM regions WHERE name='Австрия'),
	(SELECT id FROM rainfall WHERE type='Без осадков'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-6-10', 21, 
	(SELECT id FROM regions WHERE name='Австрия'),
	(SELECT id FROM rainfall WHERE type='Дождь'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-6-6', 23, 
	(SELECT id FROM regions WHERE name='Австрия'),
	(SELECT id FROM rainfall WHERE type='Без осадков'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-5-29', 27, 
	(SELECT id FROM regions WHERE name='Австрия'),
	(SELECT id FROM rainfall WHERE type='Без осадков'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-5-3', 18, 
	(SELECT id FROM regions WHERE name='Австрия'),
	(SELECT id FROM rainfall WHERE type='Дождь'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-3-19', 10, 
	(SELECT id FROM regions WHERE name='Австрия'),
	(SELECT id FROM rainfall WHERE type='Туман'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-2-2', 0, 
	(SELECT id FROM regions WHERE name='Австрия'),
	(SELECT id FROM rainfall WHERE type='Без осадков'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-2-26', -2, 
	(SELECT id FROM regions WHERE name='Австрия'),
	(SELECT id FROM rainfall WHERE type='Снег'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-1-12', 3, 
	(SELECT id FROM regions WHERE name='Австрия'),
	(SELECT id FROM rainfall WHERE type='Без осадков'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2014-12-27', -16, 
	(SELECT id FROM regions WHERE name='Австрия'),
	(SELECT id FROM rainfall WHERE type='Снег'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-6-25', 27, 
	(SELECT id FROM regions WHERE name='Германия'),
	(SELECT id FROM rainfall WHERE type='Без осадков'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-6-21', 16, 
	(SELECT id FROM regions WHERE name='Германия'),
	(SELECT id FROM rainfall WHERE type='Дождь'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-6-19', 18, 
	(SELECT id FROM regions WHERE name='Германия'),
	(SELECT id FROM rainfall WHERE type='Дождь'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-6-18', 24, 
	(SELECT id FROM regions WHERE name='Германия'),
	(SELECT id FROM rainfall WHERE type='Без осадков'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-6-15', 18, 
	(SELECT id FROM regions WHERE name='Германия'),
	(SELECT id FROM rainfall WHERE type='Без осадков'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-6-10', 22, 
	(SELECT id FROM regions WHERE name='Германия'),
	(SELECT id FROM rainfall WHERE type='Без осадков'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-6-9', 21, 
	(SELECT id FROM regions WHERE name='Германия'),
	(SELECT id FROM rainfall WHERE type='Дождь'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-6-6', 20, 
	(SELECT id FROM regions WHERE name='Германия'),
	(SELECT id FROM rainfall WHERE type='Дождь'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-6-3', 27, 
	(SELECT id FROM regions WHERE name='Германия'),
	(SELECT id FROM rainfall WHERE type='Без осадков'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-5-30', 24, 
	(SELECT id FROM regions WHERE name='Германия'),
	(SELECT id FROM rainfall WHERE type='Без осадков'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-5-27', 25, 
	(SELECT id FROM regions WHERE name='Германия'),
	(SELECT id FROM rainfall WHERE type='Без осадков'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-5-2', 16, 
	(SELECT id FROM regions WHERE name='Германия'),
	(SELECT id FROM rainfall WHERE type='Дождь'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-3-20', 4, 
	(SELECT id FROM regions WHERE name='Германия'),
	(SELECT id FROM rainfall WHERE type='Туман'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-2-3', -1, 
	(SELECT id FROM regions WHERE name='Германия'),
	(SELECT id FROM rainfall WHERE type='Снег'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-2-22', 2, 
	(SELECT id FROM regions WHERE name='Германия'),
	(SELECT id FROM rainfall WHERE type='Снег'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-1-11', -18, 
	(SELECT id FROM regions WHERE name='Германия'),
	(SELECT id FROM rainfall WHERE type='Без осадков'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2014-12-24', -6, 
	(SELECT id FROM regions WHERE name='Германия'),
	(SELECT id FROM rainfall WHERE type='Снег'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-6-24', 33, 
	(SELECT id FROM regions WHERE name='Ирландия'),
	(SELECT id FROM rainfall WHERE type='Без осадков'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-6-22', 24, 
	(SELECT id FROM regions WHERE name='Ирландия'),
	(SELECT id FROM rainfall WHERE type='Дождь'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-6-19', 17, 
	(SELECT id FROM regions WHERE name='Ирландия'),
	(SELECT id FROM rainfall WHERE type='Дождь'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-6-18', 30, 
	(SELECT id FROM regions WHERE name='Ирландия'),
	(SELECT id FROM rainfall WHERE type='Без осадков'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-6-13', 19, 
	(SELECT id FROM regions WHERE name='Ирландия'),
	(SELECT id FROM rainfall WHERE type='Без осадков'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-6-11', 18, 
	(SELECT id FROM regions WHERE name='Ирландия'),
	(SELECT id FROM rainfall WHERE type='Без осадков'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-6-9', 23, 
	(SELECT id FROM regions WHERE name='Ирландия'),
	(SELECT id FROM rainfall WHERE type='Дождь'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-6-6', 22, 
	(SELECT id FROM regions WHERE name='Ирландия'),
	(SELECT id FROM rainfall WHERE type='Дождь'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-6-3', 19, 
	(SELECT id FROM regions WHERE name='Ирландия'),
	(SELECT id FROM rainfall WHERE type='Без осадков'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-5-30', 21, 
	(SELECT id FROM regions WHERE name='Ирландия'),
	(SELECT id FROM rainfall WHERE type='Без осадков'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-5-27', 27, 
	(SELECT id FROM regions WHERE name='Ирландия'),
	(SELECT id FROM rainfall WHERE type='Без осадков'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-5-3', 13, 
	(SELECT id FROM regions WHERE name='Ирландия'),
	(SELECT id FROM rainfall WHERE type='Дождь'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-3-21', 2, 
	(SELECT id FROM regions WHERE name='Ирландия'),
	(SELECT id FROM rainfall WHERE type='Туман'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-2-3', -8, 
	(SELECT id FROM regions WHERE name='Ирландия'),
	(SELECT id FROM rainfall WHERE type='Снег'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-2-22', 0, 
	(SELECT id FROM regions WHERE name='Ирландия'),
	(SELECT id FROM rainfall WHERE type='Снег'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2015-2-22', -14, 
	(SELECT id FROM regions WHERE name='Ирландия'),
	(SELECT id FROM rainfall WHERE type='Без осадков'));

INSERT INTO db_weather.weather (date, temperature, idRegion, IdRainfall) 
VALUES ('2014-12-24', -3, 
	(SELECT id FROM regions WHERE name='Ирландия'),
	(SELECT id FROM rainfall WHERE type='Снег'));
