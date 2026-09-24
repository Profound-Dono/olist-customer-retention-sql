-- ============================================================
-- Olist E-Commerce Analysis
-- 07 - Category Analysis
-- ============================================================
-- Purpose:
-- Analyze customer behavior and revenue across product
-- categories.
-- ============================================================


-- ============================================================
-- 1. Customers by Product Category
-- ============================================================
-- Which product categories have the most unique customers?

SELECT
p.product_category_name AS categories,
count(c.customer_unique_id) AS customers
FROM products p
JOIN order_items oi 
ON p.product_id = oi.product_id
JOIN orders o
ON o.order_id = oi.order_id 
JOIN customers c
ON o.customer_id = c.customer_id 
GROUP BY p.product_category_name
ORDER BY COUNT(c.customer_unique_id) desc


-- ============================================================
-- 2. Repeat Customer Rate by Category
-- ============================================================
-- Which categories have the highest repeat customer rates?



-- ============================================================
-- 3. Lowest Repeat Customer Rates by Category
-- ============================================================
-- Which categories have the lowest repeat customer rates?



-- ============================================================
-- 4. Repeat-Customer Revenue by Category
-- ============================================================
-- Which product categories generate the most revenue from
-- customers classified as repeat customers?


