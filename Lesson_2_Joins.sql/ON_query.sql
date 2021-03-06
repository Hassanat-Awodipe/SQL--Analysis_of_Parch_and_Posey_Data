/*Questions

1.) Provide a table for all web_events associated with account name of Walmart. There should be three 
columns. Be sure to include the primary_poc, time of the event, and the channel for each event. 
Additionally, you might choose to add a fourth column to assure only Walmart events were chosen.*/

SELECT primary_poc,
	occurred_at,
	channel,
	name
FROM web_events
JOIN accounts
ON accounts.id = web_events.account_id
WHERE name = 'Walmart'

/*2.) Provide a table that provides the region for each sales_rep along with their associated 
accounts. Your final table should include three columns: the region name, the sales rep name,
and the account name. Sort the accounts alphabetically (A-Z) according to account name.*/

SELECT region.name, 
	sales_rep.name,
	accounts.name
FROM region
JOIN sales_reps
ON region.id = sales_reps.region_id
JOIN accounts
ON sales_reps.region_id = accounts.sales_rep_id;


--CORRECTION
SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
ORDER BY a.name;

/*3.) Provide the name for each region for every order, as well as the account name and the unit price they 
paid (total_amt_usd/total) for the order. Your final table should have 3 columns: region name, account name, 
and unit price. A few accounts have 0 for total, so I divided by (total + 0.01) to assure not dividing by zero.*/

SELECT r.name region, 
	a.name account,
	o.total_amt_usd, 
	o.total, 			
	(total_amt_usd/(total+0.01)) unit_price
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON a.id = o.account_id;

--CORRECTION
SELECT r.name region, a.name account, 
       o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id;



