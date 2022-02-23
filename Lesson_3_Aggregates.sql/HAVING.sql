1.) How many of the sales reps have more than 5 accounts that they manage?

SELECT s.name rep_name, 
	COUNT(a.name) num_of_acc
FROM sales_reps s
JOIN accounts a
ON s.id = a.sales_rep_id
GROUP BY s.name
HAVING COUNT(a.name) > 5
ORDER BY COUNT(a.name) DESC

and technically, we can get this using a SUBQUERY as shown below. This same logic can be used for the other queries, but this will not be shown.
SELECT COUNT(*) num_reps_above5
FROM(SELECT s.id, s.name, COUNT(*) num_accounts
     FROM accounts a
     JOIN sales_reps s
     ON s.id = a.sales_rep_id
     GROUP BY s.id, s.name
     HAVING COUNT(*) > 5
     ORDER BY num_accounts) AS Table1;


2.) How many accounts have more than 20 orders?

'''SELECT DISTINCT o.account_id,
		o.total no_of_orders,
                a.name acc_name
FROM orders o
JOIN accounts a
ON a.id = o.account_id
WHERE total > 20'''

 CORRECTION:
SELECT a.id, a.name, COUNT(*) num_orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING COUNT(*) > 20
ORDER BY num_orders;

3.) Which account has the most orders?

SELECT o.account_id,
	o.total no_of_orders,
       a.name acc_name
FROM orders o
JOIN accounts a
ON a.id = o.account_id
ORDER BY total DESC
LIMIT 1

CORRECTION:

SELECT a.id, a.name, COUNT(*) num_orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY num_orders DESC
LIMIT 1;

4.) Which accounts spent more than 30,000 usd total across all orders?

'''SELECT o.total_amt_usd total_amt_usd,
        a.name acc_name
FROM orders o
JOIN accounts a
ON a.id = o.account_id
WHERE total_amt_usd > 30000
ORDER BY total_amt_usd DESC'''

OR if you consider the cost across individual orders

SELECT SUM(o.standard_amt_usd) total_standard_usd, 
	SUM(o.poster_amt_usd) total_poster_usd,
	SUM(o.gloss_amt_usd) total_gloss_usd,
        a.name acc_name
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY a.name
HAVING SUM(o.standard_amt_usd) > 30000 AND SUM(o.poster_amt_usd) > 30000 AND  SUM(o.gloss_amt_usd) > 30000  

CORRECTION:
SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING SUM(o.total_amt_usd) > 30000
ORDER BY total_spent;


5.) Which accounts spent less than 1,000 usd total across all orders?

SELECT o.total_amt_usd total_amt_usd,
        a.name acc_name
FROM orders o
JOIN accounts a
ON a.id = o.account_id
WHERE total_amt_usd < 1000
ORDER BY total_amt_usd DESC

CORRECTION:
SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent  #each account apperas more than once so you find the sum of all the total_amt_usd for a particular account
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name  #prevents the repetition of the same account id and name
HAVING SUM(o.total_amt_usd) < 1000
ORDER BY total_spent;


6.) Which account has spent the most with us?

SELECT SUM(o.total_amt_usd) total_amt_usd,
        a.name acc_name
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY a.name
ORDER BY SUM(total_amt_usd) DESC
LIMIT 1

7.) Which account has spent the least with us?

SELECT SUM(o.total_amt_usd) total_amt_usd,
        a.name acc_name
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY a.name
ORDER BY SUM(total_amt_usd) 
LIMIT 1

8.) Which accounts used facebook as a channel to contact customers more than 6 times?

SELECT COUNT(w.channel) mode_of_contact,
	a.name acc_name,
        w.account_id acc_id
FROM web_events w 
JOIN accounts a
ON w.account_id = a.id
GROUP BY w.channel, account_id, a.name 
HAVING w.channel = 'facebook' AND COUNT(w.channel) > 6
ORDER BY COUNT(w.channel) DESC

9.)Which account used facebook most as a channel?

SELECT COUNT(w.channel) mode_of_contact,
	a.name acc_name,
        w.account_id acc_id
FROM web_events w 
JOIN accounts a
ON w.account_id = a.id
GROUP BY w.channel, account_id, a.name 
HAVING w.channel = 'facebook' AND COUNT(w.channel) > 6
ORDER BY COUNT(w.channel) DESC
LIMIT 1

10.) Which channel was most frequently used by most accounts?

SELECT DISTINCT COUNT(w.channel) mode_of_contact,
		w.channel channel
FROM web_events w 
GROUP BY w.channel
ORDER BY COUNT(w.channel) DESC

Breakdown:

SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.id, a.name, w.channel
ORDER BY use_of_channel DESC
LIMIT 10;
