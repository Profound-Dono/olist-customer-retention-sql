-- ============================================================
-- Olist E-Commerce Analysis
-- 04 - Revenue Metrics
-- ============================================================
-- Purpose:
-- Analyze total revenue, revenue trends, product categories,
-- and geographic revenue distribution.
-- ============================================================


-- ============================================================
-- 1. Total Revenue
-- ============================================================

SELECT
ROUND(SUM(payment_value), 2)
FROM order_payments

-- ============================================================
-- 2. Revenue by Month
-- ============================================================

SELECT
DATE_TRUNC('month', o.order_purchase_timestamp)::date AS month,
ROUND(SUM(op.payment_value), 2) AS revenue
FROM orders o
JOIN order_payments op
ON o.order_id = op.order_id
GROUP BY 1
ORDER BY 1

-- ============================================================
-- 3. Revenue by Product Category
-- ============================================================

SELECT
p.product_category_name,
round(SUM(oi.price), 2) AS revenue
FROM order_items oi
JOIN products p
ON p.product_id = oi.product_id
GROUP BY p.product_category_name
ORDER BY sum(oi.price) DESC                      

-- ============================================================
-- 4. Revenue by Customer State
-- ============================================================

SELECT
c.customer_state,
ROUND(SUM(op.payment_value), 2) AS revenue
FROM orders o
JOIN order_payments op
ON o.order_id = op.order_id
JOIN customers c
ON c.customer_id = o.customer_id
GROUP BY c.customer_state
ORDER BY revenue DESC

-- ============================================================
-- 5. Average Order Value
-- ============================================================

SELECT
ROUND(AVG(order_value), 2) AS avg_order_value
FROM
(
SELECT
order_id,
SUM(payment_value) AS order_value
FROM order_payments
GROUP BY order_id
)
