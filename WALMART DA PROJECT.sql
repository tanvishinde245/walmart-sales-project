CREATE DATABASE walmart_db;
SHOW DATABASES;
USE walmart_db;
SHOW TABLES;
SELECT COUNT(*) FROM walmart;
SELECT * FROM walmart LIMIT 10;
SELECT 
     payment_method,
     COUNT(*)
FROM walmart
GROUP BY payment_method;
SELECT COUNT(DISTINCT Branch)
FROM walmart;
SELECT MAX(quantity) FROM walmart;
SELECT * FROM walmart;

-- Business Problems
-- Q.1 Find different payment method and number of transactions, number of qty sold
SELECT 
     payment_method,
     COUNT(*) as no_of_transactions,
     SUM(quantity) as no_quant_sold
FROM walmart
GROUP BY payment_method;

-- Project Question #2
-- Identify the highest-rated category in each branch, displaying the branch, category
-- AVG RATING
SELECT *
FROM
(	
    SELECT
		branch,
		category,
		AVG(rating) as avg_rating,
		RANK() OVER (PARTITION BY branch ORDER BY AVG(rating) DESC) as r
	FROM walmart
    GROUP BY branch, category
) AS temp
WHERE r = 1

-- Project Question #3
-- Identify the busiest day for each branch based on the number of transactions.
SELECT * 
FROM
(	SELECT 
		Branch,
		DAYNAME(STR_TO_DATE(date, '%d/%m/%y')) AS day_name,
		COUNT(*) as no_of_transactions,
		RANK() OVER(PARTITION BY Branch ORDER BY COUNT(*) DESC) as r
	FROM walmart
	GROUP BY 1, 2
) AS temp
WHERE r = 1;



-- Q.5
-- Determine the average, minimum, and maximum rating of category for each city.
-- List the city, average_rating, min_rating, and max_rating.
SELECT
     City,
     Category,
     MIN(rating) as min_rating,
     MAX(rating) as max_rating,
     AVG(rating) as avg_rating
FROM walmart
GROUP BY 1, 2;	


-- Q.6  
-- Calculate the total profit for each category by considering total_profit as  
-- (unit_price * quantity * profit_margin). List category and total_profit, ordered from highest to lowest profit.
SELECT 
	 category,
     SUM( Total * profit_margin) as total_profit
FROM walmart
GROUP by 1
ORDER BY 1, 2 DESC;


-- Q.7
-- Determine the most common payment method for each branch, display branch and the preferred_payment_method.
SELECT *
FROM
(SELECT
      branch,
      payment_method,
      COUNT(*) as total_trans,
      RANK() OVER(PARTITION BY branch ORDER  BY COUNT(*) DESC) as r
FROM walmart
GROUP BY 1, 2
) as temp
WHERE r=1;


-- Q.8
-- Categorize sales into 3 groups MORNING, AFTERNOON, EVENING.
-- Find out each of the shifts and number of invoices.
SELECT 
	Branch,
    CASE 
        WHEN EXTRACT(HOUR FROM TIME(time)) < 12 THEN 'MORNING'
        WHEN EXTRACT(HOUR FROM TIME(time)) BETWEEN 12 AND 17 THEN 'AFTERNOON'
        ELSE 'EVENING'
    END AS day_time,
    COUNT(*) as total_transactions
FROM walmart
GROUP BY 1, 2
ORDER BY 1, 3 DESC;


-- Q.9
-- Identify 5 branch with highest decrease ratio in revenue compared to last year (current year 2023 and last year 2022)

-- rdr = ly_rev - cryr_rev / ly_rev * 100

SELECT *, 
   EXTRACT(YEAR FROM STR_TO_DATE(date, '%d/%m/%y')) AS year_extracted
FROM walmart;



WITH revenue_2022 AS (
    SELECT
        Branch,
        SUM(Total) AS revenue
    FROM walmart
    WHERE YEAR(STR_TO_DATE(date, '%d/%m/%y')) = 2022
    GROUP BY Branch
), 
revenue_2023 AS (
    SELECT
        Branch,
        SUM(Total) AS revenue
    FROM walmart
    WHERE YEAR(STR_TO_DATE(date, '%d/%m/%y')) = 2023
    GROUP BY Branch
)

SELECT 
     ls.branch,
     ls.revenue as last_year_rev,
     cs.revenue as current_year_rev,
     ROUND((ls.revenue - cs.revenue)/ls.revenue * 100, 2) AS rev_dec_ratio
FROM revenue_2022 AS ls
JOIN revenue_2023 AS cs
ON ls.Branch = cs.Branch
WHERE ls.revenue > cs.revenue
ORDER BY 4 DESC
LIMIT 5;
