-- ============================================================
-- Olist E-Commerce Analysis
-- 14 - Repeat Customer Revenue
-- ============================================================
-- Purpose:
-- Connect customer retention to revenue and determine the
-- financial contribution of repeat purchasing.
-- ============================================================


-- ============================================================
-- 1. Revenue from One-Time Customers
-- ============================================================

WITH customer_revenue AS
(
SELECT
c.customer_unique_id,
SUM(op.payment_value) AS revenue,
COUNT(DISTINCT o.order_id) AS order_count
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN order_payments op
ON o.order_id = op.order_id
GROUP BY c.customer_unique_id
)
SELECT
ROUND(SUM(revenue), 2) AS one_time_customer_revenue
FROM customer_revenue
WHERE order_count = 1

-- ============================================================
-- 2. Revenue from Repeat Customers
-- ============================================================

WITH customer_revenue AS
(
SELECT
c.customer_unique_id,
SUM(op.payment_value) AS revenue,
COUNT(DISTINCT o.order_id) AS order_count
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN order_payments op
ON o.order_id = op.order_id
GROUP BY c.customer_unique_id
)
SELECT
ROUND(SUM(revenue), 2) AS repeat_customer_revenue
FROM customer_revenue
WHERE order_count > 1

-- ============================================================
-- 3. Repeat Customer Revenue Share
-- ============================================================

WITH customer_revenue AS
(
SELECT
c.customer_unique_id,
SUM(op.payment_value) AS revenue,
COUNT(DISTINCT o.order_id) AS order_count
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN order_payments op
ON o.order_id = op.order_id
GROUP BY c.customer_unique_id
)
SELECT
ROUND(100.0*SUM(revenue)/SUM(SUM(revenue)) OVER (), 2) AS repeat_customer_revenue_share
FROM customer_revenue
WHERE order_count > 1

-- ============================================================
-- 4. Average Revenue per One-Time Customer
-- ============================================================

WITH customer_revenue AS
(
SELECT
c.customer_unique_id,
SUM(op.payment_value) AS revenue,
COUNT(DISTINCT o.order_id) AS order_count
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN order_payments op
ON o.order_id = op.order_id
GROUP BY c.customer_unique_id
)
SELECT
ROUND(AVG(revenue), 2) AS avg_revenue_per_one_time_customer
FROM customer_revenue
WHERE order_count = 1

-- ============================================================
-- 5. Average Revenue per Repeat Customer
-- ============================================================
WITH customer_revenue AS
(
SELECT
c.customer_unique_id,
SUM(op.payment_value) AS revenue,
COUNT(DISTINCT o.order_id) AS order_count
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN order_payments op
ON o.order_id = op.order_id
GROUP BY c.customer_unique_id
)
SELECT
ROUND(AVG(revenue), 2) AS avg_revenue_per_repeat_customer
FROM customer_revenue
WHERE order_count > 1

-- ============================================================
-- 6. Revenue Generated After the First Purchase
-- ============================================================

WITH customer_orders AS
(
SELECT
c.customer_unique_id,
o.order_id,
o.order_purchase_timestamp,
MIN(o.order_purchase_timestamp) OVER (PARTITION BY c.customer_unique_id) AS first_purchase
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
)
SELECT
ROUND(SUM(op.payment_value), 2) AS revenue_after_first_purchase
FROM customer_orders co
JOIN order_payments op
ON co.order_id = op.order_id
WHERE co.order_purchase_timestamp > co.first_purchase


-- ============================================================
-- 7. Repeat-Customer Revenue by Category
-- ============================================================

WITH customer_order_counts AS
(
SELECT
c.customer_unique_id,
COUNT(DISTINCT o.order_id) AS order_count
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.customer_unique_id
)
SELECT
p.product_category_name,
ROUND(SUM(oi.price), 2) AS repeat_customer_item_revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
JOIN orders o
ON oi.order_id = o.order_id
JOIN customers c
ON o.customer_id = c.customer_id
JOIN customer_order_counts coc
ON c.customer_unique_id = coc.customer_unique_id
WHERE coc.order_count > 1
GROUP BY p.product_category_name
ORDER BY repeat_customer_item_revenue DESC
