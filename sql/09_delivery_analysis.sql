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
COUNT(*) AS on_time_orders
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
AND order_delivered_customer_date <= order_estimated_delivery_date

-- ============================================================
-- 2. Late Delivery Rate
-- ============================================================

SELECT
ROUND(100.0*COUNT(*)/(SELECT COUNT(*) FROM orders WHERE order_delivered_customer_date IS NOT NULL), 2) AS late_delivery_rate
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
AND order_delivered_customer_date > order_estimated_delivery_date

-- ============================================================
-- 3. Average Review Score by Delivery Performance
-- ============================================================

SELECT
'On Time' AS delivery_performance,
COUNT(o.order_id) AS orders,
ROUND(AVG(r.review_score), 2) AS avg_review_score
FROM orders o
JOIN order_reviews r
ON o.order_id = r.order_id
WHERE o.order_delivered_customer_date IS NOT NULL
AND o.order_delivered_customer_date <= o.order_estimated_delivery_date
UNION ALL
SELECT
'Late' AS delivery_performance,
COUNT(o.order_id) AS orders,
ROUND(AVG(r.review_score), 2) AS avg_review_score
FROM orders o
JOIN order_reviews r
ON o.order_id = r.order_id
WHERE o.order_delivered_customer_date IS NOT NULL
AND o.order_delivered_customer_date > o.order_estimated_delivery_date;


-- ============================================================
-- 4. Repeat Customer Rate by Delivery Performance
-- ============================================================

...

-- ============================================================
-- 5. Missing Delivery Dates
-- ============================================================

SELECT
COUNT(*) AS orders_without_delivery_date
FROM orders
WHERE order_delivered_customer_date IS NULL
