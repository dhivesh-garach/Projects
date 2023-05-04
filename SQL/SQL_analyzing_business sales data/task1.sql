/* Creating the table structure to store the data */
Create table retail_sales (
sales_date DATE,
naics_code TEXT,
kind_of_business VARCHAR,
reason_for_null VARCHAR,
sales FLOAT
)

/* Bulk loading the data in to the table */
\copy retails_sales from 'D:\Dhivesh\HeroVired ABADS Course Files\Mini Projects\SQL Mini Project 2\Dataset\retail_sales.csv' WITH DELIMITER CSV HEADER;

Select * from retail_sales;