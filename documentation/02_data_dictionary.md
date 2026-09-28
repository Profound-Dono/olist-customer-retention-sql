# Data Dictionary

## Overview

The Olist Brazilian E-Commerce dataset contains customer, order, product, seller, payment, review, and geographic information from an online marketplace.

The dataset contains approximately 100,000 orders and covers September 2016 through September 2018.

## Main Tables

### customers

| Column | Description |
|---|---|
| customer_id | Olist customer record identifier associated with an order |
| customer_unique_id | Identifier representing the actual customer across multiple orders |
| customer_zip_code_prefix | Customer ZIP code prefix |
| customer_city | Customer city |
| customer_state | Customer Brazilian state |

### orders

| Column | Description |
|---|---|
| order_id | Unique order identifier |
| customer_id | Links an order to the customer record |
| order_status | Current order status |
| order_purchase_timestamp | Date and time when the order was placed |
| order_approved_at | Date and time when payment was approved |
| order_delivered_carrier_date | Date when the order was handed to the carrier |
| order_delivered_customer_date | Date when the order was delivered to the customer |
| order_estimated_delivery_date | Estimated delivery date |

### order_items

| Column | Description |
|---|---|
| order_id | Order associated with the item |
| order_item_id | Item sequence within an order |
| product_id | Product identifier |
| seller_id | Seller identifier |
| shipping_limit_date | Shipping deadline |
| price | Price of the individual item |
| freight_value | Freight/shipping value |

### order_payments

| Column | Description |
|---|---|
| order_id | Associated order |
| payment_sequential | Payment sequence number |
| payment_type | Payment method |
| payment_installments | Number of installments |
| payment_value | Payment amount |

### order_reviews

| Column | Description |
|---|---|
| review_id | Review identifier |
| order_id | Associated order |
| review_score | Customer review score |
| review_comment_title | Review title |
| review_comment_message | Review text |
| review_creation_date | Review creation date |
| review_answer_timestamp | Review response timestamp |

### products

| Column | Description |
|---|---|
| product_id | Unique product identifier |
| product_category_name | Product category |
| product_name_length | Product name character length |
| product_description_length | Product description character length |
| product_photos_qty | Number of product photos |
| product_weight_g | Product weight |
| product_length_cm | Product length |
| product_height_cm | Product height |
| product_width_cm | Product width |

### sellers

| Column | Description |
|---|---|
| seller_id | Unique seller identifier |
| seller_zip_code_prefix | Seller ZIP code prefix |
| seller_city | Seller city |
| seller_state | Seller Brazilian state |

## Important Customer Identifier

`customer_id` represents an Olist customer record associated with an order.

`customer_unique_id` represents the actual customer across potentially multiple orders.

Customer retention, repeat purchasing, and customer-level revenue analysis therefore use `customer_unique_id`.
