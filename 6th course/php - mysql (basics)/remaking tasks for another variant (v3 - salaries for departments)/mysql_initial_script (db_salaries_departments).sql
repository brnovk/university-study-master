
DROP DATABASE IF EXISTS db_salaries_departments;
CREATE DATABASE IF NOT EXISTS db_salaries_departments;

USE db_salaries_departments;

-- -------------- Удаление таблиц, если они существуют -----------------------
-- -------------- Сначала дочерние, затем родительские. ----------------------

DROP TABLE IF EXISTS db_salaries_departments.wages;
DROP TABLE IF EXISTS db_salaries_departments.employees;
DROP TABLE IF EXISTS db_salaries_departments.chairs;


-- ----------------------- Создание таблиц. ----------------------------------
-- -------------- Сначала родительская, затем дочерние. ----------------------

-- Create Table Chairs
CREATE TABLE db_salaries_departments.chairs (
   id INT UNSIGNED AUTO_INCREMENT NOT NULL,
   chairName CHAR(255) CHARACTER SET utf8 NOT NULL,
   chairHead CHAR(255) CHARACTER SET utf8,
   chairPhone CHAR(255) CHARACTER SET utf8,
   UNIQUE (chairName),
  PRIMARY KEY (id)
) ENGINE = InnoDB ROW_FORMAT = DEFAULT CHARACTER SET utf8;

-- Create Table Employees
CREATE TABLE db_salaries_departments.employees (
   id INT UNSIGNED AUTO_INCREMENT NOT NULL,
   employeeLastName CHAR(255) CHARACTER SET utf8 NOT NULL,
   post CHAR(255) CHARACTER SET utf8,
   homeAddress CHAR(255) CHARACTER SET utf8,
   phone CHAR(255) CHARACTER SET utf8,
   chairId INT UNSIGNED NOT NULL,
  FOREIGN KEY (chairId) 
	REFERENCES db_salaries_departments.chairs (id) 
	ON UPDATE CASCADE 
	ON DELETE RESTRICT,
  PRIMARY KEY (id)
) ENGINE = InnoDB ROW_FORMAT = DEFAULT CHARACTER SET utf8;

-- Create Table Wages
CREATE TABLE db_salaries_departments.wages (
   id INT UNSIGNED AUTO_INCREMENT NOT NULL,
   salary INT NOT NULL,
   credited INT,
   withheld INT,
   employeeId INT UNSIGNED NOT NULL,
   UNIQUE (employeeId),
  FOREIGN KEY (employeeId) 
	REFERENCES db_salaries_departments.employees (id) 
	ON UPDATE CASCADE 
	ON DELETE RESTRICT,
  PRIMARY KEY (id)
) ENGINE = InnoDB ROW_FORMAT = DEFAULT CHARACTER SET utf8;


-- ----------------------- Заполнение таблиц. ---------------------------------
-- -------------- Сначала родительская, затем дочерние. -----------------------

-- Filling Table Chairs

INSERT INTO chairs (chairName, chairHead, chairPhone)
VALUES ('Вычислительной математики и программирования',
  'Кузьменков Дмитрий Сергеевич', NULL);
  
INSERT INTO chairs (chairName, chairHead, chairPhone)
VALUES ('Математических проблем управления',
  'Смородин Виктор Сергеевич', NULL);

INSERT INTO chairs (chairName, chairHead, chairPhone)
VALUES ('Дифференциальных уравнений и теории функций',
  'Старовойтов Александр Павлович', NULL);

INSERT INTO chairs (chairName, chairHead, chairPhone)
VALUES ('Алгебры и геометрии',
  'Селькин Вадим Михайлович', NULL);

INSERT INTO chairs (chairName, chairHead, chairPhone)
VALUES ('Экономической кибернетики и теории вероятностей',
  'Малинковский Юрий Владимирович', NULL);

INSERT INTO chairs (chairName, chairHead, chairPhone)
VALUES ('Высшей математики',
  'Семенчук Владимир Николаевич', NULL);

INSERT INTO chairs (chairName, chairHead, chairPhone)
VALUES ('Математического анализа',
  'Миротин Адольф Рувимович', NULL);
  

-- Filling Table Employees

INSERT INTO employees (employeeLastName, post, homeAddress, phone, chairId)
VALUES (
  'Бычков',
  'ассистент', 
  NULL, 
  NULL,
  (SELECT chairs.id FROM chairs WHERE 
    chairs.chairName = 'Вычислительной математики и программирования')
);

INSERT INTO employees (employeeLastName, post, homeAddress, phone, chairId)
VALUES (
  'Жадан',
  'доцент', 
  NULL, 
  NULL,
  (SELECT chairs.id FROM chairs WHERE 
    chairs.chairName = 'Вычислительной математики и программирования')
);

INSERT INTO employees (employeeLastName, post, homeAddress, phone, chairId)
VALUES (
  'Карасева',
  'доцент', 
  NULL, 
  NULL,
  (SELECT chairs.id FROM chairs WHERE 
    chairs.chairName = 'Вычислительной математики и программирования')
);

INSERT INTO employees (employeeLastName, post, homeAddress, phone, chairId)
VALUES (
  'Дудовская',
  'ассистент', 
  NULL, 
  NULL,
  (SELECT chairs.id FROM chairs WHERE 
    chairs.chairName = 'Экономической кибернетики и теории вероятностей')
);

