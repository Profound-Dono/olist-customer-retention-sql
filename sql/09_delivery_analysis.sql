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

WITH customer_delivery AS
(
SELECT
c.customer_unique_id,
MAX(CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date
THEN 1 ELSE 0 END) AS had_late_delivery
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_unique_id
),
customer_orders AS
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
CASE WHEN cd.had_late_delivery = 1
THEN 'Experienced Late Delivery'
ELSE 'No Late Delivery'
END AS delivery_group,
COUNT(*) AS customers,
COUNT(*) FILTER (
WHERE co.order_count > 1
) AS repeat_customers,
ROUND(100.0*COUNT(*) FILTER (WHERE co.order_count > 1)/COUNT(*), 2) AS repeat_customer_rate
FROM customer_delivery cd
JOIN customer_orders co
ON cd.customer_unique_id = co.customer_unique_id
GROUP BY cd.had_late_delivery
ORDER BY cd.had_late_delivery DESC

-- ============================================================
-- 5. Missing Delivery Dates
-- ============================================================

SELECT
COUNT(*) AS orders_without_delivery_date
FROM orders
WHERE order_delivered_customer_date IS NULL
