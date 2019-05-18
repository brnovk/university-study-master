-- --------------------- Create triggers for task 4 ---------------------------
-- ----------------------------------------------------------------------------

CONNECT TO LABSV4;

-- 1. Создание триггера, который перед удалением изделия, удаляет записи с этим
-- изделием из таблиц склада и продажи.
-- #SET TERMINATOR @@
CREATE TRIGGER "VIKTOR BARANOV".TRIGGER_DELETE_PRODUCT BEFORE DELETE
    ON "VIKTOR BARANOV".PRODUCT 
	REFERENCING 
		OLD AS O
		NEW AS N
    FOR EACH ROW
BEGIN
    DELETE FROM SALE WHERE SALE.PRODUCTID = O.ID;
    DELETE FROM STORAGE WHERE STORAGE.PRODUCTID = O.ID;
END @@
-- #SET TERMINATOR ;

-- 2. Создание триггера, который перед удалением покупателя, проверяет таблицу
-- продаж. Если в таблице продаж есть записи с этим покупателем, удаление 
-- запрещется с появлением соответствующего сообщения.
-- #SET TERMINATOR @@
CREATE TRIGGER "VIKTOR BARANOV".TRIGGER_DELETE_BUYER BEFORE DELETE
    ON "VIKTOR BARANOV".BUYER
	REFERENCING 
		OLD AS O
		NEW AS N
    FOR EACH ROW
BEGIN
	IF (EXISTS(SELECT * FROM "VIKTOR BARANOV".SALE 
		WHERE "VIKTOR BARANOV".SALE.BUYERID = O.ID)) THEN
			BEGIN
				SIGNAL SQLSTATE VALUE '45000' SET MESSAGE_TEXT = 
					'В таблице "Продаж" есть ссылки на этого покупателя';
			END;
	END IF;
END @@
-- #SET TERMINATOR ;

CONNECT RESET;
