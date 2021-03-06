﻿-- ------------- Creating tables : first parent, then the child ---------------
-- ----------------------------------------------------------------------------

CONNECT TO LABSV4;

-- Create table product
CREATE TABLE "VIKTOR BARANOV".PRODUCT ( 
	ID INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 0, INCREMENT BY 1, NO CACHE),
	NAME VARCHAR (105) NOT NULL,
	PRICE BIGINT NOT NULL,
	TERM_IMPLEMENTATION DATE,
	PRIMARY KEY (ID)) IN USERSPACE1;
COMMENT ON TABLE "VIKTOR BARANOV".PRODUCT IS 'Таблица изделий';

-- Create table storage
CREATE TABLE "VIKTOR BARANOV".STORAGE (
	ID INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 0, INCREMENT BY 1, NO CACHE),
	DATE_MANUFACTURE DATE, 
	AMOUNT INTEGER, 
	PRODUCTID INTEGER NOT NULL,
	PRIMARY KEY (ID), 
	FOREIGN KEY (PRODUCTID) 
		REFERENCES "VIKTOR BARANOV".PRODUCT (ID)
		ON DELETE RESTRICT
		ON UPDATE NO ACTION
		ENFORCED DISABLE QUERY OPTIMIZATION) IN USERSPACE1;
COMMENT ON TABLE "VIKTOR BARANOV".STORAGE IS 'Таблица склада';

-- Create table post
CREATE TABLE "VIKTOR BARANOV".POST (
	ID INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 0, INCREMENT BY 1, NO CACHE),
	NAME VARCHAR (56) NOT NULL,
	SALARY BIGINT,
	UNIQUE (NAME),
	PRIMARY KEY (ID)) IN USERSPACE1;
COMMENT ON TABLE "VIKTOR BARANOV".POST IS 'Таблица должностей';

-- Create table category
CREATE TABLE "VIKTOR BARANOV".CATEGORY (
	ID INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 0, INCREMENT BY 1, NO CACHE),
	NAME VARCHAR (58) NOT NULL,
	UNIQUE (NAME),
	PRIMARY KEY (ID)) IN USERSPACE1;
COMMENT ON TABLE "VIKTOR BARANOV".CATEGORY IS 'Таблица категорий';

-- Create table employee
CREATE TABLE "VIKTOR BARANOV".EMPLOYEE (
	ID INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 0, INCREMENT BY 1, NO CACHE),
	FULL_NAME VARCHAR (60) NOT NULL,
	REPORT_CARD_NUMBER VARCHAR (8) NOT NULL,
	POSTID INTEGER,
	CATEGORYID INTEGER,
	PRIMARY KEY (ID),
	UNIQUE (REPORT_CARD_NUMBER),
	FOREIGN KEY (POSTID) REFERENCES "VIKTOR BARANOV".POST (ID)
		ON DELETE RESTRICT 
		ON UPDATE NO ACTION 
		ENFORCED DISABLE QUERY OPTIMIZATION,
	FOREIGN KEY (CATEGORYID) REFERENCES "VIKTOR BARANOV".CATEGORY (ID)
		ON DELETE RESTRICT
		ON UPDATE NO ACTION
		ENFORCED  DISABLE QUERY OPTIMIZATION) IN USERSPACE1;
COMMENT ON TABLE "VIKTOR BARANOV".EMPLOYEE IS 'Таблица сотрудников';

-- Create table buyer
CREATE TABLE "VIKTOR BARANOV".BUYER (
	ID INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 0, INCREMENT BY 1, NO CACHE),
	NAME VARCHAR (180) NOT NULL,
	ADDRESS VARCHAR (130),
	PRIMARY KEY (ID)) IN USERSPACE1;
COMMENT ON TABLE "VIKTOR BARANOV".BUYER IS 'Таблица покупателей';

-- Create table sale
CREATE TABLE "VIKTOR BARANOV".SALE (
	ID INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 0, INCREMENT BY 1, NO CACHE),
	SALE_DATE DATE NOT NULL,
	AMOUNT INTEGER NOT NULL,
	EMPLOYEEID INTEGER,
	BUYERID INTEGER,
	PRODUCTID INTEGER,
	PRIMARY KEY (ID),
	FOREIGN KEY (EMPLOYEEID) REFERENCES "VIKTOR BARANOV".EMPLOYEE (ID)
		ON DELETE SET NULL
		ON UPDATE NO ACTION
		ENFORCED DISABLE QUERY OPTIMIZATION,
	FOREIGN KEY (BUYERID) REFERENCES "VIKTOR BARANOV".BUYER (ID)
		ON DELETE SET NULL
		ON UPDATE NO ACTION
		ENFORCED DISABLE QUERY OPTIMIZATION,
	FOREIGN KEY (PRODUCTID) REFERENCES "VIKTOR BARANOV".PRODUCT (ID)
		ON DELETE SET NULL
		ON UPDATE NO ACTION
		ENFORCED DISABLE QUERY OPTIMIZATION) IN USERSPACE1;
COMMENT ON TABLE "VIKTOR BARANOV".SALE IS 'Таблица продаж';

CONNECT RESET;
