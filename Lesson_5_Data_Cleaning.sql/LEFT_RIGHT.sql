/*1. In the accounts table, there is a column holding the website for each company.
The last three digits specify what type of web address they are using. A list of
extensions (and pricing) is provided here. Pull these extensions and provide how
many of each website type exist in the accounts table.*/

WITH web_name AS (SELECT website,
											RIGHT(website, 3) AS web_type
									FROM accounts)

SELECT web_type,
				COUNT (*)
FROM web_name
GROUP BY 1

/*2. There is much debate about how much the name (or even the first letter of a
company name) matters. Use the accounts table to pull the first letter of each
company name to see the distribution of company names that begin with each letter
(or number).*/

WITH comp_first AS (SELECT name,
												LEFT(name, 1) AS company_name
										FROM accounts)

SELECT company_name, COUNT(*)
FROM comp_first
GROUP BY 1
ORDER BY 1

/*ANOTHER APPROACH:*/
SELECT LEFT(UPPER(name), 1) AS first_letter, COUNT(*) num_companies
FROM accounts
GROUP BY 1
ORDER BY 2 DESC;



/*3. Use the accounts table and a CASE statement to create two groups: one group
 of company names that start with a number and a second group of those company
 names that start with a letter. What proportion of company names start with a
 letter?*/

 WITH comp_first AS (SELECT name,
 												LEFT(name, 1) AS company_name
 										FROM accounts)

 SELECT CASE WHEN company_name = '3' THEN 'number_start'
 						ELSE 'alphabet start' END AS name_group,
 						COUNT (*) AS counts
 FROM comp_first
 GROUP BY 1

 /*ANOTHER APPROACH*/
SELECT SUM(num) nums, SUM(letter) letters
FROM (SELECT name, CASE WHEN LEFT(UPPER(name), 1) IN ('0','1','2','3','4','5','6','7','8','9')
                       THEN 1 ELSE 0 END AS num,
         CASE WHEN LEFT(UPPER(name), 1) IN ('0','1','2','3','4','5','6','7','8','9')
                       THEN 0 ELSE 1 END AS letter
      FROM accounts) t1;

 /*4. Consider vowels as a, e, i, o, and u. What proportion of company names
 start with a vowel, and what percent start with anything else?*/

 WITH comp_first AS (SELECT name,
 												LEFT(name, 1) AS company_name
 										FROM accounts)

SELECT CASE WHEN company_name = 'A' THEN 'a_start'
						WHEN company_name = 'E' THEN 'e_start'
						WHEN company_name = 'e' THEN 'e_start'
						WHEN company_name = 'I' THEN 'i_start'
						WHEN company_name = 'O' THEN 'o_start'
						WHEN company_name = 'U' THEN 'u_start'
						ELSE 'consonant_start' END AS name_start,
						COUNT (*) AS accounts
FROM comp_first
GROUP BY 1
ORDER BY 2 DESC

/*ANOTHER APPROACH*/
SELECT SUM(vowels) vowels, SUM(other) other
FROM (SELECT name, CASE WHEN LEFT(UPPER(name), 1) IN ('A','E','I','O','U')
                        THEN 1 ELSE 0 END AS vowels,
          CASE WHEN LEFT(UPPER(name), 1) IN ('A','E','I','O','U')
                       THEN 0 ELSE 1 END AS other
         FROM accounts) t1;
