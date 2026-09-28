-- ============================================================
-- Olist E-Commerce Analysis
-- 09 - Delivery Analysis
-- ============================================================
-- Purpose:
-- Analyze delivery performance and investigate the relationship
-- between delivery timing and customer satisfaction.
-- ============================================================


-- ============================================================
-- 1. Orders Delivered Before or On the Estimated Date
-- ============================================================

SELECT
COUNT(order_id)
FROM orders
WHERE order_delivered_customer_date > order_estimated_delivery_date

-- ============================================================
-- 2. Late Delivery Rate
-- ============================================================

SELECT
ROUND(COUNT(order_id)/99441*100, 1) AS percentage
FROM orders
WHERE order_delivered_customer_date > order_estimated_delivery_date

-- ============================================================
-- 3. Average Review Score by Delivery Performance
-- ============================================================
-- Do customers who experienced late delivery leave different
-- review scores than customers whose orders were not late?

SELECT
COUNT(o.order_id) AS ontime_orders,
ROUND(AVG(review_score),0) AS avg_review_score
FROM orders o
JOIN order_reviews r
ON o.order_id = r.order_id
WHERE order_delivered_customer_date < o.order_estimated_delivery_date


SELECT
COUNT(o.order_id) AS late_orders,
ROUND(avg(review_score),0) AS avg_review_score
FROM orders o
JOIN order_reviews r
ON o.order_id = r.order_id
WHERE order_delivered_customer_date > o.order_estimated_delivery_date 


-- ============================================================
-- 4. Repeat Customer Rate by Delivery Performance
-- ============================================================

with one as(
SELECT
COUNT(c.customer_unique_id) cui
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
WHERE order_delivered_customer_date > order_estimated_delivery_date
GROUP BY c.customer_unique_id
HAVING COUNT(o.order_id) > 1
)
select
sum(cui) late_repeat_customers
from one

with one as(
SELECT
COUNT(c.customer_unique_id) cui
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
WHERE order_delivered_customer_date < order_estimated_delivery_date
GROUP BY c.customer_unique_id
HAVING COUNT(o.order_id) > 1
)
select
sum(cui) late_repeat_customers
from one

-- ============================================================
-- 5. Missing Delivery Dates
-- ============================================================

with one as(
SELECT
COUNT(c.customer_unique_id) cui
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
WHERE order_delivered_customer_date isnull
GROUP BY c.customer_unique_id
HAVING COUNT(o.order_id) > 1
)
select
sum(cui) no_delivery_yet_repeat_customers
from one
