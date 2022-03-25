--Write a query that uses UNION ALL on two instances (and selecting all columns) of the accounts table.

SELECT *
FROM accounts

UNION ALL

SELECT *
FROM accounts;
--------------------------------------------

SELECT *
FROM accounts
WHERE name = 'Walmart'

UNION

SELECT *
FROM accounts
WHERE name = 'Disney';

/*Perform the union in your first query (under the Appending Data via UNION header) in a common table expression and 
name it double_accounts. Then do a COUNT the number of times a name appears in the double_accounts table. If you do 
this correctly, your query results should have a count of 2 for each name.*/

WITH double_accounts AS (SELECT *
						FROM accounts

						UNION ALL

						SELECT *
						FROM accounts
						)

SELECT name,
		COUNT(*)
FROM double_accounts
GROUP BY 1
ORDER BY 2 DESC;
