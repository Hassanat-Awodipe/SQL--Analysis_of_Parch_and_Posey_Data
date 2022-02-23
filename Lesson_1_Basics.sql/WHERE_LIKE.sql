#1.) Questions using the LIKE operator

#Use the accounts table to find

#a. All the companies whose names start with 'C'.

SELECT name
FROM accounts
WHERE name LIKE 'C%';

#b. All companies whose names contain the string 'one' somewhere in the name.

SELECT name
FROM accounts
WHERE name LIKE '%one%';

#c. All companies whose names end with 's'.

SELECT name
FROM accounts
WHERE name LIKE '%s';