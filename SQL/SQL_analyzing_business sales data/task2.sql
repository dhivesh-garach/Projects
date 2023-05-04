select * from retail_sales;
select distinct(kind_of_business) from retail_sales;

/* TASK 2 */
/* After the yearly analysis from below, The Business is good at product categories "GAFO(1)",
"Motor vehicle and parts dealers", "Automobile and other motor vehicle dealers", and "Automobile dealers" */
Select years, business, total_revenue, 100*total_revenue/sum(total_revenue) over (Partition By years) as yearly_perc_rev
from
(Select extract(year from sales_date) as years, kind_of_business as business, sum(sales) as total_revenue
from retail_sales
where kind_of_business NOT Like 'Retail%'
group by years, kind_of_business
order by years, total_revenue desc) AS temp1

/* TASK 3 */
/*As per the analysis, from till date total revenue between these 2 Product lines, The Women clothing stores contributes more than 80% of the overall revenue to the business*/
Select business, total_revenue, 100*total_revenue/sum(total_revenue) Over() as "perc_catg_sales"
from
(Select kind_of_business as business, sum(sales) as total_revenue
from retail_sales
where kind_of_business In ('Women''s clothing stores', 'Men''s clothing stores')
group by kind_of_business) as temp2;

/* TASK 4*/
/*Calculating Y-O-Y Percentage revenue Growth of all product lines of Past 10 years*/
/* Created a CTE to find out growing product lines since past 10 years */
With temp3 AS 
(select years,kind_of_business,revenue, revenue - lag(revenue) over (Partition By kind_of_business order by years) as yoy_revenue_growth,
(revenue - lag(revenue) over (Partition By kind_of_business order by years))/lag(revenue) over (Partition By kind_of_business order by years) * 100 as Perc_growth
FROM
(select extract(year from sales_date) as "years", kind_of_business, sum(sales) as revenue
from retail_sales
group by years, kind_of_Business
order by years, kind_of_Business) as p

where years between '2010' and '2020')

Select * from temp3;
