
-- ----------------------------------------------------------------------------

USE bugtracker;

-- ------------ User initialization (with administrative privileges) ----------

INSERT INTO users (EMAILADDRESS, FIRSTNAME, LASTNAME, PASSWORD, USERROLE)
	VALUES ('gordon.frimen.bm@mail.ru', 'Гордон', 'Фримен', 'gordon.frimen.bm', 'ADMINISTRATOR');
INSERT INTO users (EMAILADDRESS, FIRSTNAME, LASTNAME, PASSWORD, USERROLE)
	VALUES ('alyx.vance.sity17@mail.ru', 'Аликс', 'Вэнс', 'alyx.vance.sity17', 'ADMINISTRATOR');
INSERT INTO users (EMAILADDRESS, FIRSTNAME, LASTNAME, PASSWORD, USERROLE)
	VALUES ('eli.vance.sity17@mail.ru', 'Илай', 'Вэнс', 'eli.vance.sity17', 'ADMINISTRATOR');
INSERT INTO users (EMAILADDRESS, FIRSTNAME, LASTNAME, PASSWORD, USERROLE)
	VALUES ('wallace.breen.sity17@mail.ru', 'Уоллес', 'Брин', 'wallace.breen.sity17', 'ADMINISTRATOR');

-- ----------------- Initializing user (with user privileges) -----------------

INSERT INTO users (EMAILADDRESS, FIRSTNAME, LASTNAME, PASSWORD, USERROLE)
	VALUES ('judith.mossman.bm@mail.ru', 'Джудит', 'Моссман', 'judith.mossman.bm', 'USER');
INSERT INTO users (EMAILADDRESS, FIRSTNAME, LASTNAME, PASSWORD, USERROLE)
	VALUES ('isaac.kleiner.bm@mail.ru', 'Айзек', 'Кляйнер', 'isaac.kleiner.bm', 'USER');
INSERT INTO users (EMAILADDRESS, FIRSTNAME, LASTNAME, PASSWORD, USERROLE)
	VALUES ('barney.calhoun.bm@mail.ru', 'Барни', 'Калхаун', 'barney.calhoun.bm', 'USER');
INSERT INTO users (EMAILADDRESS, FIRSTNAME, LASTNAME, PASSWORD, USERROLE)
	VALUES ('grigori.ravenholm.bm@mail.ru', 'Отец', 'Григорий', 'grigori.ravenholm.bm', 'USER');


-- ---------------------- Initializing projects and builds --------------------

INSERT INTO projects (DESCRIPTION, NAME, MANAGER)
  VALUES ('Сайт научно-исследовательского комплекса Black Mesa', 'Сайт корпорации Black Mesa',
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'wallace.breen.sity17@mail.ru'));

INSERT INTO builds (NAME) VALUES ('1.0.16526');
INSERT INTO builds (NAME) VALUES ('1.2.54324');
INSERT INTO builds (NAME) VALUES ('1.5.24500');

INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Сайт корпорации Black Mesa'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '1.0.16526'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Сайт корпорации Black Mesa'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '1.2.54324'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Сайт корпорации Black Mesa'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '1.5.24500'));

INSERT INTO projects (DESCRIPTION, NAME, MANAGER)
  VALUES ('Интернет браузер для платформы Windows', 'Интернет-браузер OlSuBrowser',
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'alyx.vance.sity17@mail.ru'));

INSERT INTO builds (NAME) VALUES ('1.0.8');
INSERT INTO builds (NAME) VALUES ('1.0.9');
INSERT INTO builds (NAME) VALUES ('1.13.1');
INSERT INTO builds (NAME) VALUES ('1.16.8');
INSERT INTO builds (NAME) VALUES ('2.01.2');

INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Интернет-браузер OlSuBrowser'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '1.0.8'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Интернет-браузер OlSuBrowser'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '1.0.9'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Интернет-браузер OlSuBrowser'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '1.13.1'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Интернет-браузер OlSuBrowser'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '1.16.8'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Интернет-браузер OlSuBrowser'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '2.01.2'));

INSERT INTO projects (DESCRIPTION, NAME, MANAGER)
  VALUES ('JS-фреймворк ZIURqpp', 'Фреймворк ZIURqpp',
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'alyx.vance.sity17@mail.ru'));

INSERT INTO builds (NAME) VALUES ('0.6.54545');
INSERT INTO builds (NAME) VALUES ('0.7.61004');
INSERT INTO builds (NAME) VALUES ('0.7.84202');
INSERT INTO builds (NAME) VALUES ('0.9.13445');
INSERT INTO builds (NAME) VALUES ('0.9.11102');
INSERT INTO builds (NAME) VALUES ('1.0.54200');

INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Фреймворк ZIURqpp'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '0.6.54545'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Фреймворк ZIURqpp'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '0.7.61004'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Фреймворк ZIURqpp'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '0.7.84202'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Фреймворк ZIURqpp'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '0.9.13445'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Фреймворк ZIURqpp'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '0.9.11102'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Фреймворк ZIURqpp'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '1.0.54200'));

INSERT INTO projects (DESCRIPTION, NAME, MANAGER)
  VALUES ('Фото-редактор YYY1861 для платформы Windows.', 'Фото-редактор YYY1861',
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'alyx.vance.sity17@mail.ru'));

INSERT INTO builds (NAME) VALUES ('1.223.2');
INSERT INTO builds (NAME) VALUES ('1.545.0');
INSERT INTO builds (NAME) VALUES ('2.435.0');
INSERT INTO builds (NAME) VALUES ('2.521.1');
INSERT INTO builds (NAME) VALUES ('2.612.0');

INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Фото-редактор YYY1861'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '1.223.2'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Фото-редактор YYY1861'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '1.545.0'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Фото-редактор YYY1861'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '2.435.0'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Фото-редактор YYY1861'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '2.521.1'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Фото-редактор YYY1861'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '2.612.0'));

INSERT INTO projects (DESCRIPTION, NAME, MANAGER)
  VALUES ('Сайт молокозавода Пегий Холм города Гомеля.', 'Сайт молокозавода Пегий Холм',
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'eli.vance.sity17@mail.ru'));

INSERT INTO builds (NAME) VALUES ('1.0.200');
INSERT INTO builds (NAME) VALUES ('1.1.000');

INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Сайт молокозавода Пегий Холм'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '1.0.200'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Сайт молокозавода Пегий Холм'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '1.1.000'));

INSERT INTO projects (DESCRIPTION, NAME, MANAGER)
  VALUES ('Приложение для рассчётов потребления электроэнергии.', 'Приложение Энергоперерасчёт',
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'eli.vance.sity17@mail.ru'));

INSERT INTO builds (NAME) VALUES ('1.0.25');
INSERT INTO builds (NAME) VALUES ('1.5.56');
INSERT INTO builds (NAME) VALUES ('2.49.90');
INSERT INTO builds (NAME) VALUES ('4.0.12');
INSERT INTO builds (NAME) VALUES ('4.12.3');
INSERT INTO builds (NAME) VALUES ('4.16.0');
INSERT INTO builds (NAME) VALUES ('5.02.6');
INSERT INTO builds (NAME) VALUES ('5.18.9');
INSERT INTO builds (NAME) VALUES ('6.0.4');
INSERT INTO builds (NAME) VALUES ('6.6.17');

INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Приложение Энергоперерасчёт'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '1.0.25'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Приложение Энергоперерасчёт'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '1.5.56'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Приложение Энергоперерасчёт'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '2.49.90'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Приложение Энергоперерасчёт'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '4.0.12'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Приложение Энергоперерасчёт'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '4.12.3'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Приложение Энергоперерасчёт'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '4.16.0'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Приложение Энергоперерасчёт'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '5.02.6'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Приложение Энергоперерасчёт'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '5.18.9'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Приложение Энергоперерасчёт'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '6.0.4'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Приложение Энергоперерасчёт'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '6.6.17'));

INSERT INTO projects (DESCRIPTION, NAME, MANAGER)
  VALUES ('Сайт интернет-магазина Perestroika8519.', 'Сайт Perestroika8519',
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'gordon.frimen.bm@mail.ru'));

INSERT INTO builds (NAME) VALUES ('0.11.66');
INSERT INTO builds (NAME) VALUES ('0.18.0');
INSERT INTO builds (NAME) VALUES ('0.22.10');
INSERT INTO builds (NAME) VALUES ('0.30.0');

INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Сайт Perestroika8519'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '0.11.66'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Сайт Perestroika8519'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '0.18.0'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Сайт Perestroika8519'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '0.22.10'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Сайт Perestroika8519'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '0.30.0'));

INSERT INTO projects (DESCRIPTION, NAME, MANAGER)
  VALUES ('Компьютерная игра для платформы Windows.', 'Компьютерная игра Wingravity',
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'gordon.frimen.bm@mail.ru'));

INSERT INTO builds (NAME) VALUES ('0.86.23');
INSERT INTO builds (NAME) VALUES ('0.86.26');
INSERT INTO builds (NAME) VALUES ('0.88.3');
INSERT INTO builds (NAME) VALUES ('0.92.4');
INSERT INTO builds (NAME) VALUES ('0.92.15');
INSERT INTO builds (NAME) VALUES ('0.93.8');
INSERT INTO builds (NAME) VALUES ('0.93.14');
INSERT INTO builds (NAME) VALUES ('0.95.1');

INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Компьютерная игра Wingravity'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '0.86.23'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Компьютерная игра Wingravity'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '0.86.26'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Компьютерная игра Wingravity'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '0.88.3'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Компьютерная игра Wingravity'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '0.92.4'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Компьютерная игра Wingravity'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '0.92.15'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Компьютерная игра Wingravity'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '0.93.8'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Компьютерная игра Wingravity'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '0.93.14'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Компьютерная игра Wingravity'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '0.95.1'));

INSERT INTO projects (DESCRIPTION, NAME, MANAGER)
  VALUES ('Просмотр телевизионных программ в ОС.', 'Приложение MediumBTV',
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'wallace.breen.sity17@mail.ru'));

INSERT INTO builds (NAME) VALUES ('1.421.2');
INSERT INTO builds (NAME) VALUES ('1.657.1');
INSERT INTO builds (NAME) VALUES ('1.830.4');
INSERT INTO builds (NAME) VALUES ('1.837.1');
INSERT INTO builds (NAME) VALUES ('1.925.9');

INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Приложение MediumBTV'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '1.421.2'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Приложение MediumBTV'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '1.657.1'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Приложение MediumBTV'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '1.830.4'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Приложение MediumBTV'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '1.837.1'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Приложение MediumBTV'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '1.925.9'));

INSERT INTO projects (DESCRIPTION, NAME, MANAGER)
  VALUES ('Сайт библиотеки города City17.', 'Сайт библиотеки BooksCity17',
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'wallace.breen.sity17@mail.ru '));

INSERT INTO builds (NAME) VALUES ('2.911.2');
INSERT INTO builds (NAME) VALUES ('2.946.0');
INSERT INTO builds (NAME) VALUES ('2.984.6');
INSERT INTO builds (NAME) VALUES ('2.992.1');

INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Сайт библиотеки BooksCity17'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '2.911.2'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Сайт библиотеки BooksCity17'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '2.946.0'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Сайт библиотеки BooksCity17'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '2.984.6'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Сайт библиотеки BooksCity17'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '2.992.1'));


INSERT INTO projects (DESCRIPTION, NAME, MANAGER)
  VALUES ('Андроид-приложение для подсчёта калорий.', 'Приложение Калорка',
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'alyx.vance.sity17@mail.ru '));

INSERT INTO builds (NAME) VALUES ('1.18.3');
INSERT INTO builds (NAME) VALUES ('1.19.4');
INSERT INTO builds (NAME) VALUES ('1.22.14');

INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Приложение Калорка'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '1.18.3'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Приложение Калорка'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '1.19.4'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Приложение Калорка'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '1.22.14'));

INSERT INTO projects (DESCRIPTION, NAME, MANAGER)
  VALUES ('Клиентское андроид-приложение банка JHDSHO24.', 'Приложение BankCost',
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'wallace.breen.sity17@mail.ru'));

INSERT INTO builds (NAME) VALUES ('1.0');
INSERT INTO builds (NAME) VALUES ('1.1');
INSERT INTO builds (NAME) VALUES ('1.2');
INSERT INTO builds (NAME) VALUES ('1.3');
INSERT INTO builds (NAME) VALUES ('1.4');
INSERT INTO builds (NAME) VALUES ('1.5');
INSERT INTO builds (NAME) VALUES ('1.6');
INSERT INTO builds (NAME) VALUES ('1.7');
INSERT INTO builds (NAME) VALUES ('1.8');
INSERT INTO builds (NAME) VALUES ('1.9');
INSERT INTO builds (NAME) VALUES ('2.0');
INSERT INTO builds (NAME) VALUES ('2.3');

INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Приложение BankCost'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '1.0'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Приложение BankCost'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '1.1'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Приложение BankCost'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '1.2'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Приложение BankCost'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '1.3'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Приложение BankCost'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '1.4'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Приложение BankCost'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '1.5'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Приложение BankCost'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '1.6'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Приложение BankCost'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '1.7'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Приложение BankCost'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '1.8'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Приложение BankCost'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '1.9'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Приложение BankCost'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '2.0'));
INSERT INTO projects_builds (projects_id, builds_id) VALUES (
    (SELECT projects.id FROM projects WHERE projects.NAME = 'Приложение BankCost'),
    (SELECT builds.id FROM builds WHERE builds.NAME = '2.3'));


-- -------------------- Initializing issues and comments ----------------------

INSERT INTO issues (CREATEDATE, DESCRIPTION, MODIFYDATE, SUMMARY, ASSIGNEE, 
  BUILDFOUND, CREATEDBY, MODIFIEDBY, PRIORITY, PROJECT, RESOLUTION, STATUS, TYPE)
