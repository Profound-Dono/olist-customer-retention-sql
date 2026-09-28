-- ============================================================
-- Olist E-Commerce Analysis
-- 11 - Retention Analysis
-- ============================================================
-- Purpose:
-- Convert the customer cohort data into retention percentages
-- and create a customer retention matrix.
-- ============================================================


-- ============================================================
-- 1. Month 1 Retention
-- ============================================================
WITH customer_purchases AS
(
SELECT
DISTINCT
c.customer_unique_id,
DATE_TRUNC('month',MIN(o.order_purchase_timestamp)OVER (PARTITION BY c.customer_unique_id))::date AS cohort_month,
DATE_TRUNC('month',o.order_purchase_timestamp)::date AS purchase_month
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
),
cohort_activity AS
(
SELECT
cohort_month,
purchase_month,
COUNT(DISTINCT customer_unique_id) AS active_customers
FROM customer_purchases
GROUP BY
cohort_month,
purchase_month
),
cohort_sizes AS
(
SELECT
cohort_month,
MAX(active_customers) FILTER (WHERE purchase_month = cohort_month) AS cohort_size
FROM cohort_activity
GROUP BY cohort_month
)
SELECT
ca.cohort_month,
ROUND(100.0*MAX(CASE WHEN ca.purchase_month = ca.cohort_month + INTERVAL '1 month'
THEN ca.active_customers
END)/cs.cohort_size,2) AS m1
FROM cohort_activity ca
JOIN cohort_sizes cs
ON ca.cohort_month = cs.cohort_month
GROUP BY ca.cohort_month, cs.cohort_size
ORDER BY ca.cohort_month

-- ============================================================
-- 2. Month 2 Retention
-- ============================================================

WITH customer_purchases AS
(
SELECT
DISTINCT
c.customer_unique_id,
DATE_TRUNC('month',MIN(o.order_purchase_timestamp)OVER (PARTITION BY c.customer_unique_id))::date AS cohort_month,
DATE_TRUNC('month',o.order_purchase_timestamp)::date AS purchase_month
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
),
cohort_activity AS
(
SELECT
cohort_month,
purchase_month,
COUNT(DISTINCT customer_unique_id) AS active_customers
FROM customer_purchases
GROUP BY
cohort_month,
purchase_month
),
cohort_sizes AS
(
SELECT
cohort_month,
MAX(active_customers) FILTER (WHERE purchase_month = cohort_month) AS cohort_size
FROM cohort_activity
GROUP BY cohort_month
)
SELECT
ca.cohort_month,
ROUND(100.0*MAX(CASE WHEN ca.purchase_month = ca.cohort_month + INTERVAL '2 months'
THEN ca.active_customers
END)/cs.cohort_size,2) AS m2
FROM cohort_activity ca
JOIN cohort_sizes cs
ON ca.cohort_month = cs.cohort_month
GROUP BY ca.cohort_month, cs.cohort_size
ORDER BY ca.cohort_month

-- ============================================================
-- 3. Month 3 Retention
-- ============================================================

WITH customer_purchases AS
(
SELECT
DISTINCT
c.customer_unique_id,
DATE_TRUNC('month',MIN(o.order_purchase_timestamp)OVER (PARTITION BY c.customer_unique_id))::date AS cohort_month,
DATE_TRUNC('month',o.order_purchase_timestamp)::date AS purchase_month
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
),
cohort_activity AS
(
SELECT
cohort_month,
purchase_month,
COUNT(DISTINCT customer_unique_id) AS active_customers
FROM customer_purchases
GROUP BY
cohort_month,
purchase_month
),
cohort_sizes AS
(
SELECT
cohort_month,
MAX(active_customers) FILTER (WHERE purchase_month = cohort_month) AS cohort_size
FROM cohort_activity
GROUP BY cohort_month
)
SELECT
ca.cohort_month,
ROUND(100.0*MAX(CASE WHEN ca.purchase_month = ca.cohort_month + INTERVAL '3 months'
THEN ca.active_customers
END)/cs.cohort_size,2) AS m3
FROM cohort_activity ca
JOIN cohort_sizes cs
ON ca.cohort_month = cs.cohort_month
GROUP BY ca.cohort_month, cs.cohort_size
ORDER BY ca.cohort_month

-- ============================================================
-- 4. Month 4 Retention
-- ============================================================

WITH customer_purchases AS
(
SELECT
DISTINCT
c.customer_unique_id,
DATE_TRUNC('month',MIN(o.order_purchase_timestamp)OVER (PARTITION BY c.customer_unique_id))::date AS cohort_month,
DATE_TRUNC('month',o.order_purchase_timestamp)::date AS purchase_month
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
),
cohort_activity AS
(
SELECT
cohort_month,
purchase_month,
COUNT(DISTINCT customer_unique_id) AS active_customers
FROM customer_purchases
GROUP BY
cohort_month,
purchase_month
),
cohort_sizes AS
(
SELECT
cohort_month,
MAX(active_customers) FILTER (WHERE purchase_month = cohort_month) AS cohort_size
FROM cohort_activity
GROUP BY cohort_month
)
SELECT
ca.cohort_month,
ROUND(100.0*MAX(CASE WHEN ca.purchase_month = ca.cohort_month + INTERVAL '4 months'
THEN ca.active_customers
END)/cs.cohort_size,2) AS m4
FROM cohort_activity ca
JOIN cohort_sizes cs
ON ca.cohort_month = cs.cohort_month
GROUP BY ca.cohort_month, cs.cohort_size
ORDER BY ca.cohort_month


