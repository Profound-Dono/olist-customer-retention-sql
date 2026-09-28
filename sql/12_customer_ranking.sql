-- ============================================================
-- Olist E-Commerce Analysis
-- 12 - Customer Ranking
-- ============================================================
-- Purpose:
-- Identify the highest-value customers, product categories,
-- and sellers based on revenue and purchasing activity.
-- ============================================================


-- ============================================================
-- 1. Top 10 Customers by Revenue
-- ============================================================

SELECT
c.customer_unique_id,
ROUND(SUM(op.payment_value), 2) AS revenue
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN order_payments op
ON o.order_id = op.order_id
GROUP BY c.customer_unique_id
ORDER BY revenue DESC
LIMIT 10


-- ============================================================
-- 2. Top 10 Customers by Order Count
-- ============================================================

SELECT
c.customer_unique_id,
ROUND(SUM(op.payment_value), 2) AS revenue
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN order_payments op
ON o.order_id = op.order_id
GROUP BY c.customer_unique_id
ORDER BY revenue DESC
LIMIT 10

-- ============================================================
-- 3. Top 5 Categories by Revenue
-- ============================================================

SELECT
p.product_category_name,
ROUND(SUM(oi.price), 2) AS item_revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY item_revenue DESC
LIMIT 5

-- ============================================================
-- 4. Top 5 Sellers by Revenue
-- ============================================================

SELECT
oi.seller_id,
ROUND(SUM(oi.price), 2) AS item_revenue
FROM order_items oi
GROUP BY oi.seller_id
ORDER BY item_revenue DESC
LIMIT 5

-- ============================================================
-- 5. Revenue Concentration Among Top Customers
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
ROUND(100.0*SUM(revenue)/(SELECT SUM(revenue) FROM customer_revenue),2) AS top_customer_revenue_share
FROM
(
SELECT revenue
FROM customer_revenue
ORDER BY revenue DESC LIMIT 10
)

