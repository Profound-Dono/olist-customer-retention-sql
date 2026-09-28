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
HAVING COUNT(o.order_id) = 1
)
SELECT
SUM(pv) AS revenue
FROM one

-- ============================================================
-- 2. Revenue from Repeat Customers
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
-- 3. Repeat Customer Revenue Share
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
round(SUM(pv)/16008872.12*100,1) AS percentage
FROM one

-- ============================================================
-- 4. Average Revenue per One-Time Customer
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
HAVING COUNT(o.order_id) = 1
)
SELECT
round(avg(pv),2) AS average_revenue
FROM one

-- ============================================================
-- 5. Average Revenue per Repeat Customer
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
round(avg(pv),2) AS average_revenue
FROM one

-- ============================================================
-- 6. Revenue Generated After the First Purchase
-- ============================================================
-- How much revenue is generated from orders placed after
-- a customer's first purchase?


-- ============================================================
-- 7. Repeat-Customer Revenue by Category
-- ============================================================

SELECT
p.product_category_name,
sum(op.payment_value) pv
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN order_payments op 
ON o.order_id = op.order_id 
join order_items oi
on o.order_id = oi.order_id 
join products p
on oi.product_id = p.product_id 
GROUP BY p.product_category_name
HAVING COUNT(o.order_id) > 1
order by sum(op.payment_value) desc
