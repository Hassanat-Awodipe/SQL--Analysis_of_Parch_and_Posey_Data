/*Example:
Imagine you have to find the record of web-events that occurred before the company made their first sale.
before the first purchase ever */

SELECT o.id, --first order
	o.occurred_at AS order_date, --time
	w.* --all webevents prior to first sale
FROM orders o
LEFT JOIN web_events w
ON w.account_id = o.account_id AND w.occurred_at < o.occurred_at
WHERE DATE_TRUNC('month', o.occurred_at) = (
					SELECT DATE_TRUNC('month', MIN(occurred_at)) --first sale
					FROM orders)
ORDER BY o.account_id, o.occurred_at;


--Write a query that left joins the accounts table and the sales_reps tables on each sale rep's ID and joins it using the < comparison operator on accounts.primary_poc and sales_reps.name. 
 SELECT a.name account_name, 
 	a.primary_poc,
	s.name sales_rep
 FROM accounts a
 LEFT JOIN sales_reps s  --note that because you are left joining accounts table, you have to select account table first.
 ON s.id = a.sales_rep_id AND a.primary_poc < s.name --arranges alphabetically



