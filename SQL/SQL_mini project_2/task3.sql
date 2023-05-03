/* Understanding which accounts contribute to the bulk of the revenue and the business also wants to see year on year trend on the revenue contribution of each account. */

/* The final table should show revenue share of each account for each year's total revenue */

With artb AS (
	SELECT Extract(YEAR from occured_at) as years, a.name as acc_name, SUM(total_amount_usd) as revenue
	FROM accounts a INNER JOIN orders o
	ON a.ID = o.account_id
	Group by years, acc_name
	Order By years, revenue desc
	)
Select years, acc_name, round(revenue::numeric,2), ROUND((100*revenue/SUM(revenue) OVER (Partition By years))::numeric,2) as pct_yearly_rev,
RANK() OVER (Partition By years Order By revenue desc) as rev_rank
FROM artb;