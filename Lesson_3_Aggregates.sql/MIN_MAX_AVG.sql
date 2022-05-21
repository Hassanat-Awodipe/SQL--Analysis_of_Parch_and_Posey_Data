--1.) When was the earliest order ever placed? You only need to return the date

SELECT MIN(occurred_at)
FROM orders

--2.) Try performing the same query as in question 1 without using an aggregation function.

SELECT occurred_at
FROM orders
ORDER BY occurred_at
LIMIT 1;

--3.) When did the most recent (latest) web_event occur?

SELECT MAX(occurred_at)
FROM web_event

--4.) Try to perform the result of the previous query without using an aggregation function.

SELECT occurred_at
FROM web_event
ORDER BY occurred_at DESC
LIMIT 1;

--5.) Find the mean (AVERAGE) amount spent per order on each paper type, as well as the mean amount of each paper type purchased per order. Your final answer should have 6 values - one for each paper type for the average number of sales, as well as the average amount.

SELECT AVG(standard_qty) avg_stan, 
	AVG(poster_qty) avg_poster,
	AVG(gloss_qty) avg_gloss,
	AVG(standard_amt_usd) avg_stan_amt,
	AVG(gloss_amt_usd) avg_gloss_amt,
	AVG(poster_amt_usd) avg_poster_amt
FROM ORDERS

--6.) Via the video, you might be interested in how to calculate the MEDIAN. Though this is more advanced than what we have covered so far try finding - what is the MEDIAN total_usd spent on all orders? Note, this is more advanced than the topics we have covered thus far to build a general solution, but we can hard code a solution in the following way.

SELECT total_amt_usd
FROM orders
ORDER BY total_amt_usd

--CORRECTION:
SELECT *
FROM (SELECT total_amt_usd
      FROM orders
      ORDER BY total_amt_usd
      LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;
