-- ------------------ Create stored procedures for task 5 ---------------------
-- ----------------------------------------------------------------------------

CONNECT TO LABSV4;

-- 1. Создание хранимой процедуры, которая выводит покупателя по указанному ID
-- #SET TERMINATOR @@
CREATE PROCEDURE GET_BUYERS_BY_ID (IN F_ID INT)
  LANGUAGE SQL
BEGIN
	DECLARE C1 CURSOR WITH RETURN FOR
	SELECT BUYER.ID, BUYER.NAME, BUYER.ADDRESS FROM BUYER 
		WHERE BUYER.ID = F_ID;
  	OPEN C1;
END @@
-- #SET TERMINATOR ;

-- Пример вызова процедуры
CALL GET_BUYERS_BY_ID(1);


-- 2. Создание хранимой процедуры, которая возвращает категорию сотрудника
-- по указанному ФИО
-- #SET TERMINATOR @@
CREATE PROCEDURE GET_CATEGORY_BY_EMPLOYEE (IN F_NAME VARCHAR(255))
  LANGUAGE SQL
BEGIN
	DECLARE C2 CURSOR WITH RETURN FOR
	SELECT CATEGORY.NAME
	FROM CATEGORY
	WHERE CATEGORY.ID =
	(SELECT EMPLOYEE.CATEGORYID FROM EMPLOYEE WHERE EMPLOYEE.FULL_NAME = F_NAME);
	OPEN C2;
END @@
-- #SET TERMINATOR ;

-- Пример вызова процедуры
CALL GET_CATEGORY_BY_EMPLOYEE('Доска Наталья Константиновна');

CONNECT RESET;
