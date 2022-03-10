--Example


SELECT standard_qty,
		SUM(standard_qty) OVER (ORDER BY occurred_at) AS running_total
FROM orders


SELECT standard_qty,
		DATE_TRUNC('month', occurred_at) AS month,
		SUM(standard_qty) OVER (ORDER BY occurred_at) AS running_total
FROM orders


SELECT standard_qty,
		DATE_TRUNC('month', occurred_at) AS month,
		SUM(standard_qty) OVER (PARTITION BY DATE_TRUNC('month', occurred_at) ORDER BY occurred_at) AS running_total
FROM orders


SELECT standard_qty,
		DATE_TRUNC('month', occurred_at) AS month,
		SUM(standard_qty) OVER (PARTITION BY DATE_TRUNC('month', occurred_at)) AS running_total
FROM orders