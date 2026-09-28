-- ============================================================
-- Olist E-Commerce Analysis
-- 05 - Customer Behavior
-- ============================================================
-- Purpose:
-- Analyze how customers purchase, how frequently they return,
-- and how purchasing behavior changes over time.
-- ============================================================


-- ============================================================
-- 1. Average Orders per Customer
-- ============================================================

WITH one AS
(
SELECT c.customer_unique_id,
COUNT(order_id) AS oi
FROM orders o
JOIN customers c 
ON o.customer_id = c.customer_id 
GROUP BY c.customer_unique_id
)
SELECT
ROUND(AVG(oi), 2) customer_orders
FROM one

-- ============================================================
-- 2. One-Time Customer Percentage
-- ============================================================

WITH customer_orders AS
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
ROUND(100.0*COUNT(*)FILTER(WHERE order_count = 1)/COUNT(*), 2) AS one_time_customer_rate
FROM customer_orders

-- ============================================================
-- 3. Repeat Customer Percentage
-- ============================================================

WITH customer_orders AS
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
ROUND(100.0*COUNT(*)FILTER(WHERE order_count > 1)/COUNT(*), 2) AS repeat_customer_rate
FROM customer_orders

-- ============================================================
-- 4. Average Time Between Purchases
-- ============================================================

...

-- ============================================================
-- 5. Purchasing Behavior Over Time
-- ============================================================
-- Does customer purchasing frequency change over time?

SELECT
DATE_TRUNC('month', o.order_purchase_timestamp)::date AS month,
COUNT(DISTINCT c.customer_unique_id) AS purchasing_customers,
COUNT(o.order_id) AS orders,
ROUND(COUNT(o.order_id)::numeric/COUNT(DISTINCT c.customer_unique_id, 2) AS orders_per_customer
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY 1
ORDER BY 1
