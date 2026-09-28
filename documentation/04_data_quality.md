# Data Quality

## Overview

The Olist dataset contains approximately 100,000 orders and multiple related tables covering customers, products, payments, reviews, sellers, and geographic information.

Several checks were performed before analysis.

## Missing Values

The customer table contains no missing values in the key customer identifier, city, and state fields checked.

The orders table contains no missing purchase timestamps or order statuses.

Some orders have a missing delivery date. This is expected for orders that were not successfully delivered or did not reach a completed delivery stage.

## Customer Identifier

The dataset contains both `customer_id` and `customer_unique_id`.

`customer_id` identifies an Olist customer record associated with an order, while `customer_unique_id` identifies the actual customer across multiple orders.

Using the wrong identifier can incorrectly classify customers as one-time customers.

Customer-level retention and repeat-purchase analysis therefore uses `customer_unique_id`.

## Order and Payment Grain

Orders contain one row per order.

Order items contain one row per product line within an order.

Payment records can contain multiple rows for the same order.

For this reason, payment values were aggregated to the order level before calculating metrics such as average order value.

## Revenue Definitions

Payment-based revenue uses `order_payments.payment_value`.

Product-category and seller item revenue uses `order_items.price`.

These measures are kept separate to avoid incorrectly multiplying payment values when joining payment and item-level tables.

## Delivery Data

Orders without a recorded delivery date are excluded from delivery-performance calculations.

Late delivery is defined as:

`order_delivered_customer_date > order_estimated_delivery_date`

Orders delivered on or before the estimated date are considered on time.

## Data Limitations

The dataset represents historical e-commerce activity from the Olist marketplace and does not represent the entire Brazilian e-commerce market.

The analysis identifies patterns and associations in the dataset but does not establish causal relationships.
