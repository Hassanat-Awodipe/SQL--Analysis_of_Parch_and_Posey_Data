--1.) Use DISTINCT to test if there are any accounts associated with more than one region.
--NO

SELECT DISTINCT a.name acc_name, 
		r.name region_name,
		 COUNT(r.name) num_of_regions
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id
GROUP BY acc_name, region_name
ORDER BY acc_name

--OR

SELECT DISTINCT id, name
FROM accounts;


--2.) Have any sales reps worked on more than one account?
--YES

SELECT DISTINCT s.name rep_name,
	 a.name acc_name,
     COUNT( a.name) num_acts
FROM accounts a
JOIN sales_reps s
ON a.sales_rep_id = s.id
GROUP BY rep_name, acc_name
ORDER BY rep_name

--OR

SELECT DISTINCT id, name
FROM sales_reps;
