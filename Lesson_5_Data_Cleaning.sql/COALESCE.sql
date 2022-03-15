--Example

SELECT primary_poc,
        COALESCE(primary_poc, 'no_poc') AS primary_poc_modified
FROM demo.accounts
WHERE primary_poc IS NULL


--2.
SELECT *, COALESCE(a.id, '1') AS id_modified
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;


SELECT *, COALESCE(o.account_id, '1') AS id_modified
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;


SELECT *,
		COALESCE(o.standard_amt_usd, 0) AS std_amt_modified,
		COALESCE(o.gloss_amt_usd, 0) AS gloss_amt_modified,
        COALESCE(o.poster_amt_usd, 0) AS poster_amt_modified,
        COALESCE(o.standard_qty, 0) AS std_qty_modified,
		COALESCE(o.gloss_qty, 0) 		AS gloss_qty_modified,
        COALESCE(o.poster_qty, 0) AS poster_qty_modified
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;
