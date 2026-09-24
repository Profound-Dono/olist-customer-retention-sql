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

SELECT ROUND(SUM(payment_value), 2) FROM order_payments

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
;

-- ============================================================
-- 3. Revenue by Product Category
-- ============================================================

SELECT
p.product_category_name,
SUM(oi.price) AS revenue
FROM order_items oi
JOIN products p
ON p.product_id = oi.product_id
GROUP BY p.product_category_name
ORDER BY sum(oi.price) desc                      

-- ============================================================
-- 4. Revenue by Customer State
-- ============================================================

SELECT customer_state, sum(payment_value) AS revenue FROM orders
INNER JOIN order_payments
ON orders.order_id = order_payments.order_id 
INNER JOIN customers
ON customers.customer_id = orders.customer_id
GROUP BY customer_state

-- ============================================================
-- 5. Average Order Value
-- ============================================================

SELECT ROUND(AVG(payment_value), 2) FROM order_payments
