-- ---------- Filling the tables: first the parent, then the child ------------
-- ----------------------------------------------------------------------------

CONNECT TO LABSV4;

-- Filling table product

INSERT INTO PRODUCT (NAME, PRICE, TERM_IMPLEMENTATION) 
VALUES ('Светильник светодиодный 20Вт', 400000, '2022-12-28');

INSERT INTO PRODUCT (NAME, PRICE, TERM_IMPLEMENTATION) 
VALUES ('Светильник светодиодный 30Вт', 965000, '2021-01-10');

INSERT INTO PRODUCT (NAME, PRICE, TERM_IMPLEMENTATION) 
VALUES ('Светильник светодиодный 40Вт', 1350000, '2019-10-24');

INSERT INTO PRODUCT (NAME, PRICE, TERM_IMPLEMENTATION) 
VALUES ('Светильник светодиодный 50Вт', 1699000, '2021-03-13');

INSERT INTO PRODUCT (NAME, PRICE, TERM_IMPLEMENTATION) 
VALUES ('Кабельный лоток НЛ-5', 199000, '2025-04-16');

INSERT INTO PRODUCT (NAME, PRICE, TERM_IMPLEMENTATION) 
VALUES ('Кабельный лоток НЛ-10', 399000, '2025-05-15');

INSERT INTO PRODUCT (NAME, PRICE, TERM_IMPLEMENTATION) 
VALUES ('Кабельный лоток НЛ-20', 460000, '2025-03-03');

INSERT INTO PRODUCT (NAME, PRICE, TERM_IMPLEMENTATION) 
VALUES ('Кабельный лоток НЛ-40', 660000, '2027-04-23');

INSERT INTO PRODUCT (NAME, PRICE, TERM_IMPLEMENTATION) 
VALUES ('Вводно-распределительное устройство ВРУ-14', 2800000, '2018-05-14');

INSERT INTO PRODUCT (NAME, PRICE, TERM_IMPLEMENTATION) 
VALUES ('Вводно-распределительное устройство ВРУ-2', 1550000, '2018-09-19');

INSERT INTO PRODUCT (NAME, PRICE, TERM_IMPLEMENTATION) 
VALUES ('Шкаф распределительный ШР-11', 5200000, '2031-04-20');

INSERT INTO PRODUCT (NAME, PRICE, TERM_IMPLEMENTATION) 
VALUES ('Пост кнопочный управления ПКУ-15', 1050000, '2020-01-20');

INSERT INTO PRODUCT (NAME, PRICE, TERM_IMPLEMENTATION) 
VALUES ('Ящик с понижающим трансформатором ЯТП', 4500000, '2027-11-15');

INSERT INTO PRODUCT (NAME, PRICE, TERM_IMPLEMENTATION) 
VALUES ('Шкаф наружного освещения ШНО-1', 1400000, '2029-08-20');

INSERT INTO PRODUCT (NAME, PRICE, TERM_IMPLEMENTATION) 
VALUES ('Шкаф наружного освещения ШНО-2', 2100000, '2028-02-20');

INSERT INTO PRODUCT (NAME, PRICE, TERM_IMPLEMENTATION) 
VALUES ('Светильник пылевлагозащищённый ПВЗ-4', 800000, '2022-04-07');

INSERT INTO PRODUCT (NAME, PRICE, TERM_IMPLEMENTATION) 
VALUES ('Светильник для высоких потолков пожаробезопасный ВПП-8', 2000000, '2022-04-07');


-- Filling table storage

INSERT INTO STORAGE (DATE_MANUFACTURE, AMOUNT, PRODUCTID)
VALUES ('2014-01-20', 63, (SELECT PRODUCT.ID FROM PRODUCT 
WHERE PRODUCT.NAME = 'Пост кнопочный управления ПКУ-15'));

INSERT INTO STORAGE (DATE_MANUFACTURE, AMOUNT, PRODUCTID)
VALUES ('2013-04-07', 42, (SELECT PRODUCT.ID FROM PRODUCT 
WHERE PRODUCT.NAME = 'Светильник для высоких потолков пожаробезопасный ВПП-8'));

