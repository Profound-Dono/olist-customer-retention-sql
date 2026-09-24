-- ============================================================
-- Olist E-Commerce Analysis
-- 05 - Customer Behavior
-- ============================================================
-- Purpose:
-- Analyze how customers purchase, how frequently they return,
-- and how purchasing behavior changes over time.
-- ============================================================


-- ============================================================
-- 1. Average Orders per Customer
-- ============================================================
-- How many orders does a typical customer make?

WITH one AS(
SELECT c.customer_unique_id, COUNT(order_id) AS yes
FROM orders o
JOIN customers c 
ON o.customer_id = c.customer_id 
GROUP BY c.customer_unique_id
)
SELECT ROUND(AVG(yes), 2) FROM one

-- ============================================================
-- 2. One-Time Customer Percentage
-- ============================================================
-- What percentage of customers make only one purchase?

WITH one AS(
SELECT c.customer_unique_id, COUNT(order_id) AS yes
FROM orders o
JOIN customers c 
ON o.customer_id = c.customer_id 
GROUP BY c.customer_unique_id
having count(order_id) = 1
)
select round(sum(yes)/99441*100,1) as percentage
from one

-- ============================================================
-- 3. Repeat Customer Percentage
-- ============================================================
-- What percentage of customers make two or more purchases?

WITH one AS(
SELECT c.customer_unique_id, COUNT(order_id) AS yes
FROM orders o
JOIN customers c 
ON o.customer_id = c.customer_id 
GROUP BY c.customer_unique_id
HAVING COUNT(order_id) > 2
)
SELECT ROUND(SUM(yes)/99441*100,1) AS percentage
FROM one

-- ============================================================
-- 4. Average Time Between Purchases
-- ============================================================
-- For repeat customers, how much time passes on average
-- between purchases?

with one as(
SELECT 
customer_unique_id,
max(o.order_purchase_timestamp)-(min(o.order_purchase_timestamp)) as yes
FROM customers c
JOIN orders o
ON o.customer_id = c.customer_id
group by c.customer_unique_id
)
select avg(yes)
from one

-- ============================================================
-- 5. Purchasing Behavior Over Time
-- ============================================================
-- Does customer purchasing frequency change over time?

No it doesn't.
