-- --------------------------- queries for task 2 -----------------------------
-- ----------------------------------------------------------------------------

CONNECT TO LABSV4;

-- 1. Выборка сотрудников с категорией 'II квалификационная категория'
-- (Запрос с подзапросом)
SELECT EMPLOYEE.FULL_NAME FROM EMPLOYEE WHERE EMPLOYEE.CATEGORYID = 
(SELECT CATEGORY.ID FROM CATEGORY WHERE CATEGORY.NAME = 
'II квалификационная категория');

-- 2. Выборка изделий на складе, количество которых меньше 50-ти
-- (Запрос с условием для выборки данных)
SELECT STORAGE.ID, PRODUCT.NAME, STORAGE.AMOUNT 
FROM PRODUCT, STORAGE
WHERE STORAGE.PRODUCTID = PRODUCT.ID AND STORAGE.AMOUNT < 50;

-- 3. Выборка покупок со склада с указанием суммы покупок покупателями
-- (Запрос с вычисляемым полем)
SELECT BUYER.NAME, PRODUCT.NAME, SALE.SALE_DATE, 
SALE.AMOUNT * PRODUCT.PRICE AS PURCHASE_AMOUNT
FROM BUYER, SALE, PRODUCT
WHERE SALE.BUYERID = BUYER.ID AND SALE.PRODUCTID = PRODUCT.ID;

-- 4. Выборка количества продаж сотрудником, за исключением указанного
-- (Запрос с вычисляемым полем и группировкой)
SELECT SALE.EMPLOYEEID, COUNT(SALE.EMPLOYEEID) AS NUMBER_SALES 
FROM SALE GROUP BY SALE.EMPLOYEEID HAVING SALE.EMPLOYEEID IN 
(SELECT EMPLOYEE.ID FROM EMPLOYEE 
WHERE EMPLOYEE.FULL_NAME <> 'Доска Наталья Константиновна');

-- 5. Выбор покупателей указанного сотрудника
-- (Запрос с двумя вложенными подзапросами)
SELECT BUYER.NAME FROM BUYER WHERE BUYER.ID IN 
(SELECT SALE.BUYERID FROM SALE WHERE SALE.EMPLOYEEID = 
(SELECT EMPLOYEE.ID FROM EMPLOYEE 
WHERE EMPLOYEE.FULL_NAME = 'Доска Наталья Константиновна'));

-- 6. Выборка указанных должностей и струдников на этих должностях
-- (Запрос с обьединением 2 таблиц и сортировкой по полю)
SELECT POST.NAME, POST.SALARY, EMPLOYEE.FULL_NAME, EMPLOYEE.REPORT_CARD_NUMBER 
FROM POST JOIN EMPLOYEE ON EMPLOYEE.POSTID = POST.ID
WHERE POST.NAME IN ('Диспетчер', 'Менеджер активных продаж', 
  'Менеджер по документообороту', 'Руководитель отдела')
ORDER BY EMPLOYEE.FULL_NAME ASC;

CONNECT RESET;
