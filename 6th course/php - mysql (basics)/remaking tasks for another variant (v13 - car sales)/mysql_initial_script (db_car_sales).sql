
DROP DATABASE IF EXISTS db_car_sales;
CREATE DATABASE IF NOT EXISTS db_car_sales CHARACTER SET utf8 COLLATE utf8_general_ci;

USE db_car_sales;

-- -------------- Удаление таблиц, если они существуют -----------------------
-- -------------- Сначала дочерняя, затем родительские. ----------------------

DROP TABLE IF EXISTS db_car_sales.cars;
DROP TABLE IF EXISTS db_car_sales.buyers;
DROP TABLE IF EXISTS db_car_sales.owners;


-- ----------------------- Создание таблиц. ----------------------------------
-- -------------- Сначала родительские, затем дочерняя. ----------------------


-- Create table owners
CREATE TABLE db_car_sales.owners (
   id INT UNSIGNED AUTO_INCREMENT NOT NULL,
   fullName CHAR(255) CHARACTER SET utf8 NOT NULL,
   address CHAR(255) CHARACTER SET utf8,
   phone CHAR(255) CHARACTER SET utf8,
  PRIMARY KEY (id)
) ENGINE = InnoDB ROW_FORMAT = DEFAULT CHARACTER SET utf8;

-- Create table buyers
CREATE TABLE db_car_sales.buyers (
   id INT UNSIGNED AUTO_INCREMENT NOT NULL,
   fullName CHAR(255) CHARACTER SET utf8 NOT NULL,
   address CHAR(255) CHARACTER SET utf8,
   phone CHAR(255) CHARACTER SET utf8,
  PRIMARY KEY (id)
) ENGINE = InnoDB ROW_FORMAT = DEFAULT CHARACTER SET utf8;

-- Create table cars
CREATE TABLE db_car_sales.cars (
   id INT UNSIGNED AUTO_INCREMENT NOT NULL,
   model CHAR(255) CHARACTER SET utf8 NOT NULL,
   color CHAR(255) CHARACTER SET utf8,
   manufactureDate DATE NOT NULL,
   price BIGINT UNSIGNED NOT NULL,
   percentDeduction DOUBLE,
   idOwner INT UNSIGNED NOT NULL,
   idBuyer INT UNSIGNED NOT NULL,
  FOREIGN KEY (idOwner) 
		REFERENCES db_car_sales.owners (id) 
		ON UPDATE CASCADE 
		ON DELETE RESTRICT,
  FOREIGN KEY (idBuyer) 
		REFERENCES db_car_sales.buyers (id) 
		ON UPDATE CASCADE 
		ON DELETE RESTRICT,
  PRIMARY KEY (id)
) ENGINE = InnoDB ROW_FORMAT = DEFAULT CHARACTER SET utf8;


-- ----------------------- Заполнение таблиц. ---------------------------------
-- -------------- Сначала родительские, затем дочерняя. -----------------------


-- Filling table owners

INSERT INTO owners (fullName, address, phone) VALUES 
('Макаров Владислав Петрович', 'Гомель, ул.Ленина, д.18', '+375(29)234-43-32');
  
INSERT INTO owners (fullName, address, phone) VALUES 
('Громова Лариса Борисовна', 'Гомель, ул.Ильича, д.1', '+375(33)789-44-74');
  
INSERT INTO owners (fullName, address, phone) VALUES 
('Гуд Сергей Викторович', 'Гомель, ул.Мира, д.80, кв.13', '+375(29)123-54-12');

INSERT INTO owners (fullName, address, phone) VALUES 
('Шаповаленко Андрей Андреевич', 'Речица, ул.Нефтянников, д.3', '+375(67)768-97-67');

INSERT INTO owners (fullName, address, phone) VALUES 
('Талин Василий Игоревич', 'Речица, ул.Красная, д.8, кв.45', NULL);

INSERT INTO owners (fullName, address, phone) VALUES 
('Тарасов Николай Андреевич', NULL, '+375(33)575-00-78');

INSERT INTO owners (fullName, address, phone) VALUES 
('Рогозов Андрей Васильевич', NULL, NULL);

