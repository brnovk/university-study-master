-- --------------------------- queries for task 2 -----------------------------
-- ----------------------------------------------------------------------------

CONNECT TO LABSV3;

-- 1. Выборка сотрудников с должностью 'Опперационист'
-- (Запрос с подзапросом)
SELECT FULL_NAME AS EMPLOYEE FROM EMPLOYEE WHERE EMPLOYEE.POSTID = 
(SELECT POST.ID FROM POST WHERE POST.NAME = 'Опперационист');

-- 2. Выборка сотрудников, оклад которых больше 12 миллионов
-- (Запрос с условием для выборки данных)
SELECT EMPLOYEE.FULL_NAME AS EMPLOYEE, POST.NAME AS POST, POST.SALARY 
FROM EMPLOYEE, POST WHERE EMPLOYEE.POSTID = POST.ID AND POST.SALARY > 12000000;

-- 3. Выборка количества вкладов в белорусских рублях
-- (Запрос с вычисляемым полем)
SELECT COUNT(CURRENCY) AS BYR_DEPOSIT FROM DEPOSIT WHERE CURRENCY = 'BYR';

-- 4. Выборка количества движений денег сотрудниками, за исключением указанного
-- (Запрос с вычисляемым полем и группировкой)
SELECT TRANSFER.EMPLOYEEID, COUNT(TRANSFER.EMPLOYEEID) AS NUMBER_TRANSFER 
FROM TRANSFER GROUP BY TRANSFER.EMPLOYEEID HAVING TRANSFER.EMPLOYEEID IN
(SELECT EMPLOYEE.ID FROM EMPLOYEE
WHERE EMPLOYEE.FULL_NAME <> 'Сидоренко Сергей Евгеньевич');

-- 5. Выбор клиентов указанного сотрудника
-- (Запрос с двумя вложенными подзапросами)
SELECT CLIENT.FULL_NAME FROM CLIENT WHERE CLIENT.ID IN 
(SELECT TRANSFER.CLIENTID FROM TRANSFER WHERE TRANSFER.EMPLOYEEID =
(SELECT EMPLOYEE.ID FROM EMPLOYEE 
WHERE EMPLOYEE.FULL_NAME = 'Сидоренко Сергей Евгеньевич'));

-- 6. Выборка указанных должностей и струдников на этих должностях
-- (Запрос с обьединением 2 таблиц и сортировкой по полю)
SELECT EMPLOYEE.FULL_NAME AS EMPLOYEE, POST.NAME AS POST, POST.SALARY, 
EMPLOYEE.REPORT_CARD_NUMBER
FROM post JOIN employee ON employee.POSTID = post.ID
WHERE post.NAME IN ('Управляющий', 'Начальник отдела', 'Опперационист')
ORDER BY employee.FULL_NAME ASC;

CONNECT RESET;
