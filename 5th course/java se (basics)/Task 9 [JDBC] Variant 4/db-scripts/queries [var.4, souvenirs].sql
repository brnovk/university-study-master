/*

Сувениры.

Таблица "сувениры": название, реквизиты производителя, дата выпуска, цена;
Таблица "производители": название, страна.

1. Вывести информацию о сувенирах заданного производителя.
2. Вывести информацию о сувенирах, произведенных в заданной стране.
3. Вывести информацию о производителях, чьи цены на сувениры меньше заданной.
4. Вывести информацию о производителях заданного сувенира, произведенного в заданном году.
5. Удалить заданного производителя и его сувениры.

*/


-- 1 На примере 'OAO "Воспоминания о Риге"'

SELECT souvenirs.id, souvenirs.title, releaseDate, price
FROM souvenirs, manufacturer
WHERE souvenirs.idManufacturer = manufacturer.id
  AND manufacturer.title = 'OAO "Воспоминания о Риге"';

-- 2 На примере страны "Беларусь"
SELECT souvenirs.id, souvenirs.title, souvenirs.releaseDate, 
  souvenirs.price, manufacturer.title, manufacturer.country
FROM souvenirs, manufacturer
WHERE souvenirs.idManufacturer = manufacturer.id
  AND manufacturer.country = 'Беларусь';

-- 3 На примере "45"
SELECT DISTINCT manufacturer.id, manufacturer.title, manufacturer.country, 
  manufacturer.telephone
FROM souvenirs, manufacturer
WHERE souvenirs.idManufacturer = manufacturer.id
  AND souvenirs.price <= 45;

-- 4 На примере 'Матрёшка "Пучеглазый лемур"' произведённого в "2014" году
SELECT DISTINCT manufacturer.id, manufacturer.title, 
manufacturer.country, manufacturer.telephone
FROM souvenirs, manufacturer
WHERE souvenirs.idManufacturer = manufacturer.id
  AND souvenirs.title = 'Матрёшка "Пучеглазый лемур"' 
  AND YEAR(souvenirs.releaseDate) = YEAR(20140101);

-- 5 На примере 'OAO "Сувениры в Москве"'
-- (Сувениры удаляются каскадно, посредствам вторичного ключа)
DELETE FROM manufacturer
WHERE manufacturer.title = 'OAO "Сувениры в Москве"';