VALUES (
  '20160430',
  'Окружение: OC: Windows 7 (x64), разрешение экрана 1024x768.

Шаги для воспроизведения:
1.Поставить обновление плейлиста со списком из 250 каналов при запуске с запросом.
2.Запустить приложение.

Ожидаемый результат: Закрытие модального окна и обновление списка каналов.

Фактический результат: кнопка закрытия на виндовом окне неактивна, а кнопки отказаться 
или принять находятся за пределами монитора внизу. 
Закрытие через диспетчер задач закрывает всё приложение целиком.', 
  '20160501', 
  'Не удаётся закрыть модальное окно.', 
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'isaac.kleiner.bm@mail.ru'), 
  (SELECT builds.id FROM builds WHERE builds.NAME = '1.421.2'), 
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'wallace.breen.sity17@mail.ru'), 
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'isaac.kleiner.bm@mail.ru'), 
  (SELECT priorities.id FROM priorities WHERE priorities.NAME = 'Обычный'), 
  (SELECT projects.id FROM projects WHERE projects.NAME = 'Приложение MediumBTV'), 
  NULL,
  (SELECT statuses.id FROM statuses WHERE statuses.NAME = 'В процессе исправления'), 
  (SELECT types.id FROM types WHERE types.NAME = 'Основная ошибка'));

INSERT INTO coments (CREATEDATE, COMMENT, ADDEDBY, issue_id) 
VALUES (
  '20160501', 
  'ALT+F4 или Enter?',
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'isaac.kleiner.bm@mail.ru'), 
  (SELECT issues.id FROM issues WHERE issues.SUMMARY = 'Не удаётся закрыть модальное окно.'));

INSERT INTO coments (CREATEDATE, COMMENT, ADDEDBY, issue_id) 
VALUES (
  '20160501', 
  'Alt+F4 ничего не дает.
Enter помог, но не обновляется плейлист.',
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'wallace.breen.sity17@mail.ru'), 
  (SELECT issues.id FROM issues WHERE issues.SUMMARY = 'Не удаётся закрыть модальное окно.'));



INSERT INTO issues (CREATEDATE, DESCRIPTION, MODIFYDATE, SUMMARY, ASSIGNEE, 
  BUILDFOUND, CREATEDBY, MODIFIEDBY, PRIORITY, PROJECT, RESOLUTION, STATUS, TYPE)
VALUES (
  '20160502',
  'Окружение: OC: Windows 7 (x32).

Шаги для воспроизведения:
1.Запустить приложение.
2.Поставить запись видео в планировщике задач.

Ожидаемый результат: Завершение задания и появление главного окна приложения.

Фактический результат: По завершению задания приложение падает с ошибкой 0x0000042.', 
  '20160510', 
  'При записи через планировщик приложение падает.', 
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'wallace.breen.sity17@mail.ru'), 
  (SELECT builds.id FROM builds WHERE builds.NAME = '1.421.2'), 
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'gordon.frimen.bm@mail.ru'), 
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'gordon.frimen.bm@mail.ru'), 
  (SELECT priorities.id FROM priorities WHERE priorities.NAME = 'Важный'), 
  (SELECT projects.id FROM projects WHERE projects.NAME = 'Приложение MediumBTV'), 
  (SELECT resolutions.id FROM resolutions WHERE resolutions.NAME = 'Дефект исправлен'), 
  (SELECT statuses.id FROM statuses WHERE statuses.NAME = 'Закрыт'), 
  (SELECT types.id FROM types WHERE types.NAME = 'Ошибка функциональности'));

INSERT INTO coments (CREATEDATE, COMMENT, ADDEDBY, issue_id) 
VALUES (
  '20160509', 
  'В билде 1.657.1 исправлено.',
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'wallace.breen.sity17@mail.ru'), 
  (SELECT issues.id FROM issues WHERE issues.SUMMARY = 'При записи через планировщик приложение падает.'));

INSERT INTO coments (CREATEDATE, COMMENT, ADDEDBY, issue_id) 
VALUES (
  '20160510', 
  'Обновил приложение - пока не вылетает.',
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'gordon.frimen.bm@mail.ru'), 
  (SELECT issues.id FROM issues WHERE issues.SUMMARY = 'При записи через планировщик приложение падает.'));


INSERT INTO issues (CREATEDATE, DESCRIPTION, MODIFYDATE, SUMMARY, ASSIGNEE, 
  BUILDFOUND, CREATEDBY, MODIFIEDBY, PRIORITY, PROJECT, RESOLUTION, STATUS, TYPE)
