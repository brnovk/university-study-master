USE stud_db;

-- Заполнение таблиц насколькими начальными значениями

-- ------------------------------------------------------------------------------------------------
-- Заполняем таблицу студентов значениями
INSERT INTO tab_stud
	(surname_stud, name_stud, age_stud)
VALUES
	('Пупкин',     'Василий',    18), ('Ковшарова',  'Елена',      19),
	('Мартыненко', 'Марина',     17), ('Левшунов',   'Александр',  19),
	('Антоненко',  'Константин', 17), ('Ковалёв',    'Матвей',     21),
	('ПУшкина',    'Лариса',     17), ('Огневой',    'Михаил',     22),
	('Левшуков',   'Сергей',     19), ('Короткий',   'Афанасий',   18);

-- ------------------------------------------------------------------------------------------------
-- Заполняем таблицу матерей студентов значениями
INSERT INTO tab_mother_stud
	(surname_mother_stud, name_mother_stud, age_mother_stud)   
VALUES
	('Пупкина',     'Надежда',    48), ('Левшунова',   'Галина',     59),
	('Ковшарова',   'Екатерина',  38), ('Мартыненко',  'Надежда',    42),
	('Антоненко',   'Марина',     52), ('Ковалёва',    'Надежда',    55),
	('ПУшкина',     'Галина',     39), ('Огневая',     'Екатерина',  44),
	('Левшукова',   'Надежда',    44), ('Короткая',    'Марина',     38);
-- ------------------------------------------------------------------------------------------------
-- Заполняем таблицу отцов студентов значениями
INSERT INTO tab_father_stud
	(surname_father_stud, name_father_stud, age_father_stud)   
VALUES
	('Пупкин',      'Александр',  52), ('Левшунов',    'Анатолий',   43),
	('Ковшаров',    'Михаил',     35), ('Мартыненко',  'Афанасий',   58),
	('Антоненко',   'Фёдор',      44), ('Ковалёв',     'Пётр',       51),
	('ПУшкин',      'Григорий',   49), ('Огневой',     'Егор',       62),
	('Левшуков',    'Борис',      58), ('Короткий',    'Марат',      44);
-- ------------------------------------------------------------------------------------------------
-- Заполняем таблицу групп значениями
INSERT INTO tab_group
	(name_group, course)   
VALUES
	('ПОИТ-11',  1), ('ПОИТ-21',  2), ('ПОИТ-22',  2), ('ЭК-31',    3),
	('Б-42',     4), ('П-12',     1), ('ФК-22',    2), ('Ф-12',     1),
	('АСОИ-52',  5), ('ФК-31',    3);
-- ------------------------------------------------------------------------------------------------
-- Заполняем таблицу факультетов значениями
INSERT INTO tab_facultet
	(facultet, surname_dean)   
VALUES
	('Математический',   'Николаев'   ), ('Физкультурный',    'Афанасьев'  ),
	('Физический',       'Юрченко'    ), ('Биологический',    'Процкий'    ),
	('Психологический',  'Подлужский' ), ('Юридический',      'Фёдоров'    ),
	('Экологический',    'Ходаковский'), ('Экономический',    'Павловский' ),
	('Политологический', 'Рязанов'    ), ('Философский',      'Петров'     );
-- ------------------------------------------------------------------------------------------------
-- Заполняем таблицу цен на обучение значениями
INSERT INTO tab_cost
	(cost)   
VALUES
	(2100000), (2200000), (2300000), (2400000), (2500000), (2600000);
-- ------------------------------------------------------------------------------------------------
-- Заполняем таблицу общежитий значениями
INSERT INTO tab_community
	(adress, number_phone)   
VALUES
	('Радужная, д.8',      '78-56-13'), ('Крестьянская, д.14', '21-00-34'),
	('Злинки, д.39',       '54-44-55'), ('Сорвиная, д.44',     '41-45-12'),
	('Крассная, д.1',      '56-54-14'), ('Заречная, д.89',     '78-45-65');
-- ------------------------------------------------------------------------------------------------
-- Заполняем таблицу кураторов значениями
INSERT INTO tab_curator
	(surname_curator, name_curator, number_phone)   
VALUES
	('Попков',     'Виктор',    '75-52-77'), ('Власенко',   'Виктория',  '52-48-21'),
	('Кошлачёва',  'Людмила',   '55-47-44'), ('Мартыненко', 'Екатерина', '27-04-14'),
	('Антоненко',  'Николай',   '46-41-12'), ('Ковалёва',   'Елена',     '18-45-62'),
	('Петровец',   'Ирина',     '78-25-65'), ('Лопата',     'Григорий',  '22-41-22'),
	('Лев',        'Оксана',    '47-47-52'), ('Длинный',    'Николай',   '18-77-88');
-- ------------------------------------------------------------------------------------------------
COMMIT WORK;