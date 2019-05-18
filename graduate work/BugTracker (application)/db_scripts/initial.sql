
-- ----------------------------------------------------------------------------

USE bugtracker;

-- -------- First user initialization (with administrative privileges) --------

INSERT INTO users (EMAILADDRESS, FIRSTNAME, LASTNAME, PASSWORD, USERROLE)
	VALUES ('vpupkin@mail.ru', 'Василий', 'Пупкин', '12345', 'ADMINISTRATOR');

-- -------------------------- Initializing priorities -------------------------

INSERT INTO priorities (NAME) VALUES ('Критический');     -- Критический дефект     / critical
INSERT INTO priorities (NAME) VALUES ('Важный');          -- Важный дефект          / important
INSERT INTO priorities (NAME) VALUES ('Обычный');         -- Обычный дефект         / major
INSERT INTO priorities (NAME) VALUES ('Незначительный');  -- Незначительный дефект  / minor


-- ------------------------- Initializing resolutions -------------------------
-- решение, с которым закрыт дефект
INSERT INTO resolutions (NAME) VALUES ('Дефект исправлен');        -- дефект исправлен        / fixed
INSERT INTO resolutions (NAME) VALUES ('Задача не имеет смысла');  -- задача не имеет смысла  / invalid
INSERT INTO resolutions (NAME) VALUES ('Нельзя исправить');        -- нельзя исправить        / wontfix
INSERT INTO resolutions (NAME) VALUES ('Не воспроизводится');      -- не воспроизводится      / worksforme

-- --------------------------- Initializing statuses --------------------------

INSERT INTO statuses (NAME) VALUES ('Новый');                   -- Новый                   / new
INSERT INTO statuses (NAME) VALUES ('Назначен исполнитель');    -- Назначен исполнитель    / assigned
INSERT INTO statuses (NAME) VALUES ('В процессе исправления');  -- В процессе исправления  / inprogress
INSERT INTO statuses (NAME) VALUES ('Решён');                   -- Решён                   / resolved
INSERT INTO statuses (NAME) VALUES ('Закрыт');                  -- Закрыт                  / closed
INSERT INTO statuses (NAME) VALUES ('Повторно открыт');         -- Повторно открыт         / reopened

-- ----------------------------- Initializing types ---------------------------

INSERT INTO types (NAME) VALUES ('Косметическая ошибка');       -- Косметическая ошибка       / cosmetic
INSERT INTO types (NAME) VALUES ('Основная ошибка');            -- Основная ошибка            / bug
INSERT INTO types (NAME) VALUES ('Ошибка функциональности');    -- Ошибка функциональности    / feature
INSERT INTO types (NAME) VALUES ('Ошибка производительности');  -- Ошибка производительности  / performance
