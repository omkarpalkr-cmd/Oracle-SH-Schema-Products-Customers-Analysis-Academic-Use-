-- Basic Exploration
------------------------------------------------------------
-- Preview first 10 rows
SELECT *
FROM SH.COUNTRIES
FETCH FIRST 10 ROWS ONLY;

-- Count total countries
SELECT COUNT(*) AS total_countries
FROM SH.COUNTRIES;

-- Count distinct country IDs
SELECT COUNT(DISTINCT COUNTRY_ID) AS distinct_country_ids
FROM SH.COUNTRIES;

------------------------------------------------------------
-- NULL Value Checks
------------------------------------------------------------
SELECT
    SUM(CASE WHEN COUNTRY_NAME IS NULL THEN 1 ELSE 0 END) AS null_country_name,
    SUM(CASE WHEN COUNTRY_REGION IS NULL THEN 1 ELSE 0 END) AS null_country_region,
    SUM(CASE WHEN COUNTRY_ISO_CODE IS NULL THEN 1 ELSE 0 END) AS null_iso_code
FROM SH.COUNTRIES;

-- Data Cleaning If Data as Null Values (EXAMPLE)
------------------------------------------------------------
-- Replace missing country name with 'Unknown'
UPDATE SH.COUNTRIES
SET COUNTRY_NAME = 'Unknown'
WHERE COUNTRY_NAME IS NULL;

-- Replace missing region with 'Unclassified'
UPDATE SH.COUNTRIES
SET COUNTRY_REGION = 'Unclassified'
WHERE COUNTRY_REGION IS NULL;

------------------------------------------------------------
-- Insights
------------------------------------------------------------
-- Number of countries per region
SELECT COUNTRY_REGION, COUNT(*) AS country_count
FROM SH.COUNTRIES
GROUP BY COUNTRY_REGION
ORDER BY country_count DESC;

-- Countries grouped by subregion
SELECT COUNTRY_SUBREGION, COUNT(*) AS country_count
FROM SH.COUNTRIES
GROUP BY COUNTRY_SUBREGION
ORDER BY country_count DESC;

------------------------------------------------------------
-- Relationships with Fact Tables
------------------------------------------------------------
-- Sales by country region
SELECT co.COUNTRY_REGION, SUM(s.AMOUNT_SOLD) AS total_sales
FROM SH.SALES s
JOIN SH.CUSTOMERS cu ON s.CUST_ID = cu.CUST_ID
JOIN SH.COUNTRIES co ON cu.COUNTRY_ID = co.COUNTRY_ID
GROUP BY co.COUNTRY_REGION
ORDER BY total_sales DESC;

-- Promotions impact by country
SELECT co.COUNTRY_NAME, COUNT(DISTINCT s.PROMO_ID) AS promo_count
FROM SH.SALES s
JOIN SH.CUSTOMERS cu ON s.CUST_ID = cu.CUST_ID
JOIN SH.COUNTRIES co ON cu.COUNTRY_ID = co.COUNTRY_ID
GROUP BY co.COUNTRY_NAME
ORDER BY promo_count DESC;
