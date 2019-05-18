-- Создание таблиц
CREATE TABLE [Факультеты] (
	[Код] AUTOINCREMENT,
	[Название] TEXT(255),
	CONSTRAINT [PrimaryKey] PRIMARY KEY ([Код])
);

CREATE TABLE [Специальности] (
	[Код] AUTOINCREMENT,
	[Название] TEXT(255),
	CONSTRAINT [PrimaryKey] PRIMARY KEY ([Код])
);

CREATE TABLE [Студенты] (
	[Код] AUTOINCREMENT,
	[ФИО] TEXT(255),
	[Курс] LONG,
	[Код специальности] LONG,
	[Код факультета] LONG,
	CONSTRAINT [PrimaryKey] PRIMARY KEY ([Код]),
	CONSTRAINT [ФакультетыСтуденты] FOREIGN KEY ([Код факультета]) REFERENCES [Факультеты] ([Код]),
	CONSTRAINT [СпециальностиСтуденты] FOREIGN KEY ([Код специальности]) REFERENCES [Специальности] ([Код])
);

CREATE TABLE [Сессия] (
	[Код] AUTOINCREMENT,
	[Код студента] LONG,
	[Предмет 1] TEXT(255),
	[Оценка 1] LONG,
	[Предмет 2] TEXT(255),
	[Оценка 2] LONG,
	[Предмет 3] TEXT(255),
	[Оценка 3] LONG,
	[Предмет 4] TEXT(255),
	[Оценка 4] LONG,
	CONSTRAINT [PrimaryKey] PRIMARY KEY ([Код]),
	CONSTRAINT [СессияСтуденты] FOREIGN KEY ([Код студента]) REFERENCES [Студенты] ([Код])
);