INSERT INTO owners (fullName, address, phone) VALUES 
('Жадченко Павел Сергеевич', 'Гомель, ул.Белорусская, д.16', '+375(44)780-04-12');

INSERT INTO owners (fullName, address, phone) VALUES 
('Клименок Роман Борисович', 'Гомель, ул.Ленина, д.16', '+375(44)742-45-01');


-- Filling table buyers

INSERT INTO buyers (fullName, address, phone) VALUES 
('Матвеенко Ольга Владимировна', 'Гомель, ул.Павлова, д.14, кв.13', '+375(29)545-54-10');
  
INSERT INTO buyers (fullName, address, phone) VALUES 
('Копатков Игорь Алексеевич', 'Гомель, ул.Ветрова, д.12', '+375(29)784-88-24');
  
INSERT INTO buyers (fullName, address, phone) VALUES 
('Фомичев Евгений Андреевич', 'Гомель, ул.Ленина, д.12, кв.2', NULL);

INSERT INTO buyers (fullName, address, phone) VALUES 
('Юрченко Николай Николаевич', 'Речица, ул.Шаферова, д.6', '+375(44)874-97-67');

INSERT INTO buyers (fullName, address, phone) VALUES 
('Волкова Екатерина Витальевна', 'Гомель, ул.Краснецова, д.70', '+375(33)879-37-19');

INSERT INTO buyers (fullName, address, phone) VALUES 
('Горелик Алена Филиповна', NULL, '+375(29)454-00-78');

INSERT INTO buyers (fullName, address, phone) VALUES 
('Аксёнов Роман Константинович', 'Гомель, ул.Белорусская, д.8', '+375(44)574-15-15');

INSERT INTO buyers (fullName, address, phone) VALUES 
('Малашенко Андрей Михайлович', 'Гомель, ул.Кропоткина, д.1', '+375(44)187-78-01');


-- Filling table cars

INSERT INTO cars (
  model, color, manufactureDate, price, percentDeduction, idOwner, idBuyer)
VALUES (
  'Nissan Pathfinder', 'Зелёный', '2009-01-10', 139050000, 0.5, 
  (SELECT owners.id FROM owners WHERE owners.fullName = 'Громова Лариса Борисовна'),
  (SELECT buyers.id FROM buyers WHERE buyers.fullName = 'Аксёнов Роман Константинович'));

INSERT INTO cars (
  model, color, manufactureDate, price, percentDeduction, idOwner, idBuyer)
VALUES (
  'Audi 100', 'Красный', '1987-06-28', 27810000, 2.3, 
  (SELECT owners.id FROM owners WHERE owners.fullName = 'Макаров Владислав Петрович'),
  (SELECT buyers.id FROM buyers WHERE buyers.fullName = 'Матвеенко Ольга Владимировна'));

INSERT INTO cars (
  model, color, manufactureDate, price, percentDeduction, idOwner, idBuyer)
VALUES (
  'Volkswagen Polo', 'Фиолетовый', '2015-03-02', 152950000, NULL, 
  (SELECT owners.id FROM owners WHERE owners.fullName = 'Гуд Сергей Викторович'),
  (SELECT buyers.id FROM buyers WHERE buyers.fullName = 'Копатков Игорь Алексеевич'));

INSERT INTO cars (
  model, color, manufactureDate, price, percentDeduction, idOwner, idBuyer)
VALUES (
  'Mercedes E W211', NULL, '2003-11-20', 168840000, 1.5, 
  (SELECT owners.id FROM owners WHERE owners.fullName = 'Гуд Сергей Викторович'),
  (SELECT buyers.id FROM buyers WHERE buyers.fullName = 'Фомичев Евгений Андреевич'));

INSERT INTO cars (
  model, color, manufactureDate, price, percentDeduction, idOwner, idBuyer)
VALUES (
  'Mercedes E W210', 'Чёрный', '2000-02-10', 128120000, 1.7, 
  (SELECT owners.id FROM owners WHERE owners.fullName = 'Шаповаленко Андрей Андреевич'),
  (SELECT buyers.id FROM buyers WHERE buyers.fullName = 'Фомичев Евгений Андреевич'));

