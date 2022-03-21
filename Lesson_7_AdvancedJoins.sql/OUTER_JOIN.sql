-- outer join to determine if there are sales reps without an account and accounts without a sales rep.
SELECT a.name account_name,
	   s. name sales_rep_name
FROM sales_reps s
FULL OUTER JOIN accounts a
ON a.sales_rep_id = s.id