INSERT INTO STORAGE (DATE_MANUFACTURE, AMOUNT, PRODUCTID)
VALUES ('2015-12-20', 80, (SELECT PRODUCT.ID FROM PRODUCT 
WHERE PRODUCT.NAME = 'Шкаф наружного освещения ШНО-2'));

INSERT INTO STORAGE (DATE_MANUFACTURE, AMOUNT, PRODUCTID)
VALUES ('2015-04-07', 140, (SELECT PRODUCT.ID FROM PRODUCT 
WHERE PRODUCT.NAME = 'Светильник пылевлагозащищённый ПВЗ-4'));

INSERT INTO STORAGE (DATE_MANUFACTURE, AMOUNT, PRODUCTID)
VALUES ('2015-11-15', 140, (SELECT PRODUCT.ID FROM PRODUCT 
WHERE PRODUCT.NAME = 'Ящик с понижающим трансформатором ЯТП'));

INSERT INTO STORAGE (DATE_MANUFACTURE, AMOUNT, PRODUCTID)
VALUES ('2011-09-19', 15, (SELECT PRODUCT.ID FROM PRODUCT 
WHERE PRODUCT.NAME = 'Вводно-распределительное устройство ВРУ-2'));

INSERT INTO STORAGE (DATE_MANUFACTURE, AMOUNT, PRODUCTID)
VALUES ('2011-05-14', 25, (SELECT PRODUCT.ID FROM PRODUCT 
WHERE PRODUCT.NAME = 'Вводно-распределительное устройство ВРУ-14'));

INSERT INTO STORAGE (DATE_MANUFACTURE, AMOUNT, PRODUCTID)
VALUES ('2015-05-15', 1300, (SELECT PRODUCT.ID FROM PRODUCT 
WHERE PRODUCT.NAME = 'Кабельный лоток НЛ-10'));

INSERT INTO STORAGE (DATE_MANUFACTURE, AMOUNT, PRODUCTID)
VALUES ('2015-04-23', 26, (SELECT PRODUCT.ID FROM PRODUCT 
WHERE PRODUCT.NAME = 'Кабельный лоток НЛ-40'));

INSERT INTO STORAGE (DATE_MANUFACTURE, AMOUNT, PRODUCTID)
VALUES ('2015-12-28', 75, (SELECT PRODUCT.ID FROM PRODUCT 
WHERE PRODUCT.NAME = 'Светильник светодиодный 20Вт'));

INSERT INTO STORAGE (DATE_MANUFACTURE, AMOUNT, PRODUCTID)
VALUES ('2015-06-28', 5, (SELECT PRODUCT.ID FROM PRODUCT 
WHERE PRODUCT.NAME = 'Светильник светодиодный 20Вт'));

INSERT INTO STORAGE (DATE_MANUFACTURE, AMOUNT, PRODUCTID)
VALUES ('2012-01-10', 32, (SELECT PRODUCT.ID FROM PRODUCT 
WHERE PRODUCT.NAME = 'Светильник светодиодный 30Вт'));

INSERT INTO STORAGE (DATE_MANUFACTURE, AMOUNT, PRODUCTID)
VALUES ('2014-03-13', 25, (SELECT PRODUCT.ID FROM PRODUCT 
WHERE PRODUCT.NAME = 'Светильник светодиодный 50Вт'));

INSERT INTO STORAGE (DATE_MANUFACTURE, AMOUNT, PRODUCTID)
VALUES ('2014-06-13', 13, (SELECT PRODUCT.ID FROM PRODUCT 
WHERE PRODUCT.NAME = 'Светильник светодиодный 50Вт'));


-- Filling table post

INSERT INTO POST (NAME, SALARY)
VALUES ('Руководитель отдела', 12000000);

INSERT INTO POST (NAME, SALARY)
VALUES ('Диспетчер', 7600000);

INSERT INTO POST (NAME, SALARY)
VALUES ('Менеджер по работе с клиентами', 9200000);

INSERT INTO POST (NAME, SALARY)
VALUES ('Менеджер по документообороту', 6500000);

INSERT INTO POST (NAME, SALARY)
VALUES ('Менеджер активных продаж', 7000000);


-- Filling table category

INSERT INTO CATEGORY (NAME)
VALUES ('I квалификационная категория');

