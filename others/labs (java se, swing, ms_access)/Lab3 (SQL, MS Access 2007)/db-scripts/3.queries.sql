﻿-- Выборки данных
SELECT [Студенты].[Код], [Студенты].[ФИО], [Студенты].[Курс], 
[Факультеты].[Название] AS [Факультет], [Специальности].[Название] AS [Специальность]
FROM [Специальности], [Студенты], [Факультеты] 
WHERE [Специальности].[Код] = [Студенты].[Код специальности] AND 
[Факультеты].[Код] = [Студенты].[Код факультета] AND 
(([Специальности].[Название])=[Название специальности]);

SELECT [Студенты].[Код], [Студенты].[ФИО], [Студенты].[Курс], 
[Факультеты].[Название] AS [Факультет], [Специальности].[Название] AS [Специальность]
FROM [Специальности], [Студенты], [Факультеты] 
WHERE [Специальности].[Код] = [Студенты].[Код специальности] AND 
[Факультеты].[Код] = [Студенты].[Код факультета] AND 
(([Студенты].[Курс])>=[Укажите минимальный курс для выборки]);
