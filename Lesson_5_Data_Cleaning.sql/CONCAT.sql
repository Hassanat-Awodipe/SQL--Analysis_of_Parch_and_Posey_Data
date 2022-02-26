/*Example:*/

SELECT first_name,
      last_name,
      CONCAT(first_name, ' ', last_name) AS full_name,
      first_name || ' ' || last_name AS full_name_alt
FROM demo_customer_data



/*1. Each company in the accounts table wants to create an email address for each
primary_poc. The email address should be the first name of the primary_poc . last name primary_poc @ company name .com.*/

SELECT name,
      primary_poc,
      CONCAT(LOWER(primary_poc),'@',LOWER(name),'.com')
FROM accounts

/*first_name.last_name@company_name.com*/
SELECT name, primary_poc,
      STRPOS(primary_poc, ' ') space_pos,
      LEFT(primary_poc, STRPOS(primary_poc, ' ')- 1) AS first_name, /*pulls 7-1 characters from the left*/
      RIGHT(primary_poc, (LENGTH(primary_poc) - STRPOS(primary_poc, ' ')))  AS last_name,  /*pulls the (length of primary_poc-7) from the right*/
   LEFT(primary_poc, STRPOS(primary_poc, ' ')- 1)|| '.' ||RIGHT(primary_poc, (LENGTH(primary_poc) - STRPOS(primary_poc, ' ')))||'@' || name || '.com'
FROM accounts
/*SELECT translate('12 34 5', ' ', '')
SELECT TRANSLATE('tamara tuma@walmart.com', ' ', '')*/

/*2. You may have noticed that in the previous solution some of the company names
 include spaces, which will certainly not work in an email address. See if you
 can create an email address that will work by removing all of the spaces in the
  account name, but otherwise your solution should be just as in question 1. */

SELECT name,
      primary_poc,
      TRANSLATE(CONCAT(LOWER(primary_poc),'@',LOWER(name),'.com'), ' ', '') AS email
FROM accounts

/*3. We would also like to create an initial password, which they will change
after their first log in. The first password will be the first letter of the
primary_poc's first name (lowercase), then the last letter of their first name
(lowercase), the first letter of their last name (lowercase), the last letter
of their last name (lowercase), the number of letters in their first name,
the number of letters in their last name, and then the name of the company
they are working with, all capitalized with no spaces

TAMARA TUMA
password = tata64WALMART

getting the characters for the password
SELECT primary_poc,
      LEFT(LOWER(primary_poc), 1) AS first_firstname,
      RIGHT (LEFT(primary_poc, STRPOS(primary_poc, ' ') - 1), 1) AS last_firstname,
      RIGHT (LEFT(LOWER(primary_poc), STRPOS(primary_poc, ' ') + 1), 1) AS first_lastname,
      RIGHT (primary_poc, 1) AS last_lastname,
      LENGTH(LEFT(primary_poc, STRPOS(primary_poc, ' ')- 1)) AS length_firstname,
      LENGTH(RIGHT(primary_poc, (LENGTH(primary_poc) - STRPOS(primary_poc, ' ')))) AS length_lastname,
 		TRANSLATE(UPPER(name), ' ', '') AS company_name
FROM accounts
*/


SELECT primary_poc, CONCAT(
      LEFT(LOWER(primary_poc), 1),
      RIGHT (LEFT(primary_poc, STRPOS(primary_poc, ' ') - 1), 1),
      RIGHT (LEFT(LOWER(primary_poc), STRPOS(primary_poc, ' ') + 1), 1),
      RIGHT (primary_poc, 1),
      LENGTH(LEFT(primary_poc, STRPOS(primary_poc, ' ')- 1)),
       LENGTH(RIGHT(primary_poc, (LENGTH(primary_poc) - STRPOS(primary_poc, ' ')))),
 		TRANSLATE(UPPER(name), ' ', ''))  AS password
FROM accounts
