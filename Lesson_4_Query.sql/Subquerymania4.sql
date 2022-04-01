/*4.) For the customer that spent the most (in total over their lifetime as a customer)
#total_amt_usd, how many web_events did they have for each channel?

get the total_amt_usd for all customers*/
SELECT a.name acc_name,
	     SUM(o.total_amt_usd) total_sales
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY 1

--get the highest of them
SELECT a.name acc_name,
	     SUM(o.total_amt_usd) total_sales,
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1

--get all web_events for the customer
SELECT w.channel channel,
      a.name acc_name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id AND a.name = (SELECT acc_name
                                      FROM (SELECT a.name acc_name,
	                                               SUM(o.total_amt_usd) total_sales
                                            FROM orders o
                                            JOIN accounts a
                                            ON a.id = o.account_id
                                            GROUP BY 1
                                            ORDER BY 2 DESC
                                            LIMIT 1) t1
                                      )

--get the numbers of each type of web_events for the customer
SELECT w.channel channel,
      COUNT(*),
      a.name acc_name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id AND a.name = (SELECT acc_name
                                      FROM (SELECT a.name acc_name,
	                                               SUM(o.total_amt_usd) total_sales
                                            FROM orders o
                                            JOIN accounts a
                                            ON a.id = o.account_id
                                            GROUP BY 1
                                            ORDER BY 2 DESC
                                            LIMIT 1) t1
                                      )
  GROUP BY 1,3

/*5.) What is the lifetime average amount spent in terms of total_amt_usd for the
top 10 total spending accounts?*/

--get the top10 accounts in terms of total_amt_usd
SELECT a.name acc_name,
      SUM(o.total_amt_usd) total_sales
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10

--get the average
SELECT acc_name,
      AVG(total_sales) ave_sales_usd
FROM (SELECT a.name acc_name,
            SUM(o.total_amt_usd) total_sales
      FROM orders o
      JOIN accounts a
      ON a.id = o.account_id
      GROUP BY 1
      ORDER BY 2 DESC
      LIMIT 10) t1
GROUP BY 1

--this solution gave one answer for the average of all total_sales
SELECT AVG(tot_spent)
FROM (SELECT a.id, a.name, SUM(o.total_amt_usd) tot_spent
      FROM orders o
      JOIN accounts a
      ON a.id = o.account_id
      GROUP BY a.id, a.name
      ORDER BY 3 DESC
       LIMIT 10) temp;

/*6.) What is the lifetime average amount spent in terms of total_amt_usd, including
only the companies that spent more per order, on average, than the average of all
orders.*/