INSERT INTO CATEGORY (NAME)
VALUES ('II квалификационная категория');

INSERT INTO CATEGORY (NAME)
VALUES ('Без квалификационной категории');


-- Filling table employee

INSERT INTO EMPLOYEE (FULL_NAME, REPORT_CARD_NUMBER, POSTID, CATEGORYID)
VALUES ('Хайтович Александр Аркадьевич', '55769', 
(SELECT POST.ID FROM POST WHERE POST.NAME = 'Руководитель отдела'), 
(SELECT CATEGORY.ID FROM CATEGORY 
	WHERE CATEGORY.NAME = 'II квалификационная категория'));

INSERT INTO EMPLOYEE (FULL_NAME, REPORT_CARD_NUMBER, POSTID, CATEGORYID)
VALUES ('Владимиров Казимир Петрович', '55735', 
(SELECT POST.ID FROM POST WHERE POST.NAME = 'Менеджер по документообороту'),
(SELECT CATEGORY.ID FROM CATEGORY 
	WHERE CATEGORY.NAME = 'I квалификационная категория'));

INSERT INTO EMPLOYEE (FULL_NAME, REPORT_CARD_NUMBER, POSTID, CATEGORYID)
VALUES ('Сладкова Ульяна Петровна', '55734', 
(SELECT POST.ID FROM POST WHERE POST.NAME = 'Диспетчер'),
(SELECT CATEGORY.ID FROM CATEGORY 
	WHERE CATEGORY.NAME = 'Без квалификационной категории'));

INSERT INTO EMPLOYEE (FULL_NAME, REPORT_CARD_NUMBER, POSTID, CATEGORYID)
VALUES ('Гриб Владимир Викторович', '55714', 
(SELECT POST.ID FROM POST WHERE POST.NAME = 'Менеджер активных продаж'),
(SELECT CATEGORY.ID FROM CATEGORY 
	WHERE CATEGORY.NAME = 'Без квалификационной категории'));

INSERT INTO EMPLOYEE (FULL_NAME, REPORT_CARD_NUMBER, POSTID, CATEGORYID)
VALUES ('Кучерявый Олег Михайлович', '55722', 
(SELECT POST.ID FROM POST WHERE POST.NAME = 'Менеджер по работе с клиентами'),
(SELECT CATEGORY.ID FROM CATEGORY 
	WHERE CATEGORY.NAME = 'I квалификационная категория'));

INSERT INTO EMPLOYEE (FULL_NAME, REPORT_CARD_NUMBER, POSTID, CATEGORYID)
VALUES ('Савицкая Ольга Павловна', '55721', 
(SELECT POST.ID FROM POST WHERE POST.NAME = 'Менеджер по работе с клиентами'),
(SELECT CATEGORY.ID FROM CATEGORY 
	WHERE CATEGORY.NAME = 'II квалификационная категория'));

INSERT INTO EMPLOYEE (FULL_NAME, REPORT_CARD_NUMBER, POSTID, CATEGORYID)
VALUES ('Доска Наталья Константиновна', '55720', 
(SELECT POST.ID FROM POST WHERE POST.NAME = 'Менеджер по работе с клиентами'),
(SELECT CATEGORY.ID FROM CATEGORY 
	WHERE CATEGORY.NAME = 'I квалификационная категория'));


-- Filling table employee

INSERT INTO BUYER (NAME, ADDRESS)
VALUES ('Открытое акционерное общество "Вольт"', 
'212038, г. Могилев, Гомельское шоссе, 38');

INSERT INTO BUYER (NAME, ADDRESS)
VALUES ('Закрытое акционерное общество "Завод полимерных труб"', 
'212008, г. Могилев, 4-ый пер. Мечникова, 17');

INSERT INTO BUYER (NAME, ADDRESS)
VALUES ('Открытое акционерное общество "Моготекс"', 
'212030, г. Могилев, ул. Гришина, 87');

INSERT INTO BUYER (NAME, ADDRESS)
VALUES ('Открытое акционерное общество "Могилевхлебопродукт"', 
'212022, г. Могилев, ул. Космонавтов, 37');

