------------------------------------------------------------
-- Basic Exploration
------------------------------------------------------------
-- Preview first 10 rows
SELECT *
FROM SH.PROMOTIONS
FETCH FIRST 10 ROWS ONLY;

-- Count total promotions
SELECT COUNT(*) AS total_promotions
FROM SH.PROMOTIONS;

-- Count distinct promotion IDs
SELECT COUNT(DISTINCT PROMO_ID) AS distinct_promo_ids
FROM SH.PROMOTIONS;

------------------------------------------------------------
-- Profiling
------------------------------------------------------------
-- Promotions grouped by category
SELECT PROMO_CATEGORY, COUNT(*) AS promo_count
FROM SH.PROMOTIONS
GROUP BY PROMO_CATEGORY
ORDER BY promo_count DESC;

-- Promotions grouped by subcategory
SELECT PROMO_SUBCATEGORY, COUNT(*) AS promo_count
FROM SH.PROMOTIONS
GROUP BY PROMO_SUBCATEGORY
ORDER BY promo_count DESC;

------------------------------------------------------------
-- NULL Value Checks
------------------------------------------------------------
SELECT 
    SUM(CASE WHEN PROMO_NAME IS NULL THEN 1 ELSE 0 END) AS null_promo_name,
    SUM(CASE WHEN PROMO_CATEGORY IS NULL THEN 1 ELSE 0 END) AS null_promo_category,
    SUM(CASE WHEN PROMO_COST IS NULL THEN 1 ELSE 0 END) AS null_promo_cost
FROM SH.PROMOTIONS;

-- Data Cleaning (examples)
------------------------------------------------------------
-- Replace missing promotion name with 'Unknown'
UPDATE SH.PROMOTIONS
SET PROMO_NAME = 'Unknown'
WHERE PROMO_NAME IS NULL;

-- Replace missing category with 'Unclassified'
UPDATE SH.PROMOTIONS
SET PROMO_CATEGORY = 'Unclassified'
WHERE PROMO_CATEGORY IS NULL;

------------------------------------------------------------
-- Insights
------------------------------------------------------------
-- Total promotion spend by category
SELECT PROMO_CATEGORY, SUM(PROMO_COST) AS total_spend
FROM SH.PROMOTIONS
GROUP BY PROMO_CATEGORY
ORDER BY total_spend DESC;

-- Top 10 most expensive promotions
SELECT PROMO_ID, PROMO_NAME, PROMO_COST
FROM SH.PROMOTIONS
ORDER BY PROMO_COST DESC
FETCH FIRST 10 ROWS ONLY;

-- Average promotion cost by subcategory
SELECT PROMO_SUBCATEGORY, AVG(PROMO_COST) AS avg_cost
FROM SH.PROMOTIONS
GROUP BY PROMO_SUBCATEGORY
ORDER BY avg_cost DESC;

------------------------------------------------------------
-- Relationships with Fact Tables
------------------------------------------------------------
-- Sales linked to promotions
SELECT p.PROMO_NAME, SUM(s.AMOUNT_SOLD) AS total_sales
FROM SH.SALES s
JOIN SH.PROMOTIONS p ON s.PROMO_ID = p.PROMO_ID
GROUP BY p.PROMO_NAME
ORDER BY total_sales DESC;

-- Costs linked to promotions
SELECT p.PROMO_NAME, AVG(c.UNIT_COST) AS avg_cost, AVG(c.UNIT_PRICE) AS avg_price
FROM SH.COSTS c
JOIN SH.PROMOTIONS p ON c.PROMO_ID = p.PROMO_ID
GROUP BY p.PROMO_NAME
ORDER BY avg_price DESC;
