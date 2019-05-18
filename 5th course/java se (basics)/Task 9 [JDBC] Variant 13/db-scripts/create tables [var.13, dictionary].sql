
-- Создание базы данных db_dictionary, если её не существует
CREATE DATABASE IF NOT EXISTS `db_dictionary` 
CHARACTER SET utf8 COLLATE utf8_general_ci;

-- ----------------------------------------------------------------------------

-- Сначала удаляем дочерние таблицы, затем родительские (если они существуют)
DROP TABLE IF EXISTS db_dictionary.map;
DROP TABLE IF EXISTS db_dictionary.eng_worlds;
DROP TABLE IF EXISTS db_dictionary.rus_worlds;

-- ----------------------------------------------------------------------------

USE `db_dictionary`;

-- Создание таблицы английских слов
CREATE TABLE db_dictionary.eng_worlds (
	id BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
	word CHAR(50) CHARACTER SET utf8 NOT NULL,
	PRIMARY KEY (id)
) ENGINE = InnoDB ROW_FORMAT = DEFAULT CHARACTER SET utf8;

-- В таблице английских слов делаем поле "word" уникальным.
ALTER TABLE db_dictionary.eng_worlds ADD UNIQUE (word);

-- Создание таблицы русских слов
CREATE TABLE db_dictionary.rus_worlds (
	id BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
	word CHAR(50) CHARACTER SET utf8 NOT NULL,
	PRIMARY KEY (id)
) ENGINE = InnoDB ROW_FORMAT = DEFAULT CHARACTER SET utf8;

-- В таблице русских слов делаем поле "word" уникальным.
ALTER TABLE db_dictionary.rus_worlds ADD UNIQUE (word);

-- Создание таблицы "карты"
CREATE TABLE db_dictionary.map (
	id BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
	id_eng BIGINT UNSIGNED,
	id_rus BIGINT UNSIGNED,
	CONSTRAINT linkWithEng FOREIGN KEY (id_eng) 
		REFERENCES db_dictionary.eng_worlds (id) 
		ON UPDATE CASCADE 
		ON DELETE SET NULL,
	CONSTRAINT linkWithRus FOREIGN KEY (id_rus) 
		REFERENCES db_dictionary.rus_worlds (id) 
		ON UPDATE CASCADE 
		ON DELETE SET NULL,
	PRIMARY KEY (id)
) ENGINE = InnoDB ROW_FORMAT = DEFAULT;

-- ----------------------------------------------------------------------------

-- Заполнение таблицы английских слов

INSERT INTO db_dictionary.eng_worlds (word) VALUES ("porch");
INSERT INTO db_dictionary.eng_worlds (word) VALUES ("poseur");
INSERT INTO db_dictionary.eng_worlds (word) VALUES ("pother");
INSERT INTO db_dictionary.eng_worlds (word) VALUES ("high");
INSERT INTO db_dictionary.eng_worlds (word) VALUES ("elevated");
INSERT INTO db_dictionary.eng_worlds (word) VALUES ("hydrogen");
INSERT INTO db_dictionary.eng_worlds (word) VALUES ("disturbing");
INSERT INTO db_dictionary.eng_worlds (word) VALUES ("exciting");
INSERT INTO db_dictionary.eng_worlds (word) VALUES ("breatch");
INSERT INTO db_dictionary.eng_worlds (word) VALUES ("breaking");
INSERT INTO db_dictionary.eng_worlds (word) VALUES ("infringement");
INSERT INTO db_dictionary.eng_worlds (word) VALUES ("infraction");
INSERT INTO db_dictionary.eng_worlds (word) VALUES ("transgression");
INSERT INTO db_dictionary.eng_worlds (word) VALUES ("violation");

-- ----------------------------------------------------------------------------

-- Заполнение таблицы русских слов

INSERT INTO db_dictionary.rus_worlds (word) VALUES ("подъём");
INSERT INTO db_dictionary.rus_worlds (word) VALUES ("портик");
INSERT INTO db_dictionary.rus_worlds (word) VALUES ("вход");
INSERT INTO db_dictionary.rus_worlds (word) VALUES ("веранда");
INSERT INTO db_dictionary.rus_worlds (word) VALUES ("балкон");
INSERT INTO db_dictionary.rus_worlds (word) VALUES ("позёр");
INSERT INTO db_dictionary.rus_worlds (word) VALUES ("суматоха");
INSERT INTO db_dictionary.rus_worlds (word) VALUES ("шум");
INSERT INTO db_dictionary.rus_worlds (word) VALUES ("возвышенный");
INSERT INTO db_dictionary.rus_worlds (word) VALUES ("водород");
INSERT INTO db_dictionary.rus_worlds (word) VALUES ("волнующий");
INSERT INTO db_dictionary.rus_worlds (word) VALUES ("нарушение");

-- ----------------------------------------------------------------------------

-- Заполнение таблицы "карты"

