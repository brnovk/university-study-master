USE stud_db;

-- Уcтановка связей между записями по условиям

-- ------------------------------------------------------------------------------------------------
UPDATE tab_mother_stud,tab_stud
SET tab_mother_stud.id_stud=tab_stud.id_stud 
WHERE ((tab_mother_stud.surname_mother_stud='Пупкина')    AND (tab_stud.surname_stud='Пупкин'))
  OR ((tab_mother_stud.surname_mother_stud='Мартыненко') AND (tab_stud.surname_stud='Мартыненко'))
  OR ((tab_mother_stud.surname_mother_stud='Левшунова')  AND (tab_stud.surname_stud='Левшунов'))
  OR ((tab_mother_stud.surname_mother_stud='Ковшарова')  AND (tab_stud.surname_stud='Ковшарова'))
  OR ((tab_mother_stud.surname_mother_stud='Антоненко')  AND (tab_stud.surname_stud='Антоненко'))
  OR ((tab_mother_stud.surname_mother_stud='Ковалёва')   AND (tab_stud.surname_stud='Ковалёв'))
  OR ((tab_mother_stud.surname_mother_stud='ПУшкина')    AND (tab_stud.surname_stud='ПУшкина'))
  OR ((tab_mother_stud.surname_mother_stud='Огневая')    AND (tab_stud.surname_stud='Огневой'))
  OR ((tab_mother_stud.surname_mother_stud='Левшукова')  AND (tab_stud.surname_stud='Левшуков'))
  OR ((tab_mother_stud.surname_mother_stud='Короткая')   AND (tab_stud.surname_stud='Короткий'));
-- ------------------------------------------------------------------------------------------------
UPDATE tab_father_stud,tab_stud 
SET tab_father_stud.id_stud=tab_stud.id_stud 
WHERE ((tab_father_stud.surname_father_stud='Пупкин')     AND (tab_stud.surname_stud='Пупкин'))
  OR ((tab_father_stud.surname_father_stud='Мартыненко') AND (tab_stud.surname_stud='Мартыненко'))
  OR ((tab_father_stud.surname_father_stud='Левшунов')   AND (tab_stud.surname_stud='Левшунов'))
  OR ((tab_father_stud.surname_father_stud='Ковшаров')   AND (tab_stud.surname_stud='Ковшарова'))
  OR ((tab_father_stud.surname_father_stud='Антоненко')  AND (tab_stud.surname_stud='Антоненко'))
  OR ((tab_father_stud.surname_father_stud='Ковалёв')    AND (tab_stud.surname_stud='Ковалёв'))
  OR ((tab_father_stud.surname_father_stud='ПУшкин')     AND (tab_stud.surname_stud='ПУшкина'))
  OR ((tab_father_stud.surname_father_stud='Огневой')    AND (tab_stud.surname_stud='Огневой'))
  OR ((tab_father_stud.surname_father_stud='Левшуков')   AND (tab_stud.surname_stud='Левшуков'))
  OR ((tab_father_stud.surname_father_stud='Короткий')   AND (tab_stud.surname_stud='Короткий'));
-- ------------------------------------------------------------------------------------------------
UPDATE tab_community,tab_stud 
SET tab_stud.id_community=tab_community.id_community 
WHERE ((tab_community.adress='Радужная, д.8')     AND (tab_stud.surname_stud='Пупкин'))
  OR ((tab_community.adress='Злинки, д.39')       AND (tab_stud.surname_stud='Левшунов'))
  OR ((tab_community.adress='Крестьянская, д.14') AND (tab_stud.surname_stud='Ковшарова'))
  OR ((tab_community.adress='Радужная, д.8')      AND (tab_stud.surname_stud='Антоненко'))
  OR ((tab_community.adress='Заречная, д.89')     AND (tab_stud.surname_stud='Огневой'))
  OR ((tab_community.adress='Крассная, д.1')      AND (tab_stud.surname_stud='Левшуков'));
-- ------------------------------------------------------------------------------------------------
UPDATE tab_group,tab_stud 
SET tab_stud.id_group=tab_group.id_group 
WHERE (((tab_group.name_group='ПОИТ-11') AND (tab_group.course=1)) AND (tab_stud.surname_stud='Пупкин'))
 OR (((tab_group.name_group='ПОИТ-21') AND (tab_group.course=2)) AND (tab_stud.surname_stud='Мартыненко'))
 OR (((tab_group.name_group='ПОИТ-22') AND (tab_group.course=2)) AND (tab_stud.surname_stud='Левшунов'))
 OR (((tab_group.name_group='Б-42')    AND (tab_group.course=4)) AND (tab_stud.surname_stud='Ковшарова'))
 OR (((tab_group.name_group='АСОИ-52') AND (tab_group.course=5)) AND (tab_stud.surname_stud='Антоненко'))
 OR (((tab_group.name_group='ФК-31')   AND (tab_group.course=3)) AND (tab_stud.surname_stud='Ковалёв'))
 OR (((tab_group.name_group='Б-42')    AND (tab_group.course=4)) AND (tab_stud.surname_stud='ПУшкина'))
 OR (((tab_group.name_group='ЭК-31')   AND (tab_group.course=3)) AND (tab_stud.surname_stud='Огневой'))
 OR (((tab_group.name_group='Ф-12')    AND (tab_group.course=1)) AND (tab_stud.surname_stud='Левшуков'))
 OR (((tab_group.name_group='ФК-22')   AND (tab_group.course=2)) AND (tab_stud.surname_stud='Короткий'));
