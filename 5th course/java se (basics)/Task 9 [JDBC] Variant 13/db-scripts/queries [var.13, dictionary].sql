/*

Словарь.

Таблица английских слов: слово.
Таблица русских слов:    слово.
Таблица "карты" слов:    ссылка на id английского слова, ссылка на id русского слова.

Вводятся последовательно английские (русские) слова.
Для каждого из них вывести на консоль все русские (английские) значения слова.

*/

-- 1 Выборка английких слов, на примере русского "нарушение"

SELECT eng_worlds.word 
FROM rus_worlds, eng_worlds, map
WHERE rus_worlds.word = "нарушение" AND
  rus_worlds.id = map.id_rus AND
  map.id_eng = eng_worlds.id;

-- 2 Выборка русских слов, на примере английского "pother"

SELECT rus_worlds.word 
FROM rus_worlds, eng_worlds, map
WHERE eng_worlds.word = "pother" AND
  eng_worlds.id = map.id_eng AND
  map.id_rus = rus_worlds.id;
