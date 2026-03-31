-- Basic Exploration
------------------------------------------------------------
-- Preview first 10 rows
SELECT *
FROM SH.PRODUCTS
FETCH FIRST 10 ROWS ONLY;

-- Count total products
SELECT COUNT(*) AS total_products
FROM SH.PRODUCTS;

-- Count distinct product IDs
SELECT COUNT(DISTINCT PROD_ID) AS distinct_product_ids
FROM SH.PRODUCTS;


-- Products grouped by category
SELECT PROD_CATEGORY, COUNT(*) AS product_count
FROM SH.PRODUCTS
GROUP BY PROD_CATEGORY
ORDER BY product_count DESC;

-- Products grouped by subcategory
SELECT PROD_SUBCATEGORY, COUNT(*) AS product_count
FROM SH.PRODUCTS
GROUP BY PROD_SUBCATEGORY
ORDER BY product_count DESC;


-- Check for missing values in key columns
SELECT 
    SUM(CASE WHEN PROD_NAME IS NULL THEN 1 ELSE 0 END) AS null_prod_name,
    SUM(CASE WHEN PROD_CATEGORY IS NULL THEN 1 ELSE 0 END) AS null_prod_category,
    SUM(CASE WHEN PROD_LIST_PRICE IS NULL THEN 1 ELSE 0 END) AS null_list_price,
    SUM(CASE WHEN PROD_STATUS IS NULL THEN 1 ELSE 0 END) AS null_prod_status
FROM SH.PRODUCTS;


-- Insights
------------------------------------------------------------
-- Average price per category
SELECT PROD_CATEGORY, AVG(PROD_LIST_PRICE) AS avg_price
FROM SH.PRODUCTS
GROUP BY PROD_CATEGORY
ORDER BY avg_price DESC;

-- Top 10 most expensive products
SELECT PROD_ID, PROD_NAME, PROD_LIST_PRICE
FROM SH.PRODUCTS
ORDER BY PROD_LIST_PRICE DESC
FETCH FIRST 10 ROWS ONLY;

-- Products with largest gap between list price and minimum price
SELECT PROD_ID, PROD_NAME, PROD_LIST_PRICE, PROD_MIN_PRICE,
       (PROD_LIST_PRICE - PROD_MIN_PRICE) AS price_gap
FROM SH.PRODUCTS
ORDER BY price_gap DESC
FETCH FIRST 10 ROWS ONLY;

-- Relationships with Tables
------------------------------------------------------------
-- Sales by product category
SELECT p.PROD_CATEGORY, SUM(s.AMOUNT_SOLD) AS total_sales
FROM SH.SALES s
JOIN SH.PRODUCTS p ON s.PROD_ID = p.PROD_ID
GROUP BY p.PROD_CATEGORY
ORDER BY total_sales DESC;

-- Average unit cost vs unit price by product
SELECT p.PROD_NAME, AVG(c.UNIT_COST) AS avg_cost, AVG(c.UNIT_PRICE) AS avg_price
FROM SH.COSTS c
JOIN SH.PRODUCTS p ON c.PROD_ID = p.PROD_ID
GROUP BY p.PROD_NAME
ORDER BY avg_price DESC;
