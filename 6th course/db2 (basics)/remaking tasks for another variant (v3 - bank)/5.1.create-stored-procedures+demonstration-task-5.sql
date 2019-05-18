-- ------------------ Create stored procedures for task 5 ---------------------
-- ----------------------------------------------------------------------------

CONNECT TO LABSV3;

-- 1. Создание хранимой процедуры, выводящей клиента по указанному номеру счёта
-- #SET TERMINATOR @@
CREATE PROCEDURE GET_CLIENT_BY_ACCOUNT_NUMBER (IN F_ACC VARCHAR(255))
  LANGUAGE SQL
BEGIN
	DECLARE C1 CURSOR WITH RETURN FOR
	SELECT CLIENT.ID, CLIENT.FULL_NAME, CLIENT.ADDRESS, 
	CLIENT.ACCOUNT_NUMBER, CLIENT.CREATION_DATE, CLIENT.DEPOSITID 
	FROM CLIENT WHERE CLIENT.ACCOUNT_NUMBER = F_ACC;
	OPEN C1;
END @@
-- #SET TERMINATOR ;

-- Пример вызова процедуры
CALL GET_CLIENT_BY_ACCOUNT_NUMBER('AB9657');


-- 2. Создание хранимой процедуры, которая возвращает вклад клиента по 
-- указанному ID клиента
-- #SET TERMINATOR @@
CREATE PROCEDURE GET_DEPOSIT_BY_CLIENT_ID (IN F_ID INT)
  LANGUAGE SQL
BEGIN
	DECLARE C2 CURSOR WITH RETURN FOR
	SELECT DEPOSIT.NAME FROM DEPOSIT, CLIENT
	WHERE CLIENT.DEPOSITID = DEPOSIT.ID AND CLIENT.ID = F_ID;
	OPEN C2;
END @@
-- #SET TERMINATOR ;

-- Пример вызова процедуры
CALL GET_DEPOSIT_BY_CLIENT_ID(1);

CONNECT RESET;
