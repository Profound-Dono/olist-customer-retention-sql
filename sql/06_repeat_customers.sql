-- ============================================================
-- Olist E-Commerce Analysis
-- 06 - Repeat Customers
-- ============================================================
-- Purpose:
-- Investigate repeat purchasing and customer retention across
-- time, geography, and revenue.
-- ============================================================


-- ============================================================
-- 1. Overall Repeat Customer Rate
-- ============================================================

SELECT
ROUND(100.0*COUNT(*)/(SELECT COUNT(DISTINCT customer_unique_id)
FROM customers),2) AS repeat_customer_rate
FROM
(
SELECT
c.customer_unique_id
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.customer_unique_id
HAVING COUNT(o.order_id) > 1
)

-- ============================================================
-- 2. Repeat Customer Rate by Month
-- ============================================================

WITH customer_purchases AS
(
SELECT
c.customer_unique_id,
DATE_TRUNC('month',o.order_purchase_timestamp)::date AS purchase_month,
COUNT(*) OVER (PARTITION BY c.customer_unique_id ORDER BY o.order_purchase_timestamp ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING) AS previous_orders
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
),
monthly_customers AS
(
SELECT
purchase_month,
customer_unique_id,
MAX(previous_orders) AS previous_orders
FROM customer_purchases
GROUP BY purchase_month, customer_unique_id
)
SELECT
purchase_month,
COUNT(*) AS total_customers,
COUNT(*) FILTER (WHERE previous_orders > 0) AS repeat_customers,
ROUND(100.0*COUNT(*) FILTER (WHERE previous_orders > 0)/COUNT(*), 2) AS repeat_customer_rate
FROM monthly_customers
GROUP BY purchase_month
ORDER BY purchase_month

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
COUNT(*) AS total_customers,
COUNT(*) FILTER (WHERE order_count > 1) AS repeat_customers,
ROUND(100.0*COUNT(*) FILTER (WHERE order_count > 1/COUNT(*), 2) AS repeat_customer_rate
FROM customer_orders
GROUP BY customer_state
ORDER BY repeat_customer_rate DESC

-- ============================================================
-- 4. Highest and Lowest Repeat Customer Rates
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
GROUP BY c.customer_unique_id, c.customer_state), state_rates
  AS (SELECT
        customer_state,
        ROUND(
            100.0 * COUNT(*) FILTER (
                WHERE order_count > 1
            ) / COUNT(*),
            2
        ) AS repeat_customer_rate,
        COUNT(*) AS total_customers
    FROM customer_orders
    GROUP BY customer_state
)
SELECT
customer_state,
repeat_customer_rate,
total_customers
FROM state_rates
ORDER BY repeat_customer_rate ASC
LIMIT 1;

WITH customer_orders AS
(
SELECT
c.customer_unique_id,
c.customer_state,
COUNT(o.order_id) AS order_count
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.customer_unique_id, c.customer_state), state_rates
  AS (SELECT
        customer_state,
        ROUND(
            100.0 * COUNT(*) FILTER (
                WHERE order_count > 1
            ) / COUNT(*),
            2
        ) AS repeat_customer_rate,
        COUNT(*) AS total_customers
    FROM customer_orders
    GROUP BY customer_state
)
SELECT
customer_state,
repeat_customer_rate,
total_customers
FROM state_rates
ORDER BY repeat_customer_rate DESC
LIMIT 1;

-- ============================================================
-- 5. Revenue from Repeat Customers
-- ============================================================

WITH customer_orders AS (
SELECT
c.customer_unique_id,
COUNT(o.order_id) AS order_count
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.customer_unique_id), repeat_customers
  AS (
    SELECT
        customer_unique_id
    FROM customer_orders
    WHERE order_count > 1
)
SELECT
ROUND(SUM(op.payment_value), 2) AS repeat_customer_revenue
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN repeat_customers rc
ON c.customer_unique_id = rc.customer_unique_id
JOIN order_payments op
ON o.order_id = op.order_id

-- ============================================================
-- 6. Orders from Repeat Customers
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
COUNT(o.order_id) AS repeat_customer_orders
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN customer_orders co
ON c.customer_unique_id = co.customer_unique_id
WHERE co.order_count > 1
