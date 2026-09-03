# Database Schema

The analysis uses the Olist Brazilian E-Commerce dataset.

## Core Relationships

- customers → orders
- orders → order_items
- orders → order_payments
- orders → order_reviews
- order_items → products
- order_items → sellers
- products → product_category_translation

## Customer Identification

`customer_id` identifies a customer record associated with an order.

`customer_unique_id` identifies the underlying customer across orders and
is therefore used to identify repeat customers.

## Analytical Model

The primary analysis uses:

customers
    ↓
orders
↓
order_items
↓
products

Additional analysis uses:

orders → order_payments
orders → order_reviews
