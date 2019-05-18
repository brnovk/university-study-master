-- -------------------------- Demonstration task 4 ----------------------------
-- ----------------------------------------------------------------------------

CONNECT TO LABSV3;

-- 1. Тестирование триггера, который перед удалением вклада, удаляет записи с этим
-- вкладом из таблицы клиентов и этих клиентов из таблицы движений денег.

-- Выборка вклада, клиентов и движений денег клиентов вклада 'До востребования'
SELECT DEPOSIT.ID, DEPOSIT.NAME AS DEPOSIT, CLIENT.FULL_NAME AS CLIENT, 
TRANSFER.TRANSFER_DATE 
FROM CLIENT, DEPOSIT, TRANSFER
WHERE CLIENT.DEPOSITID = DEPOSIT.ID AND TRANSFER.CLIENTID = CLIENT.ID
AND DEPOSIT.NAME = 'До востребования' ;

-- Удаление вклада 'До востребования'
DELETE FROM DEPOSIT WHERE DEPOSIT.NAME = 'До востребования';

-- Выборка вклада, клиентов и движений денег клиентов вклада 'До востребования'
SELECT DEPOSIT.ID, DEPOSIT.NAME AS DEPOSIT, CLIENT.FULL_NAME AS CLIENT, 
TRANSFER.TRANSFER_DATE 
FROM CLIENT, DEPOSIT, TRANSFER
WHERE CLIENT.DEPOSITID = DEPOSIT.ID AND TRANSFER.CLIENTID = CLIENT.ID
AND DEPOSIT.NAME = 'До востребования' ;

-- 2. Тестирование триггера, который перед удалением операции, проверяет таблицу
-- движения денег. Если в таблице движения денег есть записи с этой операцией,
-- удаление запрещется с появлением соответствующего сообщения.

-- Попытка удаления операции 'Начисление процентов'
DELETE FROM OPERATION WHERE OPERATION.NAME = 'Начисление процентов';

-- Удаление движения денег с операцией 'Начисление процентов';
DELETE FROM TRANSFER WHERE OPERATIONID = (SELECT OPERATION.ID FROM OPERATION 
WHERE OPERATION.NAME = 'Начисление процентов');

-- Удаление операции 'Начисление процентов'
DELETE FROM OPERATION WHERE OPERATION.NAME = 'Начисление процентов';

CONNECT RESET;
