/*4. web_events;*/
CREATE TABLE web_events(
	id SMALLINT NOT NULL PRIMARY KEY,
	account_id SMALLINT,
	occurred_at TIMESTAMP,
	channel VARCHAR(20),
	FOREIGN KEY (account_id) REFERENCES accounts(id)
);

/*2. sales_reps;*/			 
CREATE TABLE sales_reps(
	id INT NOT NULL PRIMARY KEY,
	name VARCHAR(40),
	region_id SMALLINT,
	FOREIGN KEY (region_id) REFERENCES region(id)
);

/*1. region;*/
CREATE TABLE region(
			id SMALLINT NOT NULL PRIMARY KEY,
			name VARCHAR(40)
);

/*3. accounts;*/
CREATE TABLE accounts(
	id SMALLINT NOT NULL PRIMARY KEY,
	name VARCHAR(40),
	website VARCHAR(50),
	lat REAL,
	long REAL,
	primary_poc VARCHAR(40),
	sales_rep_id INT, 
	FOREIGN KEY (sales_rep_id) REFERENCES sales_reps(id)
);

/*5. orders;*/
CREATE TABLE orders(
	id SMALLINT NOT NULL PRIMARY KEY,
	account_id SMALLINT,
	standard_qty INT,
	poster_qty INT,
	glossy_qty INT,
	total INT,
	occurred_at TIMESTAMP,
	standard_amt_usd MONEY,
	gloss_amt_usd MONEY,
	poster_amt_usd MONEY,
	total_amt_usd MONEY,
	FOREIGN KEY (account_id) REFERENCES accounts(id)
);

SELECT *
FROM region;

SELECT *
FROM sales_reps;

SELECT *
FROM accounts;

SELECT *
FROM region;

SELECT *
FROM web_events;

SELECT *
FROM orders;