INSERT INTO cars (
  model, color, manufactureDate, price, percentDeduction, idOwner, idBuyer)
VALUES (
  'Dacia Sandero', 'Красный', '2009-07-01', 108260000, 0.7, 
  (SELECT owners.id FROM owners WHERE owners.fullName = 'Талин Василий Игоревич'),
  (SELECT buyers.id FROM buyers WHERE buyers.fullName = 'Фомичев Евгений Андреевич'));

INSERT INTO cars (
  model, color, manufactureDate, price, percentDeduction, idOwner, idBuyer)
VALUES (
  'Honda Insight', 'Белый', '2009-04-05', 158910000, NULL, 
  (SELECT owners.id FROM owners WHERE owners.fullName = 'Тарасов Николай Андреевич'),
  (SELECT buyers.id FROM buyers WHERE buyers.fullName = 'Юрченко Николай Николаевич'));

INSERT INTO cars (
  model, color, manufactureDate, price, percentDeduction, idOwner, idBuyer)
VALUES (
  'BMW X6', NULL, '2010-11-05', 554210000, 0.4, 
  (SELECT owners.id FROM owners WHERE owners.fullName = 'Тарасов Николай Андреевич'),
  (SELECT buyers.id FROM buyers WHERE buyers.fullName = 'Юрченко Николай Николаевич'));

INSERT INTO cars (
  model, color, manufactureDate, price, percentDeduction, idOwner, idBuyer)
VALUES (
  'BMW M5', NULL, '2006-03-08', 327760000, 1.0, 
  (SELECT owners.id FROM owners WHERE owners.fullName = 'Тарасов Николай Андреевич'),
  (SELECT buyers.id FROM buyers WHERE buyers.fullName = 'Волкова Екатерина Витальевна'));

INSERT INTO cars (
  model, color, manufactureDate, price, percentDeduction, idOwner, idBuyer)
VALUES (
  'Kia Sorento', 'Розовый', '2005-05-15', 172220000, 1.1, 
  (SELECT owners.id FROM owners WHERE owners.fullName = 'Рогозов Андрей Васильевич'),
  (SELECT buyers.id FROM buyers WHERE buyers.fullName = 'Горелик Алена Филиповна'));

INSERT INTO cars (
  model, color, manufactureDate, price, percentDeduction, idOwner, idBuyer)
VALUES (
  'Mitsubishi Lancer', 'Бардовый', '2008-11-20', 113220000, 0.3, 
  (SELECT owners.id FROM owners WHERE owners.fullName = 'Жадченко Павел Сергеевич'),
  (SELECT buyers.id FROM buyers WHERE buyers.fullName = 'Горелик Алена Филиповна'));

INSERT INTO cars (
  model, color, manufactureDate, price, percentDeduction, idOwner, idBuyer)
VALUES (
  'Opel Astra - G', 'Фиолетовый', '2000-07-01', 69520000, 1.8, 
  (SELECT owners.id FROM owners WHERE owners.fullName = 'Жадченко Павел Сергеевич'),
  (SELECT buyers.id FROM buyers WHERE buyers.fullName = 'Малашенко Андрей Михайлович'));

INSERT INTO cars (
  model, color, manufactureDate, price, percentDeduction, idOwner, idBuyer)
VALUES (
  'Opel Omega', 'Серый', '2003-02-17', 95350000, 1.2, 
  (SELECT owners.id FROM owners WHERE owners.fullName = 'Жадченко Павел Сергеевич'),
  (SELECT buyers.id FROM buyers WHERE buyers.fullName = 'Волкова Екатерина Витальевна'));

INSERT INTO cars (
  model, color, manufactureDate, price, percentDeduction, idOwner, idBuyer)
VALUES (
  'Opel Vectra', 'Чёрный', '2005-11-28', 103290000, 0.6, 
  (SELECT owners.id FROM owners WHERE owners.fullName = 'Клименок Роман Борисович'),
  (SELECT buyers.id FROM buyers WHERE buyers.fullName = 'Малашенко Андрей Михайлович'));
