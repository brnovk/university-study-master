USE stud_db;

-- Тестовые запросы на проверку работы связей в таблицах

-- ------------------------------------------------------------------------------------------------
-- Каскадное удаление (ON DELETE CASCADE) и
-- каскадное обновление (ON UPDATE CASCADE) записей в дочерних таблицах.

/*
SELECT * FROM tab_stud;
SELECT * FROM tab_father_stud;
SELECT * FROM tab_mother_stud;

DELETE FROM tab_stud           
WHERE tab_stud.id_stud=3;                       

UPDATE tab_stud             
SET tab_stud.id_stud=555 
WHERE tab_stud.id_stud=5;	

SELECT * FROM tab_stud;
SELECT * FROM tab_father_stud;
SELECT * FROM tab_mother_stud;
*/

-- ------------------------------------------------------------------------------------------------
-- Обнуление связи на запись в дочерней таблице,
-- при удалении родительской записи (ON DELETE SET NULL).

/*
SELECT * FROM tab_facultet;
SELECT * FROM tab_curator;

DELETE FROM tab_facultet           
WHERE tab_facultet.id_facultet=6;                       

SELECT * FROM tab_facultet;
SELECT * FROM tab_curator;
*/

-- ------------------------------------------------------------------------------------------------

COMMIT WORK;
