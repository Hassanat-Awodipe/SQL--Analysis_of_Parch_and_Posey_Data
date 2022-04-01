--1.) Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.

--get the sum of sales for all regions with the reps name

SELECT s.name rep_name,
	r.name region_name,
	SUM(o.total_amt_usd) total_sales
FROM orders o
JOIN accounts a
ON a.id = o.account_id
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id
GROUP BY 1, 2
ORDER BY 3

--get the largest sales for each region

SELECT region_name, MAX(total_sales) max_sale_region
FROM 	(SELECT s.name rep_name,
		r.name region_name,
		SUM(o.total_amt_usd) total_sales
	FROM orders o
	JOIN accounts a
	ON a.id = o.account_id
	JOIN sales_reps s
	ON s.id = a.sales_rep_id
	JOIN region r
	ON r.id = s.region_id
	GROUP BY 1, 2 ) t1
GROUP BY 1

--get the rep name associated with each region. we have to join the two previous tables

SELECT t3.rep_name, t2.region_name, t2.max_sale_region
FROM ( SELECT region_name, MAX(total_sales) max_sale_region
	 FROM (SELECT s.name rep_name,
			r.name region_name,
			SUM(o.total_amt_usd) total_sales
		FROM orders o
		JOIN accounts a
		ON a.id = o.account_id
		JOIN sales_reps s
		ON s.id = a.sales_rep_id
		JOIN region r
		ON r.id = s.region_id
		GROUP BY 1, 2 ) t1
	GROUP BY 1) t2
JOIN (SELECT s.name rep_name,
		r.name region_name,
		SUM(o.total_amt_usd) total_sales
	FROM orders o
	JOIN accounts a
	ON a.id = o.account_id
	JOIN sales_reps s
	ON s.id = a.sales_rep_id
	JOIN region r
	ON r.id = s.region_id
	GROUP BY 1, 2
	ORDER BY 3) t3
ON t3.total_sales = t2.max_sale_region AND t3.region_name = t2.region_name



--2.) For the region with the largest sales total_amt_usd, how many total orders were placed?

#get the max sum of sales for all regions
SELECT r.name region_name,
	SUM(o.total_amt_usd) max_sum_sales
FROM orders o
JOIN accounts a
ON a.id = o.account_id
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1

--the above did not work with the subquery so we used another select function to get the max

SELECT MAX(max_sum_sales) max_sales
FROM (SELECT r.name region_name,
		SUM(o.total_amt_usd) max_sum_sales
	FROM orders o
	JOIN accounts a
	ON a.id = o.account_id
	JOIN sales_reps s
	ON s.id = a.sales_rep_id
	JOIN region r
	ON r.id = s.region_id
	GROUP BY 1) t1

--get the count of orders for the max sales
SELECT r.name region_name,
			COUNT(o.total) num_of_orders
FROM orders o
JOIN accounts a
ON a.id = o.account_id
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id
GROUP BY r.name
HAVING SUM(o.total_amt_usd) = (
															SELECT MAX(max_sum_sales) max_sales
															 FROM (SELECT r.name region_name,
																	 					SUM(o.total_amt_usd) max_sum_sales
																		FROM orders o
																		JOIN accounts a
																		ON a.id = o.account_id
																		JOIN sales_reps s
																		ON s.id = a.sales_rep_id
																		JOIN region r
																		ON r.id = s.region_id
																		GROUP BY 1) t1
															 )
