/* Creating Database and Schema */

Create database dwh2;

Create table region(
	ID INT PRIMARY KEY NOT NULL,
	Name VARCHAR
);

Create table sales_rep(
	ID INT PRIMARY KEY NOT NULL,
	name VARCHAR,
	region_id INT,
	Foreign Key (region_id) References region (ID)
);

Create table accounts(
	ID INT Primary Key,
	name varchar,
	website varchar,
	lat float,
	long  float,
	primary_poc varchar,
	sales_rep_id INT,
	Foreign Key (sales_rep_id) References sales_rep (ID)	
);

Create table web_events(
	ID INT Primary Key Not Null,
	account_id INT,
	occured_at TIMESTAMP,
	channel varchar,
	Foreign Key (account_id) References accounts(ID)
);

create table orders(
	ID INT Primary Key,
	account_id INT,
	occured_at TIMESTAMP,
	standard_qty INT,
	gloss_qty INT,
	poster_qty INT,
	total INT,
	standard_amount_usd float,
	gloss_amount_usd float,
	poster_amount_usd float,
	total_amount_usd float,
	
	Foreign Key (account_id) References accounts (ID)
);

/*Bulk loading commands: */

\copy region from 'D:/region.csv' WITH DELIMITER ',' CSV HEADER;

\copy sales_rep from 'D:/sales_rep.csv' WITH DELIMITER ',' CSV HEADER;

\copy accounts from 'D:/accounts.csv' WITH DELIMITER ',' CSV HEADER;

\copy web_events from 'D:/web_events.csv' WITH DELIMITER ',' CSV HEADER;

\copy orders from 'D:/orders.csv' WITH DELIMITER ',' CSV HEADER;

