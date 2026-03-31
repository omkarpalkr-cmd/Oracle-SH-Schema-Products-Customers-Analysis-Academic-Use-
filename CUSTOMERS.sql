
-- Basic Exploration
------------------------------------------------------------
-- Preview first 10 rows
SELECT *
FROM SH.CUSTOMERS
FETCH FIRST 10 ROWS ONLY;

-- Count total customers
SELECT COUNT(*) AS total_customers
FROM SH.CUSTOMERS;

-- Count distinct customer IDs
SELECT COUNT(DISTINCT CUST_ID) AS distinct_customer_ids
FROM SH.CUSTOMERS;

-- Profiling
------------------------------------------------------------
-- Customers grouped by marital status
SELECT CUST_MARITAL_STATUS, COUNT(*) AS customer_count
FROM SH.CUSTOMERS
GROUP BY CUST_MARITAL_STATUS
ORDER BY customer_count DESC;

-- Customers grouped by income level
SELECT CUST_INCOME_LEVEL, COUNT(*) AS customer_count
FROM SH.CUSTOMERS
GROUP BY CUST_INCOME_LEVEL
ORDER BY customer_count DESC;

-- NULL Value Checks
SELECT 
    SUM(CASE WHEN CUST_FIRST_NAME IS NULL THEN 1 ELSE 0 END) AS null_first_name,
    SUM(CASE WHEN CUST_LAST_NAME IS NULL THEN 1 ELSE 0 END) AS null_last_name,
    SUM(CASE WHEN CUST_EMAIL IS NULL THEN 1 ELSE 0 END) AS null_email,
    SUM(CASE WHEN CUST_INCOME_LEVEL IS NULL THEN 1 ELSE 0 END) AS null_income_level
FROM SH.CUSTOMERS;

-- Replace missing income level with 'Unknown'
UPDATE SH.CUSTOMERS
SET CUST_INCOME_LEVEL = 'Unknown'
WHERE CUST_INCOME_LEVEL IS NULL;

-- Insights
------------------------------------------------------------
--Distribution by Gender
SELECT CUST_GENDER, COUNT(*) AS customer_count
FROM SH.CUSTOMERS
GROUP BY CUST_GENDER
ORDER BY customer_count DESC;

-- Age Segmentation
SELECT 
    FLOOR((EXTRACT(YEAR FROM SYSDATE) - CUST_YEAR_OF_BIRTH)/10)*10 AS age_group,
    COUNT(*) AS customer_count
FROM SH.CUSTOMERS
GROUP BY FLOOR((EXTRACT(YEAR FROM SYSDATE) - CUST_YEAR_OF_BIRTH)/10)*10
ORDER BY age_group;

-- Average credit limit by income level
SELECT CUST_INCOME_LEVEL, AVG(CUST_CREDIT_LIMIT) AS avg_credit_limit
FROM SH.CUSTOMERS
GROUP BY CUST_INCOME_LEVEL
ORDER BY avg_credit_limit DESC;

-- Top 10 customers with highest credit limit
SELECT CUST_ID, CUST_FIRST_NAME, CUST_LAST_NAME, CUST_CREDIT_LIMIT
FROM SH.CUSTOMERS
ORDER BY CUST_CREDIT_LIMIT DESC
FETCH FIRST 10 ROWS ONLY;

------------------------------------------------------------
-- Relationships with Tables
------------------------------------------------------------
-- Sales by customer income level
SELECT c.CUST_INCOME_LEVEL, SUM(s.AMOUNT_SOLD) AS total_sales
FROM SH.SALES s
JOIN SH.CUSTOMERS c ON s.CUST_ID = c.CUST_ID
GROUP BY c.CUST_INCOME_LEVEL
ORDER BY total_sales DESC;

-- Customers by Country
SELECT co.COUNTRY_NAME, COUNT(*) AS customer_count
FROM SH.CUSTOMERS cu
JOIN SH.COUNTRIES co ON cu.COUNTRY_ID = co.COUNTRY_ID
GROUP BY co.COUNTRY_NAME
ORDER BY customer_count DESC;

-- Spending by Age Group
SELECT 
    FLOOR((EXTRACT(YEAR FROM SYSDATE) - cu.CUST_YEAR_OF_BIRTH)/10)*10 AS age_group,
    SUM(s.AMOUNT_SOLD) AS total_spent
FROM SH.SALES s
JOIN SH.CUSTOMERS cu ON s.CUST_ID = cu.CUST_ID
GROUP BY FLOOR((EXTRACT(YEAR FROM SYSDATE) - cu.CUST_YEAR_OF_BIRTH)/10)*10
ORDER BY age_group;