INSERT INTO db_dictionary.map (id_eng, id_rus) 
VALUES ((SELECT id FROM db_dictionary.eng_worlds WHERE word='porch'),
	(SELECT id FROM db_dictionary.rus_worlds WHERE word='подъём'));

INSERT INTO db_dictionary.map (id_eng, id_rus) 
VALUES ((SELECT id FROM db_dictionary.eng_worlds WHERE word='porch'),
	(SELECT id FROM db_dictionary.rus_worlds WHERE word='портик'));

INSERT INTO db_dictionary.map (id_eng, id_rus) 
VALUES ((SELECT id FROM db_dictionary.eng_worlds WHERE word='porch'),
	(SELECT id FROM db_dictionary.rus_worlds WHERE word='вход'));

INSERT INTO db_dictionary.map (id_eng, id_rus) 
VALUES ((SELECT id FROM db_dictionary.eng_worlds WHERE word='porch'),
	(SELECT id FROM db_dictionary.rus_worlds WHERE word='веранда'));

INSERT INTO db_dictionary.map (id_eng, id_rus) 
VALUES ((SELECT id FROM db_dictionary.eng_worlds WHERE word='porch'),
	(SELECT id FROM db_dictionary.rus_worlds WHERE word='балкон'));

INSERT INTO db_dictionary.map (id_eng, id_rus) 
VALUES ((SELECT id FROM db_dictionary.eng_worlds WHERE word='poseur'),
	(SELECT id FROM db_dictionary.rus_worlds WHERE word='позёр'));

INSERT INTO db_dictionary.map (id_eng, id_rus) 
VALUES ((SELECT id FROM db_dictionary.eng_worlds WHERE word='pother'),
	(SELECT id FROM db_dictionary.rus_worlds WHERE word='суматоха'));

INSERT INTO db_dictionary.map (id_eng, id_rus) 
VALUES ((SELECT id FROM db_dictionary.eng_worlds WHERE word='pother'),
	(SELECT id FROM db_dictionary.rus_worlds WHERE word='шум'));

INSERT INTO db_dictionary.map (id_eng, id_rus) 
VALUES ((SELECT id FROM db_dictionary.eng_worlds WHERE word='high'),
	(SELECT id FROM db_dictionary.rus_worlds WHERE word='возвышенный'));

INSERT INTO db_dictionary.map (id_eng, id_rus) 
VALUES ((SELECT id FROM db_dictionary.eng_worlds WHERE word='elevated'),
	(SELECT id FROM db_dictionary.rus_worlds WHERE word='возвышенный'));

INSERT INTO db_dictionary.map (id_eng, id_rus) 
VALUES ((SELECT id FROM db_dictionary.eng_worlds WHERE word='hydrogen'),
	(SELECT id FROM db_dictionary.rus_worlds WHERE word='водород'));

INSERT INTO db_dictionary.map (id_eng, id_rus) 
VALUES ((SELECT id FROM db_dictionary.eng_worlds WHERE word='disturbing'),
	(SELECT id FROM db_dictionary.rus_worlds WHERE word='волнующий'));

INSERT INTO db_dictionary.map (id_eng, id_rus) 
VALUES ((SELECT id FROM db_dictionary.eng_worlds WHERE word='exciting'),
	(SELECT id FROM db_dictionary.rus_worlds WHERE word='волнующий'));

INSERT INTO db_dictionary.map (id_eng, id_rus) 
VALUES ((SELECT id FROM db_dictionary.eng_worlds WHERE word='breatch'),
	(SELECT id FROM db_dictionary.rus_worlds WHERE word='нарушение'));

INSERT INTO db_dictionary.map (id_eng, id_rus) 
VALUES ((SELECT id FROM db_dictionary.eng_worlds WHERE word='breaking'),
	(SELECT id FROM db_dictionary.rus_worlds WHERE word='нарушение'));

INSERT INTO db_dictionary.map (id_eng, id_rus) 
VALUES ((SELECT id FROM db_dictionary.eng_worlds WHERE word='infringement'),
	(SELECT id FROM db_dictionary.rus_worlds WHERE word='нарушение'));

INSERT INTO db_dictionary.map (id_eng, id_rus) 
VALUES ((SELECT id FROM db_dictionary.eng_worlds WHERE word='infraction'),
	(SELECT id FROM db_dictionary.rus_worlds WHERE word='нарушение'));

INSERT INTO db_dictionary.map (id_eng, id_rus) 
VALUES ((SELECT id FROM db_dictionary.eng_worlds WHERE word='transgression'),
	(SELECT id FROM db_dictionary.rus_worlds WHERE word='нарушение'));

INSERT INTO db_dictionary.map (id_eng, id_rus) 
VALUES ((SELECT id FROM db_dictionary.eng_worlds WHERE word='violation'),
	(SELECT id FROM db_dictionary.rus_worlds WHERE word='нарушение'));
