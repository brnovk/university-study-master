/*

Точки.

Таблица "точки": x, y.

1. Вывести точку из множества, наиболее приближенную к заданной.
2. Вывести точку из множества, наиболее удаленную от заданной.
3. Вывести точки из множества, лежащие на одной прямой с заданной прямой.

*/

# 1 На примере точки '0,0'

select id, x, y, SQRT(POW((0-x),2) + POW((0-y),2)) AS distance
FROM points
GROUP BY id
ORDER BY distance ASC LIMIT 1;

# 2 На примере точки '0,0'

select id, x, y, SQRT(POW((0-x),2) + POW((0-y),2)) AS distance
FROM points
GROUP BY id
ORDER BY distance DESC LIMIT 1;

# 3 На примере прямой (0,1)(2,3)
SELECT points.id,  points.x,  points.y, 1 AS x1, 2 AS y1, 3 AS x2, 4 AS y2
FROM points
HAVING ((abs((y-y1)*(x2-x1)-(x-x1)*(y2-y1)) <= 0.00001) 
	AND (((x-x1)*(x2-x1)-(y-y1)*(y2-y1)) >= 0)
	AND (((x-x1)*(x2-x1)-(y-y1)*(y2-y1)) <= ((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1))));
