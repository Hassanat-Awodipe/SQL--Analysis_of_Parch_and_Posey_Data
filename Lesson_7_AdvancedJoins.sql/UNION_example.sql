--Example
SELECT channel,
		COUNT(*) AS sessions
FROM (
		SELECT *
		FROM web_events
	
		UNION ALL
	
		SELECT *
		FROM web_events
	 )all_events
GROUP BY 1
ORDER BY 2 DESC;

WITH all_events AS (SELECT *
				   FROM web_events
				   
				   UNION ALL
				  
					SELECT *
				   	FROM web_events)
					
SELECT channel,
		COUNT(*) AS sessions
FROM all_events
GROUP BY 1
ORDER BY 2 DESC;