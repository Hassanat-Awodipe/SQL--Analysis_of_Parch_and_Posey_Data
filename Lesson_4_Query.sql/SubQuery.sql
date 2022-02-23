SUB QUERY STEPS: EXAMPLE

1.) Use the test environment below to find the number of events that occur for each day for each channel.

SELECT DATE_TRUNC('day', occurred_at) AS day,
		channel,
        COUNT(*) num_of_events
FROM web_events 
GROUP BY 1,2
ORDER BY 3

2.) Now create a subquery that simply provides all of the data from your first query

SELECT *
FROM 
	(SELECT DATE_TRUNC('day', occurred_at) AS day,
		channel,
        COUNT(*) num_of_events
FROM web_events 
GROUP BY 1,2
ORDER BY 3) sub


3.) Now find the average of events for each channel. Since you broke out by day earlier, this is giving you an average per day.

SELECT channel,
	AVG(num_of_events)
FROM 
	(SELECT DATE_TRUNC('day', occurred_at) AS day,
		channel,
        COUNT(*) num_of_events
	FROM web_events 
	GROUP BY 1,2) sub
GROUP BY 1
ORDER BY 2 DESC