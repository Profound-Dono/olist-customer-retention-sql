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
) AS repeat_customers;

-- ============================================================
-- 2. Repeat Customer Rate by Month
-- ============================================================

SELECT
extract(month from o.order_purchase_timestamp),
count(c.customer_unique_id)
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY extract(month from o.order_purchase_timestamp)
HAVING COUNT(o.order_id) > 1

-- ============================================================
-- 3. Repeat Customer Rate by State
-- ============================================================

SELECT
c.customer_state,
COUNT(c.customer_unique_id)
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.customer_state
HAVING COUNT(o.order_id) > 1

-- ============================================================
-- 4. Highest and Lowest Repeat Customer Rates
-- ============================================================

SELECT
c.customer_state states,
COUNT(c.customer_unique_id) customerss
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.customer_state
HAVING COUNT(o.order_id) > 1
order by count(c.customer_unique_id) ASC LIMIT 1

SELECT
c.customer_state states,
COUNT(c.customer_unique_id) customerss
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.customer_state
HAVING COUNT(o.order_id) > 1
order by count(c.customer_unique_id) DESC LIMIT 1

-- ============================================================
-- 5. Revenue from Repeat Customers
-- ============================================================

WITH one AS(
SELECT
c.customer_unique_id,
sum(op.payment_value) pv
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN order_payments op 
ON o.order_id = op.order_id 
GROUP BY c.customer_unique_id
HAVING COUNT(o.order_id) > 1
)
SELECT
SUM(pv) AS revenue
FROM one

-- ============================================================
-- 6. Orders from Repeat Customers
-- ============================================================

with one as(
SELECT
c.customer_unique_id,
COUNT(O.order_id) oi
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
join order_payments op 
on o.order_id = op.order_id 
GROUP BY c.customer_unique_id
HAVING COUNT(o.order_id) > 1
)
select
sum(oi) as orders
from one
