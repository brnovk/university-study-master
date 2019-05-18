DROP DATABASE IF EXISTS db_university_employees;
CREATE DATABASE IF NOT EXISTS db_university_employees;

USE db_university_employees;

-- -------------- Удаление таблиц, если они существуют -----------------------
-- -------------- Сначала дочерние, затем родительские. ----------------------

DROP TABLE IF EXISTS db_university_employees.employees;
DROP TABLE IF EXISTS db_university_employees.chairs;
DROP TABLE IF EXISTS db_university_employees.faculties;


-- ----------------------- Создание таблиц. ----------------------------------
-- -------------- Сначала родительская, затем дочерние. ----------------------


-- Create Table Faculties
CREATE TABLE db_university_employees.Faculties (
   id INT UNSIGNED AUTO_INCREMENT NOT NULL,
   facultyName CHAR(50) CHARACTER SET utf8 NOT NULL,
   facultyDean CHAR(50) CHARACTER SET utf8 NOT NULL,
   deanPhone CHAR(30) CHARACTER SET utf8,
   numberChairs INT,
   UNIQUE (facultyName),
  PRIMARY KEY (id)
) ENGINE = InnoDB ROW_FORMAT = DEFAULT CHARACTER SET utf8;

-- Create Table Chairs
CREATE TABLE db_university_employees.Chairs (
   id INT UNSIGNED AUTO_INCREMENT NOT NULL,
   chairName CHAR(70) CHARACTER SET utf8 NOT NULL,
   chairHead CHAR(50) CHARACTER SET utf8,
   chairPhone CHAR(30) CHARACTER SET utf8,
   facultyId INT UNSIGNED NOT NULL,
   UNIQUE (chairName),
  FOREIGN KEY (facultyId) 
  	REFERENCES db_university_employees.faculties (id) 
  	ON UPDATE CASCADE 
  	ON DELETE RESTRICT,
  PRIMARY KEY (id)
) ENGINE = InnoDB ROW_FORMAT = DEFAULT CHARACTER SET utf8;

-- Create Table Employees
CREATE TABLE db_university_employees.employees (
   id INT UNSIGNED AUTO_INCREMENT NOT NULL,
   employeeLastName CHAR(50) CHARACTER SET utf8 NOT NULL,
   homeAddress CHAR(70) CHARACTER SET utf8,
   age INT UNSIGNED,
   phone CHAR(30) CHARACTER SET utf8,
   chairId INT UNSIGNED NOT NULL,
  FOREIGN KEY (chairId) 
  	REFERENCES db_university_employees.chairs (id) 
  	ON UPDATE CASCADE 
  	ON DELETE RESTRICT,
  PRIMARY KEY (id)
) ENGINE = InnoDB ROW_FORMAT = DEFAULT CHARACTER SET utf8;


-- ----------------------- Заполнение таблиц. ---------------------------------
-- -------------- Сначала родительская, затем дочерние. -----------------------


-- Filling Table Faculties

INSERT INTO faculties (facultyName, facultyDean, deanPhone, numberChairs)
VALUES ('Математический', 'Жогаль Сергей Петрович', '+375(232) 60-75-12', '7');
  
INSERT INTO faculties (facultyName, facultyDean, deanPhone, numberChairs)
VALUES ('Физический', 'Коваленко Дмитрий Леонидович', '+375(232) 57-54-65','5');
  
INSERT INTO faculties (facultyName, facultyDean, deanPhone, numberChairs)
VALUES ('Биологический', 'Аверин Виктор Сергеевич', '+375(232) 56-75-61', '4');




-- Filling Table Chairs

INSERT INTO chairs (chairName, chairHead, chairPhone, facultyId)
VALUES (
  'Вычислительной математики и программирования',
  'Кузьменков Дмитрий Сергеевич',
  NULL,
  (SELECT id FROM faculties WHERE facultyName = 'Математический')
);

INSERT INTO chairs (chairName, chairHead, chairPhone, facultyId)
VALUES (
  'Математических проблем управления',
  'Смородин Виктор Сергеевич',
  NULL,
  (SELECT id FROM faculties WHERE facultyName = 'Математический')
);

INSERT INTO chairs (chairName, chairHead, chairPhone, facultyId)
VALUES (
  'Дифференциальных уравнений и теории функций',
  'Старовойтов Александр Павлович',
  NULL,
  (SELECT id FROM faculties WHERE facultyName = 'Математический')
);

