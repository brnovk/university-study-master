USE stud_db;

-- Создание дополнительной таблицы логгирования и триггера

-- ------------------------------------------------------------------------------------------------

-- Создание таблицы логирования
CREATE TABLE `tab_stud_log`
(
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `msg` VARCHAR(255) NOT NULL,
  `time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `row_id` INT(11) NOT NULL 
) ENGINE = MYISAM;

-- Создание триггера (Вызывается при вставке значения в таблицу студентов)
CREATE TRIGGER `update_stud_event` AFTER INSERT ON `tab_stud`
FOR EACH ROW BEGIN
  INSERT INTO tab_stud_log Set msg = 'insert', row_id = NEW.id_stud;
END;

-- ------------------------------------------------------------------------------------------------
commit work;
