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
FULL OUTER JOIN orders o
ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY COUNT(c.customer_unique_id) DESC LIMIT 3

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
ORDER BY revenue DESC LIMIT 3

-- ============================================================
-- 3. Repeat Customer Rate by State
-- ============================================================

SELECT
    c.customer_state as states,
    count(o.order_id) as rc
FROM order_items oi
JOIN orders o
    ON oi.order_id = o.order_id
JOIN customers c
    ON o.customer_id = c.customer_id
GROUP BY c.customer_state
having count(o.order_id) > 1

-- ============================================================
-- 4. Revenue per Customer by State
-- ============================================================

SELECT
    c.customer_state,
    round(avg(op.payment_value), 2) AS avg_revenue
FROM order_payments op 
JOIN orders o
    ON op.order_id = o.order_id
JOIN customers c
    ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY  avg_revenue desc
