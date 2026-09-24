-- ============================================================
-- Olist E-Commerce Analysis
-- 03 - Order Metrics
-- ============================================================
-- Purpose:
-- Analyze order volume, purchasing patterns, order composition,
-- and order status.
-- ============================================================


-- ============================================================
-- 1. Total Orders
-- ============================================================

SELECT COUNT(*) AS total_orders
FROM orders;

-- ============================================================
-- 2. Orders by Month
-- ============================================================

SELECT
    DATE_TRUNC('month', order_purchase_timestamp)::date AS month,
    COUNT(*) AS order_count
FROM orders
GROUP BY 1
ORDER BY 1;

-- ============================================================
-- 3. Average Items per Order
-- ============================================================

SELECT
    ROUND(AVG(item_count), 2) AS avg_items_per_order
from
(
    SELECT
        order_id,
        COUNT(*) AS item_count
    FROM order_items
    GROUP BY order_id
);

-- ============================================================
-- 4. Average Order Value
-- ============================================================

SELECT
ROUND(AVG(spv), 2) AS avg_order_value
FROM
(
SELECT
order_id AS oi,
SUM(payment_value) AS spv
FROM order_payments
GROUP BY order_id
);

-- ============================================================
-- 5. Most Common Order Statuses
-- ============================================================

SELECT order_status, COUNT(order_status) FROM orders
GROUP BY order_status
ORDER BY COUNT(order_status) DESC LIMIT 3

-- ============================================================
-- 6. Highest and Lowest Order Volume
-- ============================================================

SELECT EXTRACT(MONTH FROM order_purchase_timestamp), COUNT(order_id) FROM orders
GROUP BY EXTRACT(MONTH FROM order_purchase_timestamp)
ORDER BY COUNT(order_id) DESC

SELECT EXTRACT(MONTH FROM order_purchase_timestamp), COUNT(order_id) FROM orders
GROUP BY EXTRACT(MONTH FROM order_purchase_timestamp)
ORDER BY COUNT(order_id) ASC
