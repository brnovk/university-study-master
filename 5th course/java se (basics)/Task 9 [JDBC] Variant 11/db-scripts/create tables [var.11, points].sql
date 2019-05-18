
-- Создание базы данных db_points, если её не существует
CREATE DATABASE IF NOT EXISTS `db_points` 
CHARACTER SET utf8 COLLATE utf8_general_ci;

-- ----------------------------------------------------------------------------

-- Удаляем таблицу точек, если она существует
DROP TABLE IF EXISTS db_points.points;

-- ----------------------------------------------------------------------------

USE `db_points`;

-- Создание таблицы точек
CREATE TABLE db_points.points (
	id INT UNSIGNED AUTO_INCREMENT NOT NULL,
	x BIGINT NOT NULL,
	y BIGINT NOT NULL,
	PRIMARY KEY (id)
) ENGINE = InnoDB ROW_FORMAT = DEFAULT CHARACTER SET utf8;

-- ----------------------------------------------------------------------------

-- Заполнение таблицы точек

INSERT INTO db_points.points (x, y) VALUES (2, 3);
INSERT INTO db_points.points (x, y) VALUES (6, 5);
INSERT INTO db_points.points (x, y) VALUES (-3, 8);
INSERT INTO db_points.points (x, y) VALUES (1, 0);
INSERT INTO db_points.points (x, y) VALUES (-3, 6);
INSERT INTO db_points.points (x, y) VALUES (3, 7);
INSERT INTO db_points.points (x, y) VALUES (5, -1);
INSERT INTO db_points.points (x, y) VALUES (6, 6);
INSERT INTO db_points.points (x, y) VALUES (5, 6);
INSERT INTO db_points.points (x, y) VALUES (2, -1);
INSERT INTO db_points.points (x, y) VALUES (4, -4);
INSERT INTO db_points.points (x, y) VALUES (1, 3);
INSERT INTO db_points.points (x, y) VALUES (2, 2);
INSERT INTO db_points.points (x, y) VALUES (8, 5);
INSERT INTO db_points.points (x, y) VALUES (8, -1);
INSERT INTO db_points.points (x, y) VALUES (-5, 1);
INSERT INTO db_points.points (x, y) VALUES (3, -1);
INSERT INTO db_points.points (x, y) VALUES (3, 8);
INSERT INTO db_points.points (x, y) VALUES (-2, 3);
INSERT INTO db_points.points (x, y) VALUES (-3, 10);
INSERT INTO db_points.points (x, y) VALUES (9, 9);
INSERT INTO db_points.points (x, y) VALUES (8, 2);
INSERT INTO db_points.points (x, y) VALUES (8, 1);
INSERT INTO db_points.points (x, y) VALUES (5, -5);
INSERT INTO db_points.points (x, y) VALUES (4, 1);
INSERT INTO db_points.points (x, y) VALUES (5, 4);
INSERT INTO db_points.points (x, y) VALUES (5, 3);
INSERT INTO db_points.points (x, y) VALUES (1, 1);
INSERT INTO db_points.points (x, y) VALUES (3, 0);
INSERT INTO db_points.points (x, y) VALUES (4, 2);
INSERT INTO db_points.points (x, y) VALUES (5, 2);
INSERT INTO db_points.points (x, y) VALUES (5, -7);
INSERT INTO db_points.points (x, y) VALUES (-1, -3);
INSERT INTO db_points.points (x, y) VALUES (3, 4);
INSERT INTO db_points.points (x, y) VALUES (-2, 4);
INSERT INTO db_points.points (x, y) VALUES (-7, 7);
INSERT INTO db_points.points (x, y) VALUES (-1, 7);
INSERT INTO db_points.points (x, y) VALUES (0, 3);
INSERT INTO db_points.points (x, y) VALUES (-4, -4);
INSERT INTO db_points.points (x, y) VALUES (4, 4);
INSERT INTO db_points.points (x, y) VALUES (8, -4);
