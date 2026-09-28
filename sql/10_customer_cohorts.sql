-- ============================================================
-- Olist E-Commerce Analysis
-- 10 - Customer Cohorts
-- ============================================================
-- Purpose:
-- Build customer cohorts based on the month of each customer's
-- first purchase and track subsequent purchasing activity.
-- ============================================================


-- ============================================================
-- 1. First Purchase Date
-- ============================================================

SELECT
c.customer_unique_id,
MIN(o.order_purchase_timestamp)::date AS first_purchase_date
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.customer_unique_id
ORDER BY first_purchase_date

-- ============================================================
-- 2. Customer Cohort Month
-- ============================================================

SELECT
c.customer_unique_id,
DATE_TRUNC('month',MIN(o.order_purchase_timestamp))::date AS cohort_month
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.customer_unique_id
ORDER BY cohort_month

-- ============================================================
-- 3. Cohort Size
-- ============================================================

WITH customer_cohorts AS (
SELECT
c.customer_unique_id,
DATE_TRUNC('month',MIN(o.order_purchase_timestamp))::date AS cohort_month
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.customer_unique_id
)
SELECT
cohort_month,
COUNT(*) AS cohort_size
FROM customer_cohorts
GROUP BY cohort_month
ORDER BY cohort_month

-- ============================================================
-- 4. Purchase Month
-- ============================================================

SELECT DISTINCT
c.customer_unique_id,
DATE_TRUNC('month',o.order_purchase_timestamp)::date AS purchase_month
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
ORDER BY purchase_month

-- ============================================================
-- 5. Months Since First Purchase
-- ============================================================

WITH customer_purchases AS
(
SELECT
c.customer_unique_id,
DATE_TRUNC('month',MIN(o.order_purchase_timestamp)OVER(PARTITION BY c.customer_unique_id))::date AS cohort_month,
DATE_TRUNC('month',o.order_purchase_timestamp)::date AS purchase_month
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
)
SELECT
DISTINCT
customer_unique_id,
cohort_month,
purchase_month,
(
EXTRACT(YEAR FROM AGE(purchase_month, cohort_month)) * 12
+ EXTRACT(MONTH FROM AGE(purchase_month, cohort_month))
)::integer AS months_since_first_purchase
FROM customer_purchases
ORDER BY cohort_month, purchase_month

-- ============================================================
-- 6. Cohort Activity Table
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
)
SELECT
cohort_month,
purchase_month,
COUNT(DISTINCT customer_unique_id) AS active_customers
FROM customer_purchases
GROUP BY cohort_month, purchase_month
ORDER BY cohort_month, purchase_month;

