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

SELECT
p.product_category_name,
COUNT(distinct c.customer_unique_id)
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
join order_items oi
on o.order_id = oi.order_id 
join products p 
on oi.product_id = p.product_id 
GROUP BY p.product_category_name
HAVING COUNT(o.order_id) > 1
order by COUNT(distinct c.customer_unique_id) desc limit 3

-- ============================================================
-- 3. Lowest Repeat Customer Rates by Category
-- ============================================================

SELECT
p.product_category_name,
COUNT(distinct c.customer_unique_id)
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
join order_items oi
on o.order_id = oi.order_id 
join products p 
on oi.product_id = p.product_id 
GROUP BY p.product_category_name
HAVING COUNT(o.order_id) > 1
order by COUNT(distinct c.customer_unique_id) asc limit 3