INSERT INTO employees (employeeLastName, post, homeAddress, phone, chairId)
VALUES (
  'Якубович',
  'доцент', 
  NULL, 
  NULL,
  (SELECT chairs.id FROM chairs WHERE 
    chairs.chairName = 'Экономической кибернетики и теории вероятностей')
);

INSERT INTO employees (employeeLastName, post, homeAddress, phone, chairId)
VALUES (
  'Монахов',
  'профессор', 
  NULL, 
  NULL,
  (SELECT chairs.id FROM chairs WHERE 
    chairs.chairName = 'Алгебры и геометрии')
);

INSERT INTO employees (employeeLastName, post, homeAddress, phone, chairId)
VALUES (
  'Ходалевич',
  'доцент', 
  NULL, 
  NULL,
  (SELECT chairs.id FROM chairs WHERE 
    chairs.chairName = 'Алгебры и геометрии')
);

INSERT INTO employees (employeeLastName, post, homeAddress, phone, chairId)
VALUES (
  'Горский',
  'ассистент', 
  NULL, 
  NULL,
  (SELECT chairs.id FROM chairs WHERE 
    chairs.chairName = 'Математического анализа')
);

INSERT INTO employees (employeeLastName, post, homeAddress, phone, chairId)
VALUES (
  'Кульбакова',
  'ассистент', 
  NULL, 
  NULL,
  (SELECT chairs.id FROM chairs WHERE 
    chairs.chairName = 'Математического анализа')
);

INSERT INTO employees (employeeLastName, post, homeAddress, phone, chairId)
VALUES (
  'Демуськов',
  'доцент', 
  NULL, 
  NULL,
  (SELECT chairs.id FROM chairs WHERE 
    chairs.chairName = 'Математических проблем управления')
);

INSERT INTO employees (employeeLastName, post, homeAddress, phone, chairId)
VALUES (
  'Маслович',
  'доцент', 
  NULL, 
  NULL,
  (SELECT chairs.id FROM chairs WHERE 
    chairs.chairName = 'Математических проблем управления')
);

INSERT INTO employees (employeeLastName, post, homeAddress, phone, chairId)
VALUES (
  'Малдер',
  'профессор', 
  "Садовая, д.18", 
  "555-555",
  (SELECT chairs.id FROM chairs WHERE 
    chairs.chairName = 'Математического анализа')
);

INSERT INTO employees (employeeLastName, post, homeAddress, phone, chairId)
VALUES (
  'Скалли',
  'доцент', 
  "Садовая, д.17", 
  "666-666",
  (SELECT chairs.id FROM chairs WHERE 
    chairs.chairName = 'Математического анализа')
);

-- Filling Table Wages

INSERT INTO wages (salary, credited, withheld, employeeId)
VALUES (6000000, 8300000, 1150000, 
  (SELECT employees.id 
  FROM employees 
  WHERE employees.employeeLastName = 'Бычков'));
  
INSERT INTO wages (salary, credited, withheld, employeeId)
VALUES (7500000, 10100000, 1500000, 
  (SELECT employees.id 
  FROM employees 
  WHERE employees.employeeLastName = 'Жадан'));
    
INSERT INTO wages (salary, credited, withheld, employeeId)
VALUES (7500000, 10100000, 1500000, 
  (SELECT employees.id 
  FROM employees 
  WHERE employees.employeeLastName = 'Карасева'));
      
INSERT INTO wages (salary, credited, withheld, employeeId)
VALUES (6000000, 8300000, 1150000, 
  (SELECT employees.id 
  FROM employees 
  WHERE employees.employeeLastName = 'Дудовская'));
      
INSERT INTO wages (salary, credited, withheld, employeeId)
VALUES (7500000, 10100000, 1500000, 
  (SELECT employees.id 
  FROM employees 
  WHERE employees.employeeLastName = 'Якубович'));
      
INSERT INTO wages (salary, credited, withheld, employeeId)
VALUES (10000000, 12000000, 1700000, 
  (SELECT employees.id 
  FROM employees 
  WHERE employees.employeeLastName = 'Монахов'));
  
INSERT INTO wages (salary, credited, withheld, employeeId)
VALUES (7500000, 10100000, 1500000, 
  (SELECT employees.id 
  FROM employees 
  WHERE employees.employeeLastName = 'Ходалевич'));
            
INSERT INTO wages (salary, credited, withheld, employeeId)
VALUES (6000000, 8300000, 1150000, 
  (SELECT employees.id 
  FROM employees 
  WHERE employees.employeeLastName = 'Горский'));
      
INSERT INTO wages (salary, credited, withheld, employeeId)
VALUES (6000000, 8300000, 1150000, 
  (SELECT employees.id 
  FROM employees 
  WHERE employees.employeeLastName = 'Кульбакова'));

INSERT INTO wages (salary, credited, withheld, employeeId)
VALUES (7500000, 10100000, 1500000, 
  (SELECT employees.id 
  FROM employees 
  WHERE employees.employeeLastName = 'Демуськов'));
        
INSERT INTO wages (salary, credited, withheld, employeeId)
VALUES (7500000, 10100000, 1500000, 
  (SELECT employees.id 
  FROM employees 
  WHERE employees.employeeLastName = 'Маслович'));
