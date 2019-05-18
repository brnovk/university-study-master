
-- Создание базы данных db_souvenirs, если её не существует
CREATE DATABASE IF NOT EXISTS `db_souvenirs` 
CHARACTER SET utf8 COLLATE utf8_general_ci;

-- ----------------------------------------------------------------------------

-- Сначала удаляем дочернюю таблицу, затем родительскую (если они существуют)
DROP TABLE IF EXISTS db_souvenirs.souvenirs;   
DROP TABLE IF EXISTS db_souvenirs.manufacturer;

-- ----------------------------------------------------------------------------

USE `db_souvenirs`;

-- Создание таблицы производителей, если её не существует
CREATE TABLE IF NOT EXISTS db_souvenirs.manufacturer (
	id INT UNSIGNED AUTO_INCREMENT NOT NULL,
	title CHAR(50) CHARACTER SET utf8 NOT NULL,
	country CHAR(50) CHARACTER SET utf8 NOT NULL,
	telephone VARCHAR(30) CHARACTER SET utf8 NOT NULL,
	PRIMARY KEY (id)
) ENGINE = InnoDB ROW_FORMAT = DEFAULT CHARACTER SET utf8;


-- Создание таблицы сувениров, если её не существует.
-- Имеется вторичный ключ на таблицу производителей с каскадным поведением.
CREATE TABLE IF NOT EXISTS db_souvenirs.souvenirs (
	id INT UNSIGNED AUTO_INCREMENT NOT NULL,
	title CHAR(50) CHARACTER SET utf8 NOT NULL,
	releaseDate DATE NOT NULL,
	price BIGINT NOT NULL,
	idManufacturer INT UNSIGNED,
	FOREIGN KEY (idManufacturer) 
		REFERENCES db_souvenirs.manufacturer (id) 
		ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY (id)
) ENGINE = InnoDB ROW_FORMAT = DEFAULT CHARACTER SET utf8;

-- ----------------------------------------------------------------------------

	-- Заполнение таблицы производителей

INSERT INTO db_souvenirs.manufacturer (
	title,
	country,
	telephone
) VALUES (
	'OAO "Сувениры в Москве"',
	'Россия',
	'555-98-99'
);

INSERT INTO db_souvenirs.manufacturer (
	title,
	country,
	telephone
) VALUES (
	'OAO "Лучшие сувениры Минска"',
	'Беларусь',
	'666-68-96'
);

INSERT INTO db_souvenirs.manufacturer (
	title,
	country,
	telephone
) VALUES (
	'OAO "Матрёшки в Варшаве"',
	'Польша',
	'888-76-33'
);

INSERT INTO db_souvenirs.manufacturer (
	title,
	country,
	telephone
) VALUES (
	'OAO "Воспоминания о Риге"',
	'Латвия',
	'987-65-43'
);

-- ----------------------------------------------------------------------------

-- Заполнение таблицы сувениров

INSERT INTO db_souvenirs.souvenirs (
	title,
	releaseDate,
	price,
	idManufacturer
) VALUES (
	'Матрёшка деревянная и зелёная',
	'2014-8-16',
	45,
	(SELECT id FROM manufacturer WHERE title='OAO "Матрёшки в Варшаве"')
);

INSERT INTO db_souvenirs.souvenirs (
	title,
	releaseDate,
	price,
	idManufacturer
) VALUES (
	'Матрёшка "Железный человек"',
	'2014-9-13',
	72,
	(SELECT id FROM manufacturer WHERE title='OAO "Матрёшки в Варшаве"')
);

INSERT INTO db_souvenirs.souvenirs (
	title,
	releaseDate,
	price,
	idManufacturer
) VALUES (
	'Матрёшка "Пучеглазый лемур"',
	'2014-12-18',
	66,
	(SELECT id FROM manufacturer WHERE title='OAO "Матрёшки в Варшаве"')
);

INSERT INTO db_souvenirs.souvenirs (
	title,
	releaseDate,
	price,
	idManufacturer
) VALUES (
	'Матрёшка классическая',
	'2015-1-12',
	50,
	(SELECT id FROM manufacturer WHERE title='OAO "Матрёшки в Варшаве"')
);