INSERT INTO BUYER (NAME, ADDRESS)
VALUES ('Открытое акционерное общество "Могилеврембыттехника"', 
'212002, г. Могилёв, ул. Гончарная, 2');

INSERT INTO BUYER (NAME, ADDRESS)
VALUES ('Частное унитарное предприятие "Силикатный завод"', 
'213812, Могилевская область, г. Бобруйск, ул. Силикатная, 1');

INSERT INTO BUYER (NAME, ADDRESS)
VALUES (
'Республиканское унитарное производственное предприятие "Исправительная колония № 2 г. Бобруйска"', 
'213800, Могилевская область, г. Бобруйск, ул. Сикорского, 1');

INSERT INTO BUYER (NAME, ADDRESS)
VALUES ('Производственное частное унитарное предприятие "Универсал Бобруйск"', 
'213826, Могилевская область, г. Бобруйск, ул. Чонгарская, 37');

INSERT INTO BUYER (NAME, ADDRESS)
VALUES ('Открытое акционерное общество "Бобруйскагромаш"', 
'213822, Могилевская область, г. Бобруйск, ул. Шинная, 5');

INSERT INTO BUYER (NAME, ADDRESS)
VALUES ('Открытое акционерное общество "Бобруйский машиностроительный завод"', 
'213805, Могилевская область, г. Бобруйск, ул. Карла Марса, 235');

INSERT INTO BUYER (NAME, ADDRESS)
VALUES ('Совместное закрытое акционерное общество "Осиповичский вагоностроительный завод"', 
'213760, Могилевская область, г. Осиповичи, ул. Кольцевая, 1/1');

INSERT INTO BUYER (NAME, ADDRESS)
VALUES ('Совместное общество с ограниченной ответственностью "Белга-Пром"', 
'213730, Могилевская область, г. Осиповичи, ул. Коммунистическая, 72');


-- Filling table sale

INSERT INTO SALE (SALE_DATE, AMOUNT, EMPLOYEEID, BUYERID, PRODUCTID)
VALUES ('2014-05-15', 7, 
(SELECT EMPLOYEE.ID FROM EMPLOYEE WHERE EMPLOYEE.FULL_NAME = 'Кучерявый Олег Михайлович'), 
(SELECT BUYER.ID FROM BUYER WHERE BUYER.NAME = 'Открытое акционерное общество "Вольт"'), 
(SELECT PRODUCT.ID FROM PRODUCT WHERE PRODUCT.NAME = 'Пост кнопочный управления ПКУ-15'));

INSERT INTO SALE (SALE_DATE, AMOUNT, EMPLOYEEID, BUYERID, PRODUCTID)
VALUES ('2015-09-15', 14, 
(SELECT EMPLOYEE.ID FROM EMPLOYEE WHERE EMPLOYEE.FULL_NAME = 'Савицкая Ольга Павловна'), 
(SELECT BUYER.ID FROM BUYER WHERE BUYER.NAME = 'Открытое акционерное общество "Могилевхлебопродукт"'), 
(SELECT PRODUCT.ID FROM PRODUCT WHERE PRODUCT.NAME = 'Кабельный лоток НЛ-40'));

INSERT INTO SALE (SALE_DATE, AMOUNT, EMPLOYEEID, BUYERID, PRODUCTID)
VALUES ('2014-10-03', 25, 
(SELECT EMPLOYEE.ID FROM EMPLOYEE WHERE EMPLOYEE.FULL_NAME = 'Доска Наталья Константиновна'), 
(SELECT BUYER.ID FROM BUYER 
	WHERE BUYER.NAME = 'Производственное частное унитарное предприятие "Универсал Бобруйск"'), 
(SELECT PRODUCT.ID FROM PRODUCT WHERE PRODUCT.NAME = 'Светильник светодиодный 50Вт'));

INSERT INTO SALE (SALE_DATE, AMOUNT, EMPLOYEEID, BUYERID, PRODUCTID)
VALUES ('2015-08-01', 60, 
(SELECT EMPLOYEE.ID FROM EMPLOYEE WHERE EMPLOYEE.FULL_NAME = 'Доска Наталья Константиновна'), 
(SELECT BUYER.ID FROM BUYER WHERE BUYER.NAME = 'Закрытое акционерное общество "Завод полимерных труб"'), 
(SELECT PRODUCT.ID FROM PRODUCT WHERE PRODUCT.NAME = 'Светильник светодиодный 20Вт'));

