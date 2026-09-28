# Olist Customer Retention & Revenue Analysis

## Overview

This project analyzes the Olist Brazilian E-Commerce Public Dataset using PostgreSQL to investigate customer retention, repeat purchasing, revenue distribution, product categories, geography, and delivery performance.

The project focuses on turning raw transactional data into business-relevant insights using SQL.

## Business Questions

The analysis investigates:

- How many unique customers are represented in the dataset?
- What percentage of customers make repeat purchases?
- How does repeat purchasing change over time?
- Which states have the highest customer retention?
- How much revenue comes from repeat customers?
- Which product categories generate the most revenue?
- Is revenue concentrated among a small number of customers?
- How does delivery performance relate to customer review scores?
- How does customer retention change across acquisition cohorts?

## Dataset

The project uses the Olist Brazilian E-Commerce Public Dataset.

The dataset contains approximately 100,000 orders covering 2016–2018 and includes information about customers, orders, products, sellers, payments, reviews, and geography.

## Tools

- PostgreSQL
- DBeaver
- SQL
- GitHub

## Analysis Areas

### Customer Metrics
Customer counts, one-time customers, repeat customers, repeat customer rate, average orders per customer, and average customer revenue.

### Order Metrics
Order volume, monthly order trends, average items per order, average order value, and order status distribution.

### Revenue Analysis
Total revenue, monthly revenue, product-category revenue, geographic revenue, and revenue concentration.

### Customer Retention
Repeat customer rates, repeat revenue, cohort analysis, and retention matrices.

### Category Analysis
Customer reach, repeat purchasing, and revenue by product category.

### Geography
Customer distribution, revenue, and repeat purchasing by Brazilian state.

### Delivery Performance
On-time delivery, late delivery rates, review scores, and repeat purchasing behavior.

## Key Findings

The final analysis identifies:

- The size and purchasing behavior of the customer base.
- The proportion of customers who return for additional purchases.
- Revenue contribution from repeat customers.
- Product categories with the strongest revenue contribution.
- Geographic differences in customer behavior.
- The relationship between delivery performance and review scores.
- Customer retention patterns across acquisition cohorts.
- The concentration of revenue among high-value customers.

## Data Quality

The analysis includes checks for missing values, delivery-date availability, customer identifiers, and potential row multiplication when joining tables with different levels of detail.

Special attention was given to the distinction between `customer_id` and `customer_unique_id`.

## Project Structure

```text
olist-customer-retention-sql/
├── README.md
├── sql/
│   ├── 01_database_overview.sql
│   ├── 02_customer_metrics.sql
│   ├── 03_order_metrics.sql
│   ├── 04_revenue_metrics.sql
│   ├── 05_customer_behavior.sql
│   ├── 06_repeat_customers.sql
│   ├── 07_category_analysis.sql
│   ├── 08_geography_analysis.sql
│   ├── 09_delivery_analysis.sql
│   ├── 10_customer_cohorts.sql
│   ├── 11_retention_analysis.sql
│   ├── 12_customer_ranking.sql
│   ├── 13_revenue_concentration.sql
│   └── 14_repeat_customer_revenue.sql
├── documentation/
│   ├── business_problem.md
│   ├── data_dictionary.md
│   ├── schema.md
│   ├── data_quality.md
│   └── analysis.md
└── images/
    ├── schema.png
    ├── retention_matrix.png
    └── key_findings.png