INSERT INTO db_souvenirs.souvenirs (
	title,
	releaseDate,
	price,
	idManufacturer
) VALUES (
	'Кружка ICE HOKEY World Championchip 2014',
	'2015-2-2',
	15,
	(SELECT id FROM manufacturer WHERE title='OAO "Лучшие сувениры Минска"')
);

INSERT INTO db_souvenirs.souvenirs (
	title,
	releaseDate,
	price,
	idManufacturer
) VALUES (
	'Тарелка ICE HOKEY World Championchip 2014',
	'2014-12-13',
	22,
	(SELECT id FROM manufacturer WHERE title='OAO "Лучшие сувениры Минска"')
);

INSERT INTO db_souvenirs.souvenirs (
	title,
	releaseDate,
	price,
	idManufacturer
) VALUES (
	'Кастрюля ICE HOKEY World Championchip 2014',
	'2014-11-16',
	40,
	(SELECT id FROM manufacturer WHERE title='OAO "Лучшие сувениры Минска"')
);

INSERT INTO db_souvenirs.souvenirs (
	title,
	releaseDate,
	price,
	idManufacturer
) VALUES (
	'Майка ICE HOKEY World Championchip 2014',
	'2014-10-1',
	30,
	(SELECT id FROM manufacturer WHERE title='OAO "Лучшие сувениры Минска"')
);


INSERT INTO db_souvenirs.souvenirs (
	title,
	releaseDate,
	price,
	idManufacturer
) VALUES (
	'Майка зелёная с рисунком кремля',
	'2014-11-3',
	55,
	(SELECT id FROM manufacturer WHERE title='OAO "Сувениры в Москве"')
);

INSERT INTO db_souvenirs.souvenirs (
	title,
	releaseDate,
	price,
	idManufacturer
) VALUES (
	'Майка жёлтая с рисунком кремля',
	'2014-11-4',
	55,
	(SELECT id FROM manufacturer WHERE title='OAO "Сувениры в Москве"')
);

INSERT INTO db_souvenirs.souvenirs (
	title,
	releaseDate,
	price,
	idManufacturer
) VALUES (
	'Майка красная с рисунком кремля',
	'2014-11-5',
	55,
	(SELECT id FROM manufacturer WHERE title='OAO "Сувениры в Москве"')
);

INSERT INTO db_souvenirs.souvenirs (
	title,
	releaseDate,
	price,
	idManufacturer
) VALUES (
	'Матрёшка "Спящий медведь"',
	'2015-2-2',
	98,
	(SELECT id FROM manufacturer WHERE title='OAO "Сувениры в Москве"')
);


INSERT INTO db_souvenirs.souvenirs (
	title,
	releaseDate,
	price,
	idManufacturer
) VALUES (
	'Майка зелёная с Турайдским замком',
	'2015-2-4',
	80,
	(SELECT id FROM manufacturer WHERE title='OAO "Воспоминания о Риге"')
);

INSERT INTO db_souvenirs.souvenirs (
	title,
	releaseDate,
	price,
	idManufacturer
) VALUES (
	'Майка жёлтая с Турайдским замком',
	'2015-2-5',
	80,
	(SELECT id FROM manufacturer WHERE title='OAO "Воспоминания о Риге"')
);

INSERT INTO db_souvenirs.souvenirs (
	title,
	releaseDate,
	price,
	idManufacturer
) VALUES (
	'Майка красная с Турайдским замком',
	'2015-2-6',
	80,
	(SELECT id FROM manufacturer WHERE title='OAO "Воспоминания о Риге"')
);

INSERT INTO db_souvenirs.souvenirs (
	title,
	releaseDate,
	price,
	idManufacturer
) VALUES (
	'Майка красная с Турайдским замком',
	'2014-12-29',
	77,
	(SELECT id FROM manufacturer WHERE title='OAO "Воспоминания о Риге"')
);
