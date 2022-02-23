1.) Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least. Do you notice any trends in the yearly sales totals?

SELECT SUM(o.total_amt_usd) total_sale,
	DATE_PART('year', o.occurred_at) acc_year
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY DATE_PART('year', o.occurred_at) 
ORDER BY total_sale DESC 

2.) Which month did Parch & Posey have the greatest sales in terms of total dollars? Are all months evenly represented by the dataset?

SELECT SUM(o.total_amt_usd) total_sale,
	DATE_TRUNC('month', o.occurred_at) acc_month
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY DATE_TRUNC('month', o.occurred_at) 
ORDER BY total_sale DESC

#year is not indicated
SELECT SUM(o.total_amt_usd) total_sale,
	DATE_PART('month', o.occurred_at) acc_month
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY DATE_PART('month', o.occurred_at) 
ORDER BY total_sale DESC

OR

SELECT DATE_PART('month', occurred_at) ord_month, SUM(total_amt_usd) total_spent
FROM orders
WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY 1
ORDER BY 2 DESC; 

3.) Which year did Parch & Posey have the greatest sales in terms of total number of orders? Are all years evenly represented by the dataset?

SELECT SUM(o.total) total_orders,
	DATE_PART('year', o.occurred_at) acc_year
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY DATE_PART('year', o.occurred_at) 
ORDER BY total_orders DESC

OR

SELECT DATE_PART('year', occurred_at) ord_year,  COUNT(*) total_sales
FROM orders
GROUP BY 1
ORDER BY 2 DESC;

4.) Which month did Parch & Posey have the greatest sales in terms of total number of orders? Are all years evenly represented by the dataset?

SELECT SUM(o.total) total_orders,
	DATE_TRUNC('month', o.occurred_at) acc_month
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY DATE_TRUNC('month', o.occurred_at) 
ORDER BY total_orders DESC

#year is not indicated
SELECT SUM(o.total) total_orders,
	DATE_PART('month', o.occurred_at) acc_month
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY DATE_PART('month', o.occurred_at) 
ORDER BY total_orders DESC


5.) In which month of which year did Walmart spend the most on gloss paper in terms of dollars?

SELECT a.name acc_name,
	 a.id acc_id,
	SUM(o.gloss_amt_usd) total_sum_gloss,
	DATE_TRUNC('month', o.occurred_at) 
FROM orders o
JOIN accounts a 
ON a.id = o.account_id
GROUP BY 1, 2, 4
HAVING a.name = 'Walmart'
ORDER BY 3 DESC
LIMIT 1