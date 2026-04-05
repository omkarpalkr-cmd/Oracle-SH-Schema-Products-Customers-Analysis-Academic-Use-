
-- Basic Exploration
------------------------------------------------------------
-- Preview first 10 rows
SELECT *
FROM SH.CHANNELS
FETCH FIRST 10 ROWS ONLY;

-- Count total channels
SELECT COUNT(*) AS total_channels
FROM SH.CHANNELS;

-- Count distinct channel IDs
SELECT COUNT(DISTINCT CHANNEL_ID) AS distinct_channel_ids
FROM SH.CHANNELS;

------------------------------------------------------------
--  Profiling
------------------------------------------------------------
-- Channels grouped by class
SELECT CHANNEL_CLASS, COUNT(*) AS channel_count
FROM SH.CHANNELS
GROUP BY CHANNEL_CLASS
ORDER BY channel_count DESC;

-- Channels grouped by description
SELECT CHANNEL_DESC, COUNT(*) AS channel_count
FROM SH.CHANNELS
GROUP BY CHANNEL_DESC
ORDER BY channel_count DESC;

-- NULL Value Checks
------------------------------------------------------------
SELECT 
    SUM(CASE WHEN CHANNEL_DESC IS NULL THEN 1 ELSE 0 END) AS null_channel_desc,
    SUM(CASE WHEN CHANNEL_CLASS IS NULL THEN 1 ELSE 0 END) AS null_channel_class
FROM SH.CHANNELS;

-- Data Cleaning(IF NULL VALUES)
------------------------------------------------------------
-- Replace missing channel description with 'Unknown'
UPDATE SH.CHANNELS
SET CHANNEL_DESC = 'Unknown'
WHERE CHANNEL_DESC IS NULL;

-- Replace missing channel class with 'Unclassified'
UPDATE SH.CHANNELS
SET CHANNEL_CLASS = 'Unclassified'
WHERE CHANNEL_CLASS IS NULL;

------------------------------------------------------------
-- Insights
------------------------------------------------------------
-- Sales by channel
SELECT ch.CHANNEL_DESC, SUM(s.AMOUNT_SOLD) AS total_sales
FROM SH.SALES s
JOIN SH.CHANNELS ch ON s.CHANNEL_ID = ch.CHANNEL_ID
GROUP BY ch.CHANNEL_DESC
ORDER BY total_sales DESC;

-- Average unit price by channel
SELECT ch.CHANNEL_DESC, AVG(co.UNIT_PRICE) AS avg_unit_price
FROM SH.COSTS co
JOIN SH.CHANNELS ch ON co.CHANNEL_ID = ch.CHANNEL_ID
GROUP BY ch.CHANNEL_DESC
ORDER BY avg_unit_price DESC;

--  Relationships
------------------------------------------------------------
-- Channels linked to promotions
SELECT ch.CHANNEL_DESC, COUNT(DISTINCT s.PROMO_ID) AS promo_count
FROM SH.SALES s
JOIN SH.CHANNELS ch ON s.CHANNEL_ID = ch.CHANNEL_ID
GROUP BY ch.CHANNEL_DESC
ORDER BY promo_count DESC;
