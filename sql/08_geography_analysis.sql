-- ============================================================
-- Olist E-Commerce Analysis
-- 08 - Geography Analysis
-- ============================================================
-- Purpose:
-- Investigate customer distribution, revenue, and repeat
-- purchasing across Brazilian states.
-- ============================================================


-- ============================================================
-- 1. Customers by State
-- ============================================================

SELECT
c.customer_state,
COUNT(c.customer_unique_id) AS customer_count
FROM customers c
GROUP BY c.customer_state
ORDER BY COUNT(c.customer_unique_id) DESC

-- ============================================================
-- 2. Revenue by State
-- ============================================================

SELECT
c.customer_state,
SUM(op.payment_value) AS revenue
FROM order_payments op 
JOIN orders o
ON op.order_id = o.order_id
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY revenue DESC

-- ============================================================
-- 3. Repeat Customer Rate by State
-- ============================================================

WITH customer_orders AS
(
SELECT
c.customer_unique_id,
c.customer_state,
COUNT(o.order_id) AS order_count
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.customer_unique_id, c.customer_state
)
SELECT
customer_state,
ROUND(100.0*COUNT(*) FILTER (WHERE order_count > 1)/COUNT(*), 2) AS repeat_customer_rate
FROM customer_orders
GROUP BY customer_state
ORDER BY repeat_customer_rate DESC

-- ============================================================
-- 4. Revenue per Customer by State
-- ============================================================

WITH state_revenue AS
(
SELECT
c.customer_state,
SUM(op.payment_value) AS revenue
FROM order_payments op
JOIN orders o
ON op.order_id = o.order_id
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.customer_state
),
state_customers AS (
SELECT
customer_state,
COUNT(DISTINCT customer_unique_id) AS customers
FROM customers
GROUP BY customer_state
)
SELECT
sr.customer_state,
ROUND(sr.revenue / sc.customers, 2) AS revenue_per_customer
FROM state_revenue sr
JOIN state_customers sc
ON sr.customer_state = sc.customer_state
ORDER BY revenue_per_customer DESC
