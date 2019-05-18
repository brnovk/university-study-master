USE stud_db;

-- Создание таблиц

-- ------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS tab_mother_stud; 
DROP TABLE IF EXISTS tab_father_stud; /* Сначала удаляем все дочерние таблицы, */ 
DROP TABLE IF EXISTS tab_stud; 
DROP TABLE IF EXISTS tab_group; 
DROP TABLE IF EXISTS tab_curator; 
DROP TABLE IF EXISTS tab_facultet;    /* затем все родительские.               */ 
DROP TABLE IF EXISTS tab_cost; 
DROP TABLE IF EXISTS tab_community; 

-- ------------------------------------------------------------------------------------------------
-- Создаём таблицу факультетов
CREATE TABLE tab_facultet 
( 
  id_facultet  INT NOT NULL PRIMARY KEY auto_increment, 
  facultet     CHAR(30) CHARACTER SET utf8 NOT NULL UNIQUE, 
  surname_dean CHAR(30) CHARACTER SET utf8 
); 

-- Создаём таблицу кураторов
CREATE TABLE tab_curator
( 
  id_curator      INT NOT NULL PRIMARY KEY auto_increment, 
  surname_curator CHAR(30) CHARACTER SET utf8 NOT NULL, 
  name_curator    CHAR(30) CHARACTER SET utf8 NOT NULL, 
  id_facultet     INT, 
  number_phone    CHAR(20), 
  FOREIGN KEY (id_facultet) REFERENCES tab_facultet (id_facultet)
    ON DELETE SET NULL
    ON UPDATE CASCADE 
); 

-- Создаём таблицу цен на обучение
CREATE TABLE tab_cost 
( 
  id_cost INT NOT NULL PRIMARY KEY auto_increment, 
  cost    BIGINT NOT NULL 
); 

-- Создаём таблицу групп
CREATE TABLE tab_group
( 
  id_group    INT NOT NULL PRIMARY KEY auto_increment, 
  name_group  CHAR(10) CHARACTER SET utf8 NOT NULL, 
  course      SMALLINT NOT NULL, 
  id_facultet INT, 
  id_curator  INT, 
  id_cost     INT, 
  FOREIGN KEY (id_facultet) REFERENCES tab_facultet (id_facultet)
    ON DELETE CASCADE
    ON UPDATE CASCADE, 
  FOREIGN KEY (id_curator) REFERENCES tab_curator (id_curator)
    ON DELETE SET NULL
    ON UPDATE CASCADE, 
  FOREIGN KEY (id_cost) REFERENCES tab_cost (id_cost)
    ON DELETE SET NULL
    ON UPDATE CASCADE 
); 

-- Создаём таблицу общежитий
CREATE TABLE tab_community
( 
  id_community INT NOT NULL PRIMARY KEY auto_increment, 
  adress       CHAR(50) CHARACTER SET utf8 NOT NULL, 
  number_phone CHAR(20) 
); 

-- Создаём таблицу студентов
CREATE TABLE tab_stud
(
  id_stud      INT NOT NULL PRIMARY KEY auto_increment, 
  surname_stud CHAR(30) CHARACTER SET utf8, 
  name_stud    CHAR(20) CHARACTER SET utf8, 
  age_stud     SMALLINT(6), 
  id_group     INT, 
  id_community INT, 
  id_cost      INT, 
  FOREIGN KEY (id_community) REFERENCES tab_community (id_community)
    ON DELETE SET NULL
    ON UPDATE CASCADE, 
  FOREIGN KEY (id_group) REFERENCES tab_group (id_group)
    ON DELETE SET NULL 
    ON UPDATE CASCADE, 
  FOREIGN KEY (id_cost) REFERENCES tab_cost (id_cost)
    ON DELETE SET NULL
    ON UPDATE CASCADE 
); 

-- Создаём таблицу матерей студентов
CREATE TABLE tab_mother_stud
( 
  id_mother           INT NOT NULL PRIMARY KEY auto_increment, 
  id_stud             INT, 
  surname_mother_stud CHAR(30) CHARACTER SET utf8 NOT NULL, 
  name_mother_stud    CHAR(20) CHARACTER SET utf8, 
  age_mother_stud     SMALLINT(6), 
  FOREIGN KEY (id_stud) REFERENCES tab_stud(id_stud)
    ON DELETE CASCADE
    ON UPDATE CASCADE
); 

-- Создаём таблицу отцов студентов
CREATE TABLE tab_father_stud
( 
  id_father           INT NOT NULL PRIMARY KEY auto_increment, 
  id_stud             INT, 
  surname_father_stud CHAR(30) CHARACTER SET utf8 NOT NULL, 
  name_father_stud    CHAR(20) CHARACTER SET utf8, 
  age_father_stud     SMALLINT(6), 
  FOREIGN KEY (id_stud) REFERENCES tab_stud(id_stud) 
    ON DELETE CASCADE
    ON UPDATE CASCADE 
);

-- ------------------------------------------------------------------------------------------------
commit work;