-- ------------------------------------------------------------------------------------------------
UPDATE tab_group,tab_cost
SET tab_group.id_cost=tab_cost.id_cost
WHERE ((tab_cost.cost=2100000) AND (tab_group.course=1))
  OR ((tab_cost.cost=2200000)  AND (tab_group.course=2))   
  OR ((tab_cost.cost=2300000)  AND (tab_group.course=3))
  OR ((tab_cost.cost=2400000)  AND (tab_group.course=4))
  OR ((tab_cost.cost=2500000)  AND (tab_group.course=5))
  OR ((tab_cost.cost=2600000)  AND (tab_group.course=6));
-- ------------------------------------------------------------------------------------------------
UPDATE tab_facultet,tab_curator
SET tab_curator.id_facultet=tab_facultet.id_facultet
WHERE ((tab_facultet.facultet='Физкультурный')  AND (tab_curator.surname_curator='Попков'))
  OR ((tab_facultet.facultet='Математический')  AND (tab_curator.surname_curator='Кошлачёва'))
  OR ((tab_facultet.facultet='Юридический')     AND (tab_curator.surname_curator='Антоненко'))
  OR ((tab_facultet.facultet='Математический')  AND (tab_curator.surname_curator='Петровец'))
  OR ((tab_facultet.facultet='Психологический') AND (tab_curator.surname_curator='Лев'))
  OR ((tab_facultet.facultet='Физический')      AND (tab_curator.surname_curator='Власенко'))
  OR ((tab_facultet.facultet='Экологический')   AND (tab_curator.surname_curator='Мартыненко'))
  OR ((tab_facultet.facultet='Философский')     AND (tab_curator.surname_curator='Ковалёва'))
  OR ((tab_facultet.facultet='Экономический')   AND (tab_curator.surname_curator='Лопата'))
  OR ((tab_facultet.facultet='Биологический')   AND (tab_curator.surname_curator='Длинный'));
-- ------------------------------------------------------------------------------------------------
UPDATE tab_facultet,tab_group
SET tab_group.id_facultet=tab_facultet.id_facultet
WHERE ((tab_facultet.facultet='Физкультурный')  AND ((tab_group.name_group='ФК-22')
  OR (tab_group.name_group='ФК-31')))
  OR ((tab_facultet.facultet='Математический')  AND ((tab_group.name_group='ПОИТ-11')
  OR (tab_group.name_group='ПОИТ-21') 
  OR (tab_group.name_group='ПОИТ-22')))
  OR ((tab_facultet.facultet='Физический')      AND ((tab_group.name_group='АСОИ-52')
  OR (tab_group.name_group='Ф-12')))
  OR ((tab_facultet.facultet='Экономический')   AND (tab_group.name_group='ЭК-31'))
  OR ((tab_facultet.facultet='Биологический')   AND (tab_group.name_group='Б-42'))
  OR ((tab_facultet.facultet='Психологический') AND (tab_group.name_group='П-12'));
-- ------------------------------------------------------------------------------------------------
UPDATE tab_group,tab_facultet,tab_curator
SET tab_group.id_curator=tab_curator.id_curator 
WHERE (((tab_curator.surname_curator='Кошлачёва') AND (tab_group.name_group='ПОИТ-11'))
  OR ((tab_curator.surname_curator='Кошлачёва')   AND (tab_group.name_group='ПОИТ-22'))
  OR ((tab_curator.surname_curator='Петровец')    AND (tab_group.name_group='ПОИТ-21'))
  OR ((tab_curator.surname_curator='Власенко')    AND (tab_group.name_group='Ф-12'))
  OR ((tab_curator.surname_curator='Власенко')    AND (tab_group.name_group='АСОИ-52'))
  OR ((tab_curator.surname_curator='Попков')      AND (tab_group.name_group='ФК-31'))
  OR ((tab_curator.surname_curator='Попков')      AND (tab_group.name_group='ФК-22'))
  OR ((tab_curator.surname_curator='Лопата')      AND (tab_group.name_group='ЭК-31'))
  OR ((tab_curator.surname_curator='Лев')         AND (tab_group.name_group='П-12'))
  OR ((tab_curator.surname_curator='Длинный')     AND (tab_group.name_group='Б-42')))  
    AND (tab_curator.id_facultet=tab_curator.id_facultet);
-- ------------------------------------------------------------------------------------------------
UPDATE tab_group,tab_stud
SET tab_stud.id_cost=tab_group.id_cost
WHERE (tab_stud.id_group=tab_group.id_group) AND ((tab_stud.surname_stud='Мартыненко')
  OR (tab_stud.surname_stud='Ковшарова')
  OR (tab_stud.surname_stud='Ковалёв')
  OR (tab_stud.surname_stud='ПУшкина')
  OR (tab_stud.surname_stud='Левшуков')
  OR (tab_stud.surname_stud='Короткий'));	
-- ------------------------------------------------------------------------------------------------
COMMIT WORK;
