USE stud_db;

-- Тестовые запросы на выборку данных

-- ------------------------------------------------------------------------------------------------

-- Выборка студентов из списка студентов, которые учатся на "Математическом" факультете
SELECT tab_stud.id_stud,tab_stud.surname_stud 
FROM tab_stud,tab_group,tab_facultet 
WHERE (tab_stud.id_group=tab_group.id_group 
	AND tab_group.id_facultet=tab_facultet.id_facultet 
	AND tab_facultet.facultet='Математический');

-- ------------------------------------------------------------------------------------------------

-- Выборка студентов из списка студентов, в названии группы которых присутствует буква "ф"
SELECT tab_stud.id_stud,tab_stud.surname_stud,tab_group.name_group,tab_facultet.facultet 
FROM tab_stud,tab_group,tab_facultet 
WHERE (tab_stud.id_group=tab_group.id_group 
	AND tab_group.name_group LIKE 'ф%')
	AND (tab_facultet.id_facultet=tab_group.id_facultet);

-- ------------------------------------------------------------------------------------------------

-- Выборка студентов из списка студентов, возраст отца больше возраста матери
SELECT tab_stud.id_stud,tab_stud.surname_stud,tab_father_stud.age_father_stud,
	tab_mother_stud.age_mother_stud 
FROM tab_stud,tab_father_stud,tab_mother_stud
WHERE (((tab_stud.id_stud=tab_father_stud.id_stud)
	AND (tab_stud.id_stud=tab_mother_stud.id_stud))
	AND(tab_father_stud.age_father_stud>tab_mother_stud.age_mother_stud))
ORDER BY tab_stud.surname_stud;

-- ------------------------------------------------------------------------------------------------

COMMIT WORK;
