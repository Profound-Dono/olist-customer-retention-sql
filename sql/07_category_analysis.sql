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
p.product_category_name,
COUNT(DISTINCT c.customer_unique_id) AS unique_customers
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
JOIN orders o
ON oi.order_id = o.order_id
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY p.product_category_name
ORDER BY unique_customers DESC


-- ============================================================
-- 2. Repeat Customer Rate by Category
-- ============================================================

WITH category_customers AS
(
SELECT
DISTINCT
p.product_category_name,
c.customer_unique_id
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
JOIN orders o
ON oi.order_id = o.order_id
JOIN customers c
ON o.customer_id = c.customer_id
),
customer_order_counts AS
(
SELECT
c.customer_unique_id,
COUNT(o.order_id) AS order_count
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.customer_unique_id
)

SELECT
cc.product_category_name,
COUNT(*) AS customers,
COUNT(*) FILTER (WHERE coc.order_count > 1) AS repeat_customers,
ROUND(100.0*COUNT(*) FILTER (WHERE coc.order_count > 1)/COUNT(*), 2) AS repeat_customer_rate
FROM category_customers cc
JOIN customer_order_counts coc
ON cc.customer_unique_id = coc.customer_unique_id
GROUP BY cc.product_category_name
ORDER BY repeat_customer_rate DESC

-- ============================================================
-- 3. Lowest Repeat Customer Rates by Category
-- ============================================================

WITH category_customers AS
(
SELECT
DISTINCT
p.product_category_name,
c.customer_unique_id
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
JOIN orders o
ON oi.order_id = o.order_id
JOIN customers c
ON o.customer_id = c.customer_id
),
customer_order_counts AS
(
SELECT
c.customer_unique_id,
COUNT(o.order_id) AS order_count
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.customer_unique_id
)
SELECT
cc.product_category_name,
ROUND(100.0*COUNT(*) FILTER (WHERE coc.order_count > 1)/COUNT(*),2) AS repeat_customer_rate
FROM category_customers cc
JOIN customer_order_counts coc
ON cc.customer_unique_id = coc.customer_unique_id
GROUP BY cc.product_category_name
ORDER BY repeat_customer_rate ASC
LIMIT 3

