-- -------------------------- Demonstration task 4 ----------------------------
-- ----------------------------------------------------------------------------

CONNECT TO LABSV4;

-- 1. Тестирование триггера, который перед удалением изделия, удаляет записи
-- с этим изделием из таблиц склада и продажи.

-- Выборка продажи и склада с изделием с ID = 12
SELECT SALE.SALE_DATE, SALE.PRODUCTID AS SALE_PRODUCT_ID, 
STORAGE.DATE_MANUFACTURE, STORAGE.PRODUCTID AS STORAGE_PRODUCT_ID
FROM SALE JOIN STORAGE ON SALE.PRODUCTID = STORAGE.PRODUCTID
WHERE SALE.PRODUCTID = 12;

-- Удаление изделия с ID = 12
DELETE FROM PRODUCT WHERE PRODUCT.ID = 12;

-- Выборка продажи и склада с изделием с ID = 12
SELECT SALE.SALE_DATE, SALE.PRODUCTID AS SALE_PRODUCT_ID, 
STORAGE.DATE_MANUFACTURE, STORAGE.PRODUCTID AS STORAGE_PRODUCT_ID
FROM SALE JOIN STORAGE ON SALE.PRODUCTID = STORAGE.PRODUCTID
WHERE SALE.PRODUCTID = 12;

-- 2. Тестирование триггера, который перед удалением покупателя, проверяет таблицу
-- продаж. Если в таблице продаж есть записи с этим покупателем, удаление 
-- запрещется с появлением соответствующего сообщения.

-- Попытка удаление продавца с ID = 11
DELETE FROM BUYER WHERE BUYER.ID = 11;

-- Удаления покупок продавца с ID = 11;
DELETE FROM SALE WHERE SALE.BUYERID = 11;

-- Удаление продавца с ID = 11
DELETE FROM BUYER WHERE BUYER.ID = 11;

CONNECT RESET;
