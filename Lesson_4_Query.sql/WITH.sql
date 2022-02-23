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

/* find the region with the largest sales*/
WITH region_max AS (
          SELECT r.name region_name, SUM(o.total_amt_usd) total_sales
          FROM orders o
          JOIN accounts a
          ON o.account_id = a.id
          JOIN sales_reps s
          ON s.id = a.sales_rep_id
          JOIN region r
          ON r.id = s.region_id
          GROUP BY 1
          ORDER BY 2 DESC
          LIMIT 1)

/* find the count of total orders. join tables with the region name. use having to get the largest sales*/
  SELECT r.name, region_max.total_sales, COUNT(o.total)
  FROM orders o
  JOIN accounts a
  ON o.account_id = a.id
  JOIN sales_reps s
  ON s.id = a.sales_rep_id
  JOIN region r
  ON r.id = s.region_id
  JOIN region_max
  ON region_max.region_name = r.name
  GROUP BY 1,2
  HAVING region_max.total_sales = SUM(o.total_amt_usd);


/*3.) How many accounts had more total purchases than the account name which has
bought the most standard_qty paper throughout their lifetime as a customer?*/

 /*table for the account which bought the most standard_qty paper*/
WITH stan_cost AS (
            SELECT a.name acc_name, SUM(standard_qty), SUM(o.total) num_of_orders
            FROM accounts a
            JOIN orders o
            ON o.account_id = a.id
            GROUP BY 1
            ORDER BY 2 DESC
            LIMIT 1),

/*table for all accounts*/
orders_num AS (
            SELECT a.name acc_name
            FROM accounts a
            JOIN orders o
            ON o.account_id = a.id
            GROUP BY 1
            HAVING SUM(o.total) > (SELECT num_of_orders FROM stan_cost) )

SELECT COUNT(*)
FROM orders_num

/*4. For the customer that spent the most (in total over their lifetime as a customer)
 total_amt_usd, how many web_events did they have for each channel?*/

/*get the high total_amt_usd*/

 WITH high_total AS (
           SELECT a.name acc_name, SUM(total_amt_usd) total_sales
           FROM accounts a
           JOIN orders o
           ON o.account_id = a.id
           JOIN web_events w
           ON w.account_id = a.id
           GROUP BY 1
           ORDER BY 2 DESC
           LIMIT 1 )
/*get the channel and the account name*/
 SELECT high_total.acc_name, w.channel, COUNT(*)
 FROM web_events w
 JOIN accounts a
 ON w.account_id = a.id
 JOIN high_total
 ON high_total.acc_name = a.name
 GROUP BY 1,2


/*What is the lifetime average amount spent in terms of total_amt_usd for the
top 10 total spending accounts?*/

/*get the top 10 spending accounts*/
WITH sales AS (SELECT a.name acc_name, SUM(total_amt_usd) total_sales
              FROM accounts a
              JOIN orders o
              ON o.account_id = a.id
              GROUP BY 1
              ORDER BY 2 DESC
              LIMIT 10 )

SELECT AVG(total_sales)
FROM sales

/*get the average*/
