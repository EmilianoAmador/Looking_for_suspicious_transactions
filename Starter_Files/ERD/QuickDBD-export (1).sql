--
-- PostgreSQL database dump
--

-- Dumped from database version 12.2
-- Dumped by pg_dump version 12.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--Drop Table if it Exist

DROP TABLE IF EXISTS card_holder;
DROP TABLE IF EXISTS credit_card;
DROP TABLE IF EXISTS merchant_categories;
DROP TABLE IF EXISTS merchant;
DROP TABLE IF EXISTS transaction;


CREATE TABLE card_holder (
	id INT PRIMARY KEY NOT NULL,
	name VARCHAR(30) NOT NULL
);

CREATE TABLE credit_card (
	card VARCHAR(20) PRIMARY KEY NOT NULL,
	id_card_holder INT NOT NULL,
	FOREIGN KEY (id_card_holder) REFERENCES card_holder(id)
);

CREATE TABLE merchant_category (
	id INT PRIMARY KEY NOT NULL,
	name VARCHAR(30)
);

CREATE TABLE merchant(
	id INT PRIMARY KEY NOT NULL,
	name VARCHAR(30),
	id_merchant_category INT NOT NULL,
	FOREIGN KEY (id_merchant_category) REFERENCES merchant_category(id)
);

CREATE TABLE transaction(
	id INT PRIMARY KEY NOT NULL,
	date DATE NOT NULL,
	amount FLOAT NOT NULL,
	card VARCHAR(30),
	id_merchant INT,
	FOREIGN KEY (id_merchant) REFERENCES merchant(id)
);