VALUES (
  '20160511',
  'Окружение: OC: Windows 7 (x64).

Шаги для воспроизведения:
1.Запустить приложение.
2.Перейти на вкладку каналы (каналов должно быть больше 10-ти).
3.Не кликая по заголовкам столбцов перейти на следующую страницу пагинатора.

Ожидаемый результат: Следующий десяток каналов в том же порядке сортировки, что и на первой странице.

Фактический результат: При переходе на следующуй десяток каналов список сортируется.', 
  NULL, 
  'Сбивается сортировка каналов в пагинаторе.', 
  NULL,
  (SELECT builds.id FROM builds WHERE builds.NAME = '1.830.4'), 
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'wallace.breen.sity17@mail.ru'), 
  NULL, 
  (SELECT priorities.id FROM priorities WHERE priorities.NAME = 'Незначительный'), 
  (SELECT projects.id FROM projects WHERE projects.NAME = 'Приложение MediumBTV'), 
  NULL,
  (SELECT statuses.id FROM statuses WHERE statuses.NAME = 'Новый'), 
  (SELECT types.id FROM types WHERE types.NAME = 'Косметическая ошибка'));



INSERT INTO issues (CREATEDATE, DESCRIPTION, MODIFYDATE, SUMMARY, ASSIGNEE, 
  BUILDFOUND, CREATEDBY, MODIFIEDBY, PRIORITY, PROJECT, RESOLUTION, STATUS, TYPE)
VALUES (
  '20160508',
  'Окружение: OC: Windows 7 (x64).

Шаги для воспроизведения:
1.Запустить приложение.
2.Включить PiP

Ожидаемый результат: включение деинтерлейс в PiP.
Фактический результат: деинтерлейс не включается.', 
  '20160509', 
  'Не работает деинтерлейс в PiP.', 
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'wallace.breen.sity17@mail.ru'), 
  (SELECT builds.id FROM builds WHERE builds.NAME = '1.925.9'), 
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'judith.mossman.bm@mail.ru'), 
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'wallace.breen.sity17@mail.ru'), 
  (SELECT priorities.id FROM priorities WHERE priorities.NAME = 'Важный'), 
  (SELECT projects.id FROM projects WHERE projects.NAME = 'Приложение MediumBTV'), 
  NULL,
  (SELECT statuses.id FROM statuses WHERE statuses.NAME = 'В процессе исправления'), 
  (SELECT types.id FROM types WHERE types.NAME = 'Ошибка функциональности'));

INSERT INTO coments (CREATEDATE, COMMENT, ADDEDBY, issue_id) 
VALUES (
  '20160510', 
  'Сейчас можно добавить в файл vlcrcPiP такие строки:
--deinterlace=1
--deinterlace-mode=blend
--video-filter=deinterlace
В следующем билде будет добавлен выбор в контекстное меню pip',
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'wallace.breen.sity17@mail.ru'), 
  (SELECT issues.id FROM issues WHERE issues.SUMMARY = 'Не работает деинтерлейс в PiP.'));



INSERT INTO issues (CREATEDATE, DESCRIPTION, MODIFYDATE, SUMMARY, ASSIGNEE, 
  BUILDFOUND, CREATEDBY, MODIFIEDBY, PRIORITY, PROJECT, RESOLUTION, STATUS, TYPE)
VALUES (
  '20160512',
  'Окружение: OC: Windows XP SP3 (x32)

Шаги для воспроизведения:
1.Запустить приложение.
2.Запустить загрузку сохранённых телепрограмм из файлов xmltv.

Ожидаемый результат: Загрузка сохранённых телепрограмм.
Фактический результат: телепрограммы не загружаются, ошибок не появляется.', 
  '20160513', 
  'Не загружает телепрограммы JTV / XMLTV', 
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'isaac.kleiner.bm@mail.ru'), 
  (SELECT builds.id FROM builds WHERE builds.NAME = '1.837.1'), 
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'wallace.breen.sity17@mail.ru'), 
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'isaac.kleiner.bm@mail.ru'), 
  (SELECT priorities.id FROM priorities WHERE priorities.NAME = 'Незначительный'), 
  (SELECT projects.id FROM projects WHERE projects.NAME = 'Приложение MediumBTV'), 
  (SELECT resolutions.id FROM resolutions WHERE resolutions.NAME = 'Дефект исправлен'), 
  (SELECT statuses.id FROM statuses WHERE statuses.NAME = 'Закрыт'), 
  (SELECT types.id FROM types WHERE types.NAME = 'Ошибка функциональности'));

INSERT INTO coments (CREATEDATE, COMMENT, ADDEDBY, issue_id) 
VALUES (
  '20160512', 
  'Все нормально загружается, когда пересохраняешь файл xmltv в кодировке UTF-8 без BOM.',
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'wallace.breen.sity17@mail.ru'), 
  (SELECT issues.id FROM issues WHERE issues.SUMMARY = 'Не загружает телепрограммы JTV / XMLTV'));

