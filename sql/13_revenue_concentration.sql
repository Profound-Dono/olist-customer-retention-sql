-- ============================================================
-- Olist E-Commerce Analysis
-- 13 - Revenue Concentration
-- ============================================================
-- Purpose:
-- Determine whether revenue is concentrated among a small
-- number of customers, categories, or other segments.
-- ============================================================


-- ============================================================
-- 1. Top 10 Customer Revenue Share
-- ============================================================

with one as(
SELECT
c.customer_unique_id customers,
sum(op.payment_value) revenue
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
join order_payments op 
on o.order_id = op.order_id 
group by c.customer_unique_id
order by sum(op.payment_value) desc limit 10
)
select
round(sum(revenue)/16008872.12*100,1) percentage
from one

-- ============================================================
-- 2. Top 100 Customer Revenue Share
-- ============================================================

with one as(
SELECT
c.customer_unique_id customers,
sum(op.payment_value) revenue
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
join order_payments op 
on o.order_id = op.order_id 
group by c.customer_unique_id
order by sum(op.payment_value) desc limit 100
)
select
round(sum(revenue)/16008872.12*100,1) percentage
from one

-- ============================================================
-- 3. Repeat Customer Revenue Share
-- ============================================================

with one as(
SELECT
c.customer_unique_id customers,
sum(op.payment_value) revenue
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
join order_payments op 
on o.order_id = op.order_id 
group by c.customer_unique_id
having count(o.order_id) > 1
)
select
round(sum(revenue)/16008872.12*100,1) percentage
from one

-- ============================================================
-- 4. Top Category Revenue Share
-- ============================================================

with one as (
SELECT
p.product_category_name,
sum(op.payment_value) revenue
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
join order_payments op 
on o.order_id = op.order_id 
join order_items oi 
on o.order_id = oi.order_id
join products p
on oi.product_id = p.product_id
group by p.product_category_name 
order by sum(op.payment_value) desc limit 7
)
select
round(sum(revenue)/16008872.12*100,1) percentage
from one