INSERT INTO chairs (chairName, chairHead, chairPhone, facultyId)
VALUES (
  'Алгебры и геометрии',
  'Селькин Вадим Михайлович',
  NULL,
  (SELECT id FROM faculties WHERE facultyName = 'Математический')
);

INSERT INTO chairs (chairName, chairHead, chairPhone, facultyId)
VALUES (
  'Экономической кибернетики и теории вероятностей',
  'Малинковский Юрий Владимирович',
  NULL,
  (SELECT id FROM faculties WHERE facultyName = 'Математический')
);

INSERT INTO chairs (chairName, chairHead, chairPhone, facultyId)
VALUES (
  'Высшей математики',
  'Семенчук Владимир Николаевич',
  NULL,
  (SELECT id FROM faculties WHERE facultyName = 'Математический')
);

INSERT INTO chairs (chairName, chairHead, chairPhone, facultyId)
VALUES (
  'Математического анализа',
  'Миротин Адольф Рувимович',
  NULL,
  (SELECT id FROM faculties WHERE facultyName = 'Математический')
);

INSERT INTO chairs (chairName, chairHead, chairPhone, facultyId)
VALUES (
  'Оптики',
  'Алешкевич Николай Александрович',
  '+375(232) 57-79-97',
  (SELECT id FROM faculties WHERE facultyName = 'Физический')
);

INSERT INTO chairs (chairName, chairHead, chairPhone, facultyId)
VALUES (
  'Теоретической физики',
  'Андреев Виктор Васильевич',
  NULL,
  (SELECT id FROM faculties WHERE facultyName = 'Физический')
);

INSERT INTO chairs (chairName, chairHead, chairPhone, facultyId)
VALUES (
  'Общей физики',
  'Шершнев Евгений Борисович',
  NULL,
  (SELECT id FROM faculties WHERE facultyName = 'Физический')
);

INSERT INTO chairs (chairName, chairHead, chairPhone, facultyId)
VALUES (
  'Радиофизики и электроники',
  'Мышковец Виктор Николаевич',
  NULL,
  (SELECT id FROM faculties WHERE facultyName = 'Физический')
);

INSERT INTO chairs (chairName, chairHead, chairPhone, facultyId)
VALUES (
  'Автоматизированных систем обработки информации',
  'Левчук Виктор Дмитриевич',
  NULL,
  (SELECT id FROM faculties WHERE facultyName = 'Физический')
);

INSERT INTO chairs (chairName, chairHead, chairPhone, facultyId)
VALUES (
  'Ботаники и физиологии растений',
  'Дайнеко Николай Михайлович',
  '+375(232) 57-89-05',
  (SELECT id FROM faculties WHERE facultyName = 'Биологический')
);

INSERT INTO chairs (chairName, chairHead, chairPhone, facultyId)
VALUES (
  'Зоологии, физиологии и генетики',
  NULL,
  NULL,
  (SELECT id FROM faculties WHERE facultyName = 'Биологический')
);

INSERT INTO chairs (chairName, chairHead, chairPhone, facultyId)
VALUES (
  'Химии',
  'Дроздова Наталья Ивановна',
  '+375(232) 60-14-03',
  (SELECT id FROM faculties WHERE facultyName = 'Биологический')
);

INSERT INTO chairs (chairName, chairHead, chairPhone, facultyId)
VALUES (
  'Лесохозяйственных дисциплин',
  'Лазарева Марина Сергеевна',
  NULL,
  (SELECT id FROM faculties WHERE facultyName = 'Биологический')
);




-- Filling Table Employees

INSERT INTO employees (
  employeeLastName, homeAddress, age, phone, chairId)
VALUES (
  'Бычков',
  NULL,
  33,
  NULL,
  (SELECT id FROM chairs WHERE 
  chairs.chairName = 'Вычислительной математики и программирования')
);

INSERT INTO employees (
  employeeLastName, homeAddress, age, phone, chairId)
VALUES (
  'Жадан',
  NULL,
  65,
  NULL,
  (SELECT id FROM chairs WHERE 
  chairs.chairName = 'Вычислительной математики и программирования')
);

INSERT INTO employees (
  employeeLastName, homeAddress, age, phone, chairId)
VALUES (
  'Карасева',
  NULL,
  57,
  NULL,
  (SELECT id FROM chairs WHERE 
  chairs.chairName = 'Вычислительной математики и программирования')
);

INSERT INTO employees (
  employeeLastName, homeAddress, age, phone, chairId)
