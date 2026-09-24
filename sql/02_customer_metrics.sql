-- ============================================================
-- Olist E-Commerce Analysis
-- 02 - Customer Metrics
-- ============================================================
-- Purpose:
-- Measure the size, purchasing frequency, and revenue
-- contribution of the customer base.
-- ============================================================


-- ============================================================
-- 1. Unique Customers
-- ============================================================

SELECT COUNT(DISTINCT customer_unique_id) FROM customers

-- ============================================================
-- 2. One-Time Customers
-- ============================================================

SELECT
COUNT(*) AS one_time_customers
FROM (
    SELECT
        c.customer_unique_id
    FROM orders o
    JOIN customers c
        ON o.customer_id = c.customer_id
    GROUP BY c.customer_unique_id
    HAVING COUNT(o.order_id) = 1
);

-- ============================================================
-- 3. Repeat Customers
-- ============================================================

SELECT
    COUNT(*) AS one_time_customers
FROM (
    SELECT
        c.customer_unique_id
    FROM orders o
    JOIN customers c
        ON o.customer_id = c.customer_id
    GROUP BY c.customer_unique_id
    HAVING COUNT(o.order_id) > 1
);

-- ============================================================
-- 4. Repeat Customer Rate
-- ============================================================

SELECT 
    ROUND(COUNT(DISTINCT customer_unique_id)/COUNT(customer_unique_id)*100,2)
FROM customers


-- ============================================================
-- 5. Average Orders per Customer
-- ============================================================

SELECT
round(avg(ye), 2) AS one_time_customers
FROM (
    SELECT
    count(o.order_id) ye, 
    count(c.customer_unique_id)
    FROM orders o
    JOIN customers c
        ON o.customer_id = c.customer_id
    GROUP BY c.customer_unique_id
);

-- ============================================================
-- 6. Average Revenue per Customer
-- ============================================================
-- What is the average revenue generated per unique customer?

...
