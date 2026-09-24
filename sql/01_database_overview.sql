-- ============================================================
-- Olist E-Commerce Analysis
-- 01 - Database Overview
-- ============================================================
-- Purpose:
-- Establish the basic structure, scale, date range, and
-- data quality of the Olist e-commerce dataset.
-- ============================================================


-- ============================================================
-- 1. Row Counts
-- ============================================================

SELECT COUNT(*) AS row_count FROM customers;
SELECT COUNT(*) AS row_count FROM geolocation;
SELECT COUNT(*) AS row_count FROM order_items;
SELECT COUNT(*) AS row_count FROM order_payments;
SELECT COUNT(*) AS row_count FROM order_reviews;
SELECT COUNT(*) AS row_count FROM orders;
SELECT COUNT(*) AS row_count FROM product_category_translation;
SELECT COUNT(*) AS row_count FROM products;
SELECT COUNT(*) AS row_count FROM sellers;

-- ============================================================
-- 2. Order Date Range
-- ============================================================

SELECT
    MIN(order_purchase_timestamp)::date AS first_order_date,
    MAX(order_purchase_timestamp)::date AS last_order_date
FROM orders;

-- ============================================================
-- 3. Order Status Distribution
-- ============================================================

SELECT
    order_status,
    COUNT(*) AS order_count
FROM orders
GROUP BY order_status
ORDER BY order_count DESC;

-- ============================================================
-- 4. Payment Type Distribution
-- ============================================================

SELECT
    payment_type,
    COUNT(*) AS payment_count
FROM order_payments
GROUP BY payment_type
ORDER BY payment_count DESC;

-- ============================================================
-- 5. Product and Seller Coverage
-- ============================================================

SELECT
    COUNT(DISTINCT product_id) AS unique_products
FROM products;

SELECT
    COUNT(DISTINCT seller_id) AS unique_sellers
FROM sellers;

-- ============================================================
-- 6. Missing Values
-- ============================================================

SELECT
    COUNT(*) FILTER (
        WHERE customer_unique_id IS NULL
    ) AS missing_customer_unique_id,
    COUNT(*) FILTER (
        WHERE customer_state IS NULL
    ) AS missing_customer_state,
    COUNT(*) FILTER (
        WHERE customer_city IS NULL
    ) AS missing_customer_city
FROM customers;


SELECT
    COUNT(*) FILTER (
        WHERE order_purchase_timestamp IS NULL
    ) AS missing_purchase_timestamp,
    COUNT(*) FILTER (
        WHERE order_status IS NULL
    ) AS missing_order_status,
    COUNT(*) FILTER (
        WHERE order_delivered_customer_date IS NULL
    ) AS missing_delivery_date
FROM orders;

-- ============================================================
-- 7. Delivery Date Availability
-- ============================================================

SELECT
    COUNT(*) FILTER (
        WHERE order_delivered_customer_date IS NOT NULL
    ) AS orders_with_delivery_date,
    COUNT(*) FILTER (
        WHERE order_delivered_customer_date IS NULL
    ) AS orders_without_delivery_date
FROM orders;