VALUES (
  'Дудовская',
  NULL,
  NULL,
  NULL,
  (SELECT id FROM chairs WHERE 
  chairs.chairName = 'Экономической кибернетики и теории вероятностей')
);

INSERT INTO employees (
  employeeLastName, homeAddress, age, phone, chairId)
VALUES (
  'Якубович',
  NULL,
  42,
  NULL,
  (SELECT id FROM chairs WHERE 
  chairs.chairName = 'Экономической кибернетики и теории вероятностей')
);

INSERT INTO employees (
  employeeLastName, homeAddress, age, phone, chairId)
VALUES (
  'Монахов',
  NULL,
  69,
  NULL,
  (SELECT id FROM chairs WHERE 
  chairs.chairName = 'Алгебры и геометрии')
);

INSERT INTO employees (
  employeeLastName, homeAddress, age, phone, chairId)
VALUES (
  'Ходалевич',
  NULL,
  59,
  NULL,
  (SELECT id FROM chairs WHERE 
  chairs.chairName = 'Алгебры и геометрии')
);

INSERT INTO employees (
  employeeLastName, homeAddress, age, phone, chairId)
VALUES (
  'Горский',
  NULL,
  NULL,
  NULL,
  (SELECT id FROM chairs WHERE 
  chairs.chairName = 'Математического анализа')
);

INSERT INTO employees (
  employeeLastName, homeAddress, age, phone, chairId)
VALUES (
  'Кульбакова',
  NULL,
  44,
  NULL,
  (SELECT id FROM chairs WHERE 
  chairs.chairName = 'Математического анализа')
);

INSERT INTO employees (
  employeeLastName, homeAddress, age, phone, chairId)
VALUES (
  'Демуськов',
  NULL,
  62,
  NULL,
  (SELECT id FROM chairs WHERE 
  chairs.chairName = 'Математических проблем управления')
);

INSERT INTO employees (
  employeeLastName, homeAddress, age, phone, chairId)
VALUES (
  'Маслович',
  NULL,
  35,
  NULL,
  (SELECT id FROM chairs WHERE 
  chairs.chairName = 'Математических проблем управления')
);

INSERT INTO employees (
  employeeLastName, homeAddress, age, phone, chairId)
VALUES (
  'Щеголихина',
  NULL,
  NULL,
  NULL,
  (SELECT id FROM chairs WHERE 
  chairs.chairName = 'Лесохозяйственных дисциплин')
);

INSERT INTO employees (
  employeeLastName, homeAddress, age, phone, chairId)
VALUES (
  'Воробьева',
  NULL,
  NULL,
  NULL,
  (SELECT id FROM chairs WHERE 
  chairs.chairName = 'Химии')
);

INSERT INTO employees (
  employeeLastName, homeAddress, age, phone, chairId)
VALUES (
  'Хаданович',
  NULL,
  NULL,
  NULL,
  (SELECT id FROM chairs WHERE 
  chairs.chairName = 'Химии')
);

INSERT INTO employees (
  employeeLastName, homeAddress, age, phone, chairId)
VALUES (
  'Беляева',
  NULL,
  NULL,
  NULL,
  (SELECT id FROM chairs WHERE 
  chairs.chairName = 'Химии')
);

INSERT INTO employees (
  employeeLastName, homeAddress, age, phone, chairId)
VALUES (
  'Пугачева',
  NULL,
  NULL,
  NULL,
  (SELECT id FROM chairs WHERE 
  chairs.chairName = 'Автоматизированных систем обработки информации')
);

INSERT INTO employees (
  employeeLastName, homeAddress, age, phone, chairId)
VALUES (
  'Дробышевская',
  NULL,
  NULL,
  NULL,
  (SELECT id FROM chairs WHERE 
  chairs.chairName = 'Общей физики')
);

INSERT INTO employees (
  employeeLastName, homeAddress, age, phone, chairId)
VALUES (
  'Орлова',
  NULL,
  NULL,
  NULL,
  (SELECT id FROM chairs WHERE 
  chairs.chairName = 'Общей физики')
);

INSERT INTO employees (
  employeeLastName, homeAddress, age, phone, chairId)
VALUES (
  'Новикова',
  NULL,
  NULL,
  NULL,
  (SELECT id FROM chairs WHERE 
  chairs.chairName = 'Теоретической физики')
);

INSERT INTO employees (
  employeeLastName, homeAddress, age, phone, chairId)
VALUES (
  'Лукашевич',
  NULL,
  NULL,
  NULL,
  (SELECT id FROM chairs WHERE 
  chairs.chairName = 'Теоретической физики')
);
