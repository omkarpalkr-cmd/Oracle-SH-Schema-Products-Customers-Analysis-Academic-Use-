# Oracle SH Schema – Products & Customers Analysis

This repository contains SQL scripts for analyzing the Oracle Sales History (SH) schema.  
It focuses on **PRODUCTS** and **CUSTOMERS** tables, showcasing how to explore, clean, and derive insights using Oracle SQL.

## Features

### PRODUCTS
- Basic exploration: preview rows, counts, distinct IDs
- Profiling: products grouped by category and subcategory
- Null value checks for product attributes
- Insights:
  - Average price per category
  - Top 10 most expensive products
  - Price gap analysis (list vs minimum price)
- Relationships:
  - Sales by product category
  - Average unit cost vs unit price by product

### CUSTOMERS
- Basic exploration: preview rows, counts, distinct IDs
- Profiling: customers grouped by marital status and income level
- Null value checks for customer attributes
- Insights:
  - Distribution by gender
  - Age segmentation
  - Average credit limit by income level
  - Top 10 customers by credit limit
- Relationships:
  - Sales by customer income level
  - Customers by country
  - Spending by age group

## Example Query

```sql
-- Sales by customer income level
SELECT c.CUST_INCOME_LEVEL, SUM(s.AMOUNT_SOLD) AS total_sales
FROM SH.SALES s
JOIN SH.CUSTOMERS c ON s.CUST_ID = c.CUST_ID
GROUP BY c.CUST_INCOME_LEVEL
ORDER BY total_sales DESC;
