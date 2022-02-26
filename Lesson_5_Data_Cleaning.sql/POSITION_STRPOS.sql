/*Example: Code to seperate city from state*/

SELECT first_name,
       last_name,
       city_state,
       POSITION(',' IN city_state) AS comma_position,
       STRPOS(city_state, ',') AS substr_comma_position,
       LOWER(city_state) AS lowercase,
       UPPER(city_state) AS uppercase,
       LEFT(city_state, POSITION(',' IN city_state)) AS city_state
FROM demo.customer_data

/*QUIZ
1. Use the accounts table to create first and last name columns that hold the first
and last names for the primary_poc.*/
/*table for first name*/
SELECT primary_poc,
            	     POSITION(' ' IN primary_poc) AS space_position,
                   LEFT(primary_poc,  POSITION(' ' IN primary_poc)) AS first_name
FROM accounts

/*get positon for last_name*/
SELECT primary_poc as name,
      STRPOS(primary_poc, ' ') space_pos,
      LEFT(primary_poc, STRPOS(primary_poc, ' ')- 1) AS first_name, /*pulls 7-1 characters from the left*/
      RIGHT(primary_poc, (LENGTH(primary_poc) - STRPOS(primary_poc, ' ')))  AS last_name  /*pulls the (length of primary_poc-7) from the right*/
FROM accounts

/*Now see if you can do the same thing for every rep name in the sales_reps table.
Again provide first and last name columns.*/

SELECT name,
	LEFT(name, STRPOS(name, ' ')) AS first_name,
    RIGHT(name, (LENGTH(name) - STRPOS(name, ' '))) AS last_name
FROM sales_reps
