-- ============================================================
-- Olist E-Commerce Analysis
-- 13 - Revenue Concentration
-- ============================================================
-- Purpose:
-- Determine whether revenue is concentrated among a small
-- number of customers, categories, or other segments.
-- ============================================================


-- ============================================================
-- 1. Top 10 Customer Revenue Share
-- ============================================================

WITH customer_revenue AS
(
SELECT
c.customer_unique_id,
SUM(op.payment_value) AS revenue
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN order_payments op
ON o.order_id = op.order_id
GROUP BY c.customer_unique_id
)
SELECT
ROUND(100.0*SUM(revenue)/(SELECT SUM(revenue) FROM customer_revenue), 2) AS top_10_customer_revenue_share
FROM
(
SELECT revenue
FROM customer_revenue
ORDER BY revenue DESC LIMIT 10
)

-- ============================================================
-- 2. Top 100 Customer Revenue Share
-- ============================================================

WITH customer_revenue AS   
(
SELECT
c.customer_unique_id,
SUM(op.payment_value) AS revenue
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN order_payments op
ON o.order_id = op.order_id
GROUP BY c.customer_unique_id
)
SELECT
ROUND(100.0*SUM(revenue)/(SELECT SUM(revenue) FROM customer_revenue),2) AS top_100_customer_revenue_share
FROM
(
SELECT revenue
FROM customer_revenue
ORDER BY revenue DESC LIMIT 100
)

-- ============================================================
-- 3. Repeat Customer Revenue Share
-- ============================================================

WITH customer_revenue AS
(
SELECT
c.customer_unique_id,
SUM(op.payment_value) AS revenue,
COUNT(DISTINCT o.order_id) AS order_count
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN order_payments op
ON o.order_id = op.order_id
GROUP BY c.customer_unique_id
)
SELECT
ROUND(100.0*SUM(revenue)/(SELECT SUM(revenue) FROM customer_revenue),2) AS repeat_customer_revenue_share
FROM customer_revenue
WHERE order_count > 1

-- ============================================================
-- 4. Top Category Revenue Share
-- ============================================================

WITH category_revenue AS
(
SELECT
p.product_category_name,
SUM(oi.price) AS revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_category_name
)
SELECT
ROUND(100.0*SUM(revenue)/(SELECT SUM(revenue) FROM category_revenue), 2) AS top_category_revenue_share
FROM
(
SELECT revenue
FROM category_revenue
ORDER BY revenue DESC LIMIT 1
)
