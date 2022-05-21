--1.) For each account, determine the average amount of each type of paper they purchased across their orders. Your result should have four columns - one for the account name and one for the average quantity purchased for each of the paper types for each account.

SELECT a.name, 
	AVG(standard_qty) ave_stan, 
	AVG(poster_qty) ave_poster,
	AVG(gloss_qty) ave_gloss
FROM accounts a
JOIN orders o
ON o.account_id = a.id
GROUP BY a.name

--2.) For each account, determine the average amount spent per order on each paper type. Your result should have four columns - one for the account name and one for the average amount spent on each paper type.

SELECT a.name, 
	AVG(standard_amt_usd) ave_stan, 
	AVG(poster_amt_usd) ave_poster,
	AVG(gloss_amt_usd) ave_gloss
FROM accounts a
JOIN orders o
ON o.account_id = a.id
GROUP BY a.name

--3.) Determine the number of times a particular channel was used in the web_events table for each sales rep. Your final table should have three columns - the name of the sales rep, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.

SELECT s.name,
	w.channel,
	COUNT(channel) num_of_occu
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.name, w.channel
ORDER BY num_of_occu DESC

--4.) Determine the number of times a particular channel was used in the web_events table for each region. Your final table should have three columns - the region name, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.

SELECT r.name,
	w.channel,
	COUNT(channel) num_of_occu  #COUNT(channel) can be written as COUNT(*)
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON s.region_id = r.id
GROUP BY r.name, w.channel
ORDER BY num_of_occu DESC