INSERT INTO SALE (SALE_DATE, AMOUNT, EMPLOYEEID, BUYERID, PRODUCTID)
VALUES ('2014-09-24', 18, 
(SELECT EMPLOYEE.ID FROM EMPLOYEE WHERE EMPLOYEE.FULL_NAME = 'Доска Наталья Константиновна'), 
(SELECT BUYER.ID FROM BUYER WHERE BUYER.NAME = 'Открытое акционерное общество "Моготекс"'), 
(SELECT PRODUCT.ID FROM PRODUCT WHERE PRODUCT.NAME = 'Светильник светодиодный 30Вт'));

INSERT INTO SALE (SALE_DATE, AMOUNT, EMPLOYEEID, BUYERID, PRODUCTID)
VALUES ('2015-12-25', 10, 
(SELECT EMPLOYEE.ID FROM EMPLOYEE WHERE EMPLOYEE.FULL_NAME = 'Кучерявый Олег Михайлович'), 
(SELECT BUYER.ID FROM BUYER WHERE BUYER.NAME = 'Открытое акционерное общество "Бобруйскагромаш"'), 
(SELECT PRODUCT.ID FROM PRODUCT WHERE PRODUCT.NAME = 'Ящик с понижающим трансформатором ЯТП'));

INSERT INTO SALE (SALE_DATE, AMOUNT, EMPLOYEEID, BUYERID, PRODUCTID)
VALUES ('2015-10-01', 30, 
(SELECT EMPLOYEE.ID FROM EMPLOYEE WHERE EMPLOYEE.FULL_NAME = 'Савицкая Ольга Павловна'), 
(SELECT BUYER.ID FROM BUYER WHERE BUYER.NAME = 
	'Республиканское унитарное производственное предприятие "Исправительная колония № 2 г. Бобруйска"'), 
(SELECT PRODUCT.ID FROM PRODUCT WHERE PRODUCT.NAME = 'Светильник пылевлагозащищённый ПВЗ-4'));

INSERT INTO SALE (SALE_DATE, AMOUNT, EMPLOYEEID, BUYERID, PRODUCTID)
VALUES ('2013-08-27', 15, 
(SELECT EMPLOYEE.ID FROM EMPLOYEE WHERE EMPLOYEE.FULL_NAME = 'Савицкая Ольга Павловна'), 
(SELECT BUYER.ID FROM BUYER WHERE BUYER.NAME = 'Открытое акционерное общество "Могилеврембыттехника"'), 
(SELECT PRODUCT.ID FROM PRODUCT WHERE PRODUCT.NAME = 'Вводно-распределительное устройство ВРУ-2'));

INSERT INTO SALE (SALE_DATE, AMOUNT, EMPLOYEEID, BUYERID, PRODUCTID)
VALUES ('2012-02-02', 5, 
(SELECT EMPLOYEE.ID FROM EMPLOYEE WHERE EMPLOYEE.FULL_NAME = 'Савицкая Ольга Павловна'), 
(SELECT BUYER.ID FROM BUYER WHERE BUYER.NAME = 
	'Совместное закрытое акционерное общество "Осиповичский вагоностроительный завод"'), 
(SELECT PRODUCT.ID FROM PRODUCT WHERE PRODUCT.NAME = 'Вводно-распределительное устройство ВРУ-14'));

INSERT INTO SALE (SALE_DATE, AMOUNT, EMPLOYEEID, BUYERID, PRODUCTID)
VALUES ('2015-12-28', 20, 
(SELECT EMPLOYEE.ID FROM EMPLOYEE WHERE EMPLOYEE.FULL_NAME = 'Савицкая Ольга Павловна'), 
(SELECT BUYER.ID FROM BUYER 
	WHERE BUYER.NAME = 'Совместное общество с ограниченной ответственностью "Белга-Пром"'), 
(SELECT PRODUCT.ID FROM PRODUCT WHERE PRODUCT.NAME = 'Шкаф наружного освещения ШНО-2'));

CONNECT RESET;
