--1.)Use DATE_TRUNC to pull month level info about the first order placed in the orders table.

SELECT DATE_TRUNC('month', MIN(occurred_at)) AS month
FROM orders



--2.) Use the result of the previous query to find only the orders that took place in the same month and year as the first
--order then pull the average for each type of paper qty in this month.

SELECT account_id,
	standard_qty,
	poster_qty,
	gloss_qty
FROM ORDERS
WHERE DATE_TRUNC('month', occurred_at) =
					(SELECT DATE_TRUNC('month', MIN(occurred_at)) AS month
						FROM orders)


--3.) Find the total amount spent on all orders on the first month that any order was placed in the orders table (in terms of usd)

SELECT AVG(standard_qty) avg_stan,
	AVG(poster_qty) avg_poster,
	AVG(gloss_qty)avg_gloss,
    	SUM(total_amt_usd)
FROM ORDERS
WHERE DATE_TRUNC('month', occurred_at) =
	(SELECT DATE_TRUNC('month', MIN(occurred_at)) AS month
	FROM orders)