INSERT INTO coments (CREATEDATE, COMMENT, ADDEDBY, issue_id) 
VALUES (
  '20160513', 
  'С версии 1.925.9 исправлено - UTF-8 с BOM поддерживается.',
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'isaac.kleiner.bm@mail.ru'), 
  (SELECT issues.id FROM issues WHERE issues.SUMMARY = 'Не загружает телепрограммы JTV / XMLTV'));



INSERT INTO issues (CREATEDATE, DESCRIPTION, MODIFYDATE, SUMMARY, ASSIGNEE, 
  BUILDFOUND, CREATEDBY, MODIFIEDBY, PRIORITY, PROJECT, RESOLUTION, STATUS, TYPE)
VALUES (
  '20160513',
  'Окружение: OC: Windows 7 (x32).

Шаги для воспроизведения:
1.Прейти в настройки с выбором аудио-устройства для воспроизведения.
2.Выбрать аудои-устройство не по-уполчанию.

Ожидаемый результат: Вывод звука из выбранного аудио-устройства.
Фактический результат: Звук всё равно выводится через аудио-устройство по-умолчанию.', 
  NULL, 
'Не воспроизводится звук на аудио-устройстве не по-умолчанию.',
  NULL, 
  (SELECT builds.id FROM builds WHERE builds.NAME = '1.657.1'), 
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'barney.calhoun.bm@mail.ru'), 
  NULL, 
  (SELECT priorities.id FROM priorities WHERE priorities.NAME = 'Обычный'), 
  (SELECT projects.id FROM projects WHERE projects.NAME = 'Приложение MediumBTV'), 
  NULL, 
  (SELECT statuses.id FROM statuses WHERE statuses.NAME = 'Новый'), 
  (SELECT types.id FROM types WHERE types.NAME = 'Основная ошибка'));

INSERT INTO coments (CREATEDATE, COMMENT, ADDEDBY, issue_id) 
VALUES (
  '20160514', 
  'Сделайте скриншот с демонстрацией проблемы.',
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'isaac.kleiner.bm@mail.ru'), 
  (SELECT issues.id FROM issues WHERE issues.SUMMARY = 
  	'Не воспроизводится звук на аудио-устройстве не по-умолчанию.'));

INSERT INTO coments (CREATEDATE, COMMENT, ADDEDBY, issue_id) 
VALUES (
  '20160515', 
  'Прикрепляю в image_tst_1.png',
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'barney.calhoun.bm@mail.ru'), 
  (SELECT issues.id FROM issues WHERE issues.SUMMARY = 
  	'Не воспроизводится звук на аудио-устройстве не по-умолчанию.'));

INSERT INTO coments (CREATEDATE, COMMENT, ADDEDBY, issue_id) 
VALUES (
  '20160516', 
  'Не выводит на устройство с русскими буквами.
Будет исправлено в следующей версии (скоро выйдет).',
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'isaac.kleiner.bm@mail.ru'), 
  (SELECT issues.id FROM issues WHERE issues.SUMMARY = 
  	'Не воспроизводится звук на аудио-устройстве не по-умолчанию.'));



INSERT INTO issues (CREATEDATE, DESCRIPTION, MODIFYDATE, SUMMARY, ASSIGNEE, 
  BUILDFOUND, CREATEDBY, MODIFIEDBY, PRIORITY, PROJECT, RESOLUTION, STATUS, TYPE)
VALUES (
  '20160503',
  'Окружение: OC: Windows 7 (x64), web-браузер Mozilla Firefox 46.0.1, разрешение экрана 1920x1080.

Шаги для воспроизведения:
1.Перейти с главной страницы сайта в "Категории товаров"

Ожидаемый результат: полное отображение товаров или сокращённые с добавлением троеточия.

Фактический результат: длинные предложения обрезаются на полуслове.', 
  NULL, 
  'Не помещается текст в "Краткой информации"', 
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'eli.vance.sity17@mail.ru'), 
  (SELECT builds.id FROM builds WHERE builds.NAME = '1.1.000'), 
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'grigori.ravenholm.bm@mail.ru'), 
  NULL, 
  (SELECT priorities.id FROM priorities WHERE priorities.NAME = 'Незначительный'), 
  (SELECT projects.id FROM projects WHERE projects.NAME = 'Сайт молокозавода Пегий Холм'), 
  NULL, 
  (SELECT statuses.id FROM statuses WHERE statuses.NAME = 'Назначен исполнитель'), 
  (SELECT types.id FROM types WHERE types.NAME = 'Косметическая ошибка'));



