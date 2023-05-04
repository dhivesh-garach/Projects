/* One of the reporting view that the business wants to setup is to track how the sales reps are performing. There is a need to track the following:

1. Which sales reps are handling which accounts? Your output should look as given below: */

Select a.sales_rep_id, s.name as "sales_rep_name", s.region_id as "sales_rep_region", a.name as "account_name", 
Row_number() over (Partition By s.region_id, s.name) as "account_num"
From sales_rep s INNER JOIN accounts a
ON s.ID = a.sales_rep_id
LIMIT 100;

/* 2. One of the aspects that the business wants to explore is what has been the share of each sales representative's s year on year sales out of the total yearly sales. */

WITH stb AS (
	Select extract(year from occured_at) as years, s.name as sales_rep_name, SUM(total_amount_usd) as total_sales
	From sales_rep s INNER JOIN accounts a
	ON s.ID = a.sales_rep_id INNER JOIN orders o
	ON a.ID = o.account_id
	Group By years, sales_rep_name
	Order by years, total_sales desc
	)
Select years, sales_rep_name, round((100*total_sales/SUM(total_sales) OVER (Partition by years))::numeric,2) as perc_sales_rep,
Rank() over (Partition By years Order by total_sales desc) as rank_sales_rep
from stb;

/* Repeating the analysis given above but this time for region. Generated the percentage contribution of each region to total yearly revenue over years */

With rtb AS (
	Select extract(year from occured_at) as years, r.name as Region, sum(total_amount_usd) as Revenue
	From region r INNER JOIN sales_rep s
	ON r.ID = s.region_id INNER JOIN accounts a
	ON s.ID = a.sales_rep_id INNER JOIN orders o
	ON a.ID = o.account_id
	Group By years, Region
	Order By years, Revenue desc
	)
Select years, region, round((100*revenue/sum(revenue) over (Partition By years))::numeric,2) as perc_rev_region,
Rank() over (Partition By years Order By revenue desc) as rank_region
From rtb;