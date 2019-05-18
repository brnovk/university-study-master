-- --------------------- Create triggers for task 4 ---------------------------
-- ----------------------------------------------------------------------------

CONNECT TO LABSV3;

-- 1. Создание триггера, который перед удалением вклада, удаляет записи с этим
-- вкладом из таблицы клиентов и этих клиентов из таблицы движений денег.
-- #SET TERMINATOR @@
CREATE TRIGGER TRIGGER_DELETE_DEPOSIT BEFORE DELETE
	ON DEPOSIT
	REFERENCING 
		OLD AS O
		NEW AS N
	FOR EACH ROW
BEGIN 
	DELETE FROM TRANSFER WHERE TRANSFER.CLIENTID = 
		(SELECT CLIENT.ID FROM CLIENT WHERE CLIENT.DEPOSITID  = O.ID);
	DELETE FROM CLIENT WHERE DEPOSITID = O.ID;
END @@
-- #SET TERMINATOR ;

-- 2. Создание триггера, который перед удалением операции, проверяет таблицу
-- движения денег. Если в таблице движения денег есть записи с этой операцией,
-- удаление запрещется с появлением соответствующего сообщения.
-- #SET TERMINATOR @@
CREATE TRIGGER TRIGGER_DELETE_OPERATION BEFORE DELETE
	ON OPERATION
	REFERENCING 
		OLD AS O
		NEW AS N
	FOR EACH ROW
BEGIN
	IF (EXISTS(SELECT * FROM TRANSFER WHERE OPERATIONID = O.ID)) THEN
			BEGIN
				SIGNAL SQLSTATE VALUE '45000' SET MESSAGE_TEXT = 
					'В таблице Движения денег есть ссылки на эту операцию';
			END;
	END IF;
END @@
-- #SET TERMINATOR ;

CONNECT RESET;
