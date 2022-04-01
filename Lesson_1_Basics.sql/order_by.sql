Example:
/*1.)Write a query that displays the order ID, account ID, and total dollar amount for all the orders, sorted first
by the account ID (in ascending order), and then by the total dollar amount (in descending order).*/

SELECT id,
        account_id,
        total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC, account_id;

--CORRECTION:

SELECT id,
      account_id,
      total_amt_usd
FROM orders
ORDER BY account_id, total_amt_usd DESC;


/*2.) Now write a query that again displays order ID, account ID, and total dollar amount for each order,
but this time sorted first by total dollar amount (in descending order), and then by account ID (in ascending order).*/

SELECT id,
      total_amt_usd,
      account_id
FROM orders
ORDER BY total_amt_usd DESC, account_id;

--CORRECTION:
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC, account_id;