INSERT INTO issues (CREATEDATE, DESCRIPTION, MODIFYDATE, SUMMARY, ASSIGNEE, 
  BUILDFOUND, CREATEDBY, MODIFIEDBY, PRIORITY, PROJECT, RESOLUTION, STATUS, TYPE)
VALUES (
  '20160509',
  'Окружение: OC: Windows 7 (x64).

Шаги для воспроизведения:
1.Толкнуть тележку с образцом GG-3883 в антимасс-спектрометр.
2.Подняться по лестнице и запустить антимасс-спектрометр.

Ожидаемый результат: получение информационных данных о образце и завершение эксперимента.
Фактический результат: происходит каскадный резонанс, пользователя швыряет между мирами.', 
  '20160510', 
  'Каскадный резонанс в секторе C «Испытательная лаборатория C-33/a»', 
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'gordon.frimen.bm@mail.ru'), 
  (SELECT builds.id FROM builds WHERE builds.NAME = '0.92.4'), 
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'alyx.vance.sity17@mail.ru'), 
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'gordon.frimen.bm@mail.ru'), 
  (SELECT priorities.id FROM priorities WHERE priorities.NAME = 'Критический'), 
  (SELECT projects.id FROM projects WHERE projects.NAME = 'Компьютерная игра Wingravity'), 
  NULL, 
  (SELECT statuses.id FROM statuses WHERE statuses.NAME = 'В процессе исправления'), 
  (SELECT types.id FROM types WHERE types.NAME = 'Основная ошибка'));

INSERT INTO coments (CREATEDATE, COMMENT, ADDEDBY, issue_id) 
VALUES (
  '20160511', 
  '...',
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'gordon.frimen.bm@mail.ru'), 
  (SELECT issues.id FROM issues WHERE issues.SUMMARY = 
  	'Каскадный резонанс в секторе C «Испытательная лаборатория C-33/a»'));



INSERT INTO issues (CREATEDATE, DESCRIPTION, MODIFYDATE, SUMMARY, ASSIGNEE, 
  BUILDFOUND, CREATEDBY, MODIFIEDBY, PRIORITY, PROJECT, RESOLUTION, STATUS, TYPE)
VALUES (
  '20160515',
  'Окружение: OC: Windows 7 (x64), web-браузер Mozilla Firefox 46.0.1, разрешение экрана 1920x1080.

Шаги для воспроизведения:
1.Зайти на сайт под ролью администратора.
2.На любой странице нажать на переход по любым ссылкам в футере страниц.

Ожидаемый результат: переход на выбраную страницу.
Фактический результат: ошибка сервера 404.
Под ролью обычного пользователя (не администратора - открывается без проблем).', 
  NULL, 
'Ссылки на в футере не достигают места назначения',
  NULL, 
  (SELECT builds.id FROM builds WHERE builds.NAME = '2.984.6'), 
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'judith.mossman.bm@mail.ru'), 
  NULL, 
  (SELECT priorities.id FROM priorities WHERE priorities.NAME = 'Важный'), 
  (SELECT projects.id FROM projects WHERE projects.NAME = 'Сайт библиотеки BooksCity17'), 
  NULL, 
  (SELECT statuses.id FROM statuses WHERE statuses.NAME = 'Новый'), 
  (SELECT types.id FROM types WHERE types.NAME = 'Основная ошибка'));



INSERT INTO issues (CREATEDATE, DESCRIPTION, MODIFYDATE, SUMMARY, ASSIGNEE, 
  BUILDFOUND, CREATEDBY, MODIFIEDBY, PRIORITY, PROJECT, RESOLUTION, STATUS, TYPE)
VALUES (
  '20160428',
  'Окружение: OC: Debian 8.4.

Шаги для воспроизведения:
1.Использовать функцию jumpToPage() после bootstrap-инициализации.

Ожидаемый результат: переход по на указанную страницу.
Фактический результат: переход по на указанную страницу и сброс роли пользователя в Security.', 
  NULL, 
'Сайд-эффект при использовании функции jumpToPage()',
  NULL, 
  (SELECT builds.id FROM builds WHERE builds.NAME = '0.9.13445'), 
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'gordon.frimen.bm@mail.ru'), 
  NULL, 
  (SELECT priorities.id FROM priorities WHERE priorities.NAME = 'Критический'), 
  (SELECT projects.id FROM projects WHERE projects.NAME = 'Фреймворк ZIURqpp'), 
  NULL, 
  (SELECT statuses.id FROM statuses WHERE statuses.NAME = 'Новый'), 
  (SELECT types.id FROM types WHERE types.NAME = 'Ошибка функциональности'));



