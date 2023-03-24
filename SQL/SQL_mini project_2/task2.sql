/* Solution 1 */
Select a.sales_rep_id, s.name as "sales_rep_name", s.region_id as "sales_rep_region", a.name as "account_name", 
Row_number() over (Partition By s.region_id, s.name) as "account_num"
From sales_rep s INNER JOIN accounts a
ON s.ID = a.sales_rep_id
LIMIT 100;

/* Solution 2 */

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

/* Solution 3*/
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