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
-- Is repeat purchasing different between customers whose
-- orders were late and those whose orders were not late?



-- ============================================================
-- 5. Missing Delivery Dates
-- ============================================================
-- How many orders do not have a recorded delivery date,
-- and how should these orders be handled in delivery analysis?


