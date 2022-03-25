/*Example
Imagine you want to know which accounts made multiple orders within 30days
we join two same tables

SELECT o1.id AS o1_id,
		o1.account_id AS o1_account_id,
		o1.occurred_at AS o1_occurred_at,
		o2.id AS o2_id,
		o2.account_id AS o2_account_id,
		o2.occurred_at AS o2_occurred_at
FROM orders o1
LEFT JOIN orders o2
	ON o1.account_id = o2.account_id
	AND	o2.occurred_at > o1.occurred_at
	AND o2.occurred_at <= o1.occurred_at + INTERVAL '28 days'
ORDER BY o1.account_id, o1.occurred_at
*/

SELECT w1.id AS w1_id,
       w1.account_id AS w1_account_id,
       w1.occurred_at AS w1_occurred_at,
	   w1.channel AS w1_channel,
	   w2.id AS w2_id,
       w2.account_id AS w2_account_id,
       w2.occurred_at AS w2_occurred_at,
	   w2.channel AS w2_channel
FROM web_events w1
LEFT JOIN web_events w2
	ON w1.account_id = w2.account_id
  AND w1.occurred_at > w2.occurred_at
  AND w1.occurred_at <= w2.occurred_at + INTERVAL '1 day'
ORDER BY w1.account_id, w1.occurred_at
	   