INSERT INTO issues (CREATEDATE, DESCRIPTION, MODIFYDATE, SUMMARY, ASSIGNEE, 
  BUILDFOUND, CREATEDBY, MODIFIEDBY, PRIORITY, PROJECT, RESOLUTION, STATUS, TYPE)
VALUES (
  '20160402',
  'Окружение: VirtualBox 5.0.16, OC: Windows 7 SP1 (x32).

Шаги для воспроизведения:
1.Запустить виртуальную машину.
2.Запустить установленный браузер.

Ожидаемый результат: запуск браузера.
Фактический результат: появляется ошибка 0x0000042 и браузер не запускается.
Предыдущие версии запускались без проблемм.', 
  NULL, 
  'Не запускается браузер на виртуальной машине с Windows 7', 
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'alyx.vance.sity17@mail.ru'), 
  (SELECT builds.id FROM builds WHERE builds.NAME = '1.13.1'), 
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'grigori.ravenholm.bm@mail.ru'), 
  NULL, 
  (SELECT priorities.id FROM priorities WHERE priorities.NAME = 'Критический'), 
  (SELECT projects.id FROM projects WHERE projects.NAME = 'Интернет-браузер OlSuBrowser'), 
  NULL, 
  (SELECT statuses.id FROM statuses WHERE statuses.NAME = 'Назначен исполнитель'), 
  (SELECT types.id FROM types WHERE types.NAME = 'Основная ошибка'));



INSERT INTO issues (CREATEDATE, DESCRIPTION, MODIFYDATE, SUMMARY, ASSIGNEE, 
  BUILDFOUND, CREATEDBY, MODIFIEDBY, PRIORITY, PROJECT, RESOLUTION, STATUS, TYPE)
VALUES (
  '20160520',
  'Окружение: OC: Windows 7 (x64), видеокарты серии GTX650 (Ti), настройки отображения: максимальные.

Шаги для воспроизведения:
1.Через 10 минут игры производительность просаживается с 60 FPS до 13-15 FPS.', 
  NULL, 
  'Падает производительность на видеокартах серии GTX 650', 
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'gordon.frimen.bm@mail.ru'), 
  (SELECT builds.id FROM builds WHERE builds.NAME = '0.92.4'), 
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'alyx.vance.sity17@mail.ru'), 
  NULL, 
  (SELECT priorities.id FROM priorities WHERE priorities.NAME = 'Важный'), 
  (SELECT projects.id FROM projects WHERE projects.NAME = 'Компьютерная игра Wingravity'), 
  NULL, 
  (SELECT statuses.id FROM statuses WHERE statuses.NAME = 'Назначен исполнитель'), 
  (SELECT types.id FROM types WHERE types.NAME = 'Ошибка производительности'));




INSERT INTO issues (CREATEDATE, DESCRIPTION, MODIFYDATE, SUMMARY, ASSIGNEE, 
  BUILDFOUND, CREATEDBY, MODIFIEDBY, PRIORITY, PROJECT, RESOLUTION, STATUS, TYPE)
VALUES (
  '20160504',
  'Окружение: OC: Windows XP SP3 (x32). 

Шаги для воспроизведения: 
1.Прейти в Помощь -> О приложении -> BankCost. 

Ожидаемый результат: Отрытие сайта банка в web-браузере. 
Фактический результат: Приложение перезагружается.', 
  '20160505', 
  'Приложение перезагружается при нажатии перехода на сайт программы', 
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'grigori.ravenholm.bm@mail.ru'), 
  (SELECT builds.id FROM builds WHERE builds.NAME = '1.6'), 
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'wallace.breen.sity17@mail.ru'), 
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'grigori.ravenholm.bm@mail.ru'), 
  (SELECT priorities.id FROM priorities WHERE priorities.NAME = 'Незначительный'), 
  (SELECT projects.id FROM projects WHERE projects.NAME = 'Приложение BankCost'), 
  (SELECT resolutions.id FROM resolutions WHERE resolutions.NAME = 'Не воспроизводится'), 
  (SELECT statuses.id FROM statuses WHERE statuses.NAME = 'Закрыт'), 
  (SELECT types.id FROM types WHERE types.NAME = 'Основная ошибка'));

INSERT INTO coments (CREATEDATE, COMMENT, ADDEDBY, issue_id) 
VALUES (
  '20160505', 
  'Дефект не воспроизводится на Win7, 8 и 10. 
Попробуйте переустановить приложение.',
  (SELECT users.id FROM users WHERE users.EMAILADDRESS = 'grigori.ravenholm.bm@mail.ru'), 
  (SELECT issues.id FROM issues WHERE issues.SUMMARY = 
  	'Приложение перезагружается при нажатии перехода на сайт программы'));

