--we need to understand all the orders that are received every day.
--we could do all these in one big query but we can also aggregate in small queries then joing the subauerirs to get relevant data
--one big query
SELECT DATE_TRUNC('day', o.occurred_at) AS date,
		COUNT(DISTINCT a.sales_rep_id) AS active_sales_reps, --count distinct so that the sales reps are not counted twice
		COUNT(DISTINCT o.id) AS orders,
		COUNT(DISTINCT w.id) AS web_visits
FROM accounts a
JOIN orders o
ON o.account_id = a.id
JOIN web_events w
ON DATE_TRUNC('day', w.occurred_at) = DATE_TRUNC('day', o.occurred_at)
GROUP BY 1
ORDER BY 1 DESC;
--but COUNT DISTINCT in the above takes forever.


--imagine we did not aggregate in the above query
SELECT o.occurred_at AS date,
		a.sales_rep_id AS active_sales_reps, 
		o.id AS orders,
		w.id AS web_visits
FROM accounts a
JOIN orders o
ON o.account_id = a.id
JOIN web_events w
ON DATE_TRUNC('day', w.occurred_at) = DATE_TRUNC('day', o.occurred_at)
ORDER BY 1 DESC;

--now let us group into sub queries
--first sub
SELECT DATE_TRUNC('day', o.occurred_at) AS date,
		COUNT (a.sales_rep_id)AS active_sales_reps, 
		COUNT (o.id) AS orders
FROM accounts a
JOIN orders o
ON o.account_id = a.id
GROUP BY 1;

--second sub
SELECT DATE_TRUNC('day', w.occurred_at) AS date,
		COUNT(w.id) AS web_visits
FROM web_events w
GROUP BY 1; 

--now to combine both subs
SELECT COALESCE(orders.date, web_events.date) AS date,
		orders.active_sales_reps,
		orders.orders,
		web_events.web_visits
FROM (SELECT DATE_TRUNC('day', o.occurred_at) AS date,
			COUNT (a.sales_rep_id)AS active_sales_reps, 
			COUNT (o.id) AS orders
		FROM accounts a
		JOIN orders o
		ON o.account_id = a.id
		GROUP BY 1) orders
FULL JOIN (SELECT DATE_TRUNC('day', w.occurred_at) AS date,
				COUNT(w.id) AS web_visits
			FROM web_events w
			GROUP BY 1) web_events
ON web_events.date = orders.date
ORDER BY 1 DESC


