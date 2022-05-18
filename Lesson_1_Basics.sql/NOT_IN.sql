--Questions using the NOT operator

/*We can pull all of the rows that were excluded from the queries in the previous two
concepts with our new operator.

1.) Use the accounts table to find the account name, primary poc, and sales rep id for all
stores except Walmart, Target, and Nordstrom.*/

SELECT name, 
      primary_poc,
      sales_rep_id
FROM accounts
WHERE name NOT IN ('Walmart', 'Target', 'Nordstrom');

--#IN and NOT IN are used to for list. This is not the case for LIKE, NOT LIKE, =, !=

/*2.) Use the web_events table to find all information regarding individuals who were contacted
via any method except using organic or adwords methods.*/

SELECT *
FROM web_events
WHERE channel NOT IN ('organic', 'adwords');

/*3.) Use the accounts table to find:

a. All the companies whose names do not start with 'C'.*/

SELECT name
FROM accounts
WHERE name NOT LIKE 'C%';

--b. All companies whose names do not contain the string 'one' somewhere in the name.

SELECT name
FROM accounts
WHERE name NOT LIKE '%one%';

--c. All companies whose names do not end with 's'.

SELECT name
FROM accounts
WHERE name NOT LIKE '%s';

--characters in quotes are case sensitive.
