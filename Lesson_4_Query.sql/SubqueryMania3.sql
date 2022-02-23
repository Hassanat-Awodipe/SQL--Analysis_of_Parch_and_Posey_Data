3.) How many accounts had more total purchases than the account name which has 
bought the most standard_qty paper throughout their lifetime as a customer?

#get the sum of standard cost paper for each account
SELECT a.name acc_name,
	 SUM(standard_amt_usd) stan_cost
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY 1
ORDER BY 2 DESC

#get the account that has bought the most standard_qty paper
SELECT MAX(stan_cost) max_stan_cost
FROM (
	SELECT a.name acc_name,
	 	SUM(standard_amt_usd) stan_cost
	FROM accounts a
	JOIN orders o
	ON a.id = o.account_id
	GROUP BY 1
	) t1

#this includes the name of the acct that has bought the most standard qty paper
SELECT acc_name, MAX(stan_cost) max_stan_cost
FROM (
	SELECT a.name acc_name,
	 	SUM(standard_amt_usd) stan_cost
	FROM accounts a
	JOIN orders o
	ON a.id = o.account_id
	GROUP BY 1
	) t1
GROUP BY 1 
ORDER BY 2 DESC
LIMIT 1

#get the total purchases for all accounts
SELECT a.name acc_name,
	 SUM(o.total_amt_usd) total_cost
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY 1
ORDER BY 2 DESC

#finally
SELECT acc_name, COUNT(total_cost)
FROM (SELECT a.name acc_name,
	 	SUM(o.total_amt_usd) total_cost
	FROM accounts a
	JOIN orders o
	ON a.id = o.account_id
	GROUP BY 1) t2
GROUP BY acc_name
HAVING total_cost > (SELECT MAX(stan_cost) max_stan_cost
			  FROM (SELECT a.name acc_name,
	 			         SUM(standard_amt_usd) stan_cost
				 FROM accounts a
	                	 JOIN orders o
				ON a.id = o.account_id
				GROUP BY 1 ) t1 )

#get the account that has bought the most standard_qty paper in terms of qty
SELECT a.name acc_name,
	standard_qty stan_qty,
	 SUM(standard_amt_usd) stan_cost
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY 1,2
ORDER BY 3 DESC

#get the highest standard qty paper bought
SELECT MAX(stan_qty)
FROM (SELECT a.name acc_name,
		standard_qty stan_qty,
	 	SUM(standard_amt_usd) stan_cost
	FROM accounts a
	JOIN orders o
	ON a.id = o.account_id
	GROUP BY 1,2
     ) t1

#get the accounts whose total qty of the three types of paper bought exceeds the highest qty of standard paper bought.
SELECT a.name acc_name,
	SUM(o.total) total_orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY 1
HAVING SUM(o.total)  > (SELECT MAX(stan_qty)
				FROM (SELECT a.name acc_name,
					 	standard_qty stan_qty,
	 				 	SUM(standard_amt_usd) stan_cost
					FROM accounts a
					JOIN orders o
					ON a.id = o.account_id
					GROUP BY 1,2) t1
				);

