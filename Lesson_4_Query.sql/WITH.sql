/*1. Provide the name of the sales_rep in each region with the largest amount of
total_amt_usd sales.*/

WITH rep_region_sales AS (
                  SELECT s.name rep_name, r.name region_name, SUM(total_amt_usd) total_sales
                  FROM orders o
                  JOIN accounts a
                  ON o.account_id = a.id
                  JOIN sales_reps s
                  ON s.id = a.sales_rep_id
                  JOIN region r
                  ON r.id = s.region_id
                  GROUP BY 1, 2
                  ORDER BY 1 DESC ),

      region_sales AS (
                SELECT region_name, MAX(total_sales) max_sales
                FROM rep_region_sales
                GROUP BY 1)

SELECT rep_region_sales.rep_name salesperson, region_sales.region_name regions, region_sales.max_sales max_sale
FROM rep_region_sales
JOIN region_sales
ON rep_region_sales.region_name = region_sales.region_name AND rep_region_sales.total_sales = region_sales.max_sales

/*2. For the region with the largest sales total_amt_usd, how many total orders were placed?*/

SELECT s.name rep_name, r.name region_name, SUM(total_amt_usd) total_sales
FROM orders o
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id
GROUP BY 1, 2
ORDER BY 1 DESC ),
