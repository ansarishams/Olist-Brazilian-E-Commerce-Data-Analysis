# Olist Brazilian E-Commerce Data Analysis

## 📌 Project Overview

This project is an end-to-end Data Analysis project based on the Brazilian E-Commerce Public Dataset by Olist.

The main goal of this project was to understand how the business is performing from different angles such as sales, customers, customer retention, product categories, geography, and delivery performance.

I used SQL for data preparation and analysis, and Power BI to build an interactive dashboard and present the final business insights.

Instead of only looking at revenue numbers, I focused on questions that can actually help a business make better decisions.

---

## 🎯 Business Problem

An e-commerce business generates a large amount of data from orders, customers, products, payments, and deliveries.

The challenge is to convert this raw data into useful information that can answer questions like:

- How much revenue is the business generating?
- How are sales changing over time?
- Which product categories generate the most revenue?
- How many customers come back and purchase again?
- Which customer segments need attention?
- How reliable is the delivery process?
- Which locations generate the most revenue?
- Where are the major business opportunities?

This project answers these questions using SQL and Power BI.

---

# 📂 Dataset Documentation

## Brazilian E-Commerce Public Dataset by Olist

This project uses the **Brazilian E-Commerce Public Dataset by Olist**, a real-world e-commerce dataset containing information about orders, customers, products, sellers, payments, reviews and delivery.

The dataset was used to analyze sales performance, customer behavior, customer retention, RFM segments, delivery performance and geographic trends.

---

## 🔗 Dataset Source

**Dataset:** Brazilian E-Commerce Public Dataset by Olist  
**Platform:** Kaggle  
**Source:** [Kaggle Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

The original dataset is publicly available on Kaggle.

---

# 📊 Dataset Overview

The dataset contains multiple related tables. Each table provides a different part of the e-commerce business process.

The main tables used in the analysis are:

1. Customers
2. Orders
3. Order Items
4. Products
5. Sellers
6. Payments
7. Reviews
8. Geolocation
9. Product Category Translation

These tables were connected using their respective IDs and relationships before creating the analytical dataset used in Power BI.

---

# 🗂️ Dataset Tables & Columns

## 1. Customers

**Table:** `olist_customers_dataset.csv`

This table contains information about customers and their locations.

| Column | Description |
|---|---|
| `customer_id` | Unique identifier for each customer order record |
| `customer_unique_id` | Unique identifier for the actual customer |
| `customer_zip_code_prefix` | First five digits of the customer's ZIP code |
| `customer_city` | Customer's city |
| `customer_state` | Customer's state |

### Important Columns

`customer_unique_id` is especially important for customer analysis because the same customer can have multiple orders.

---

# 2. Orders

**Table:** `olist_orders_dataset.csv`

This table contains information about orders and their different stages.

| Column | Description |
|---|---|
| `order_id` | Unique identifier for each order |
| `customer_id` | Customer identifier |
| `order_status` | Current status of the order |
| `order_purchase_timestamp` | Date and time when the order was placed |
| `order_approved_at` | Date and time when the payment was approved |
| `order_delivered_carrier_date` | Date when the order was handed to the carrier |
| `order_delivered_customer_date` | Date when the order was delivered to the customer |
| `order_estimated_delivery_date` | Estimated delivery date |

### Important Columns

The order date and delivery date fields were important for:

- Revenue trends
- Monthly analysis
- Delivery time calculation
- Late delivery analysis

---

# 3. Order Items

**Table:** `olist_order_items_dataset.csv`

This table contains information about products included in each order.

| Column | Description |
|---|---|
| `order_id` | Order identifier |
| `order_item_id` | Sequential number identifying items within an order |
| `product_id` | Product identifier |
| `seller_id` | Seller identifier |
| `shipping_limit_date` | Seller shipping deadline |
| `price` | Price of the product |
| `freight_value` | Freight/shipping cost |

### Important Columns

The `price` and `freight_value` columns were used to analyze:

- Product revenue
- Order value
- Freight cost
- Category performance

---

# 4. Products

**Table:** `olist_products_dataset.csv`

This table contains product-level information.

| Column | Description |
|---|---|
| `product_id` | Unique product identifier |
| `product_category_name` | Product category |
| `product_name_lenght` | Length of product name |
| `product_description_lenght` | Length of product description |
| `product_photos_qty` | Number of product photos |
| `product_weight_g` | Product weight in grams |
| `product_length_cm` | Product length in centimeters |
| `product_height_cm` | Product height in centimeters |
| `product_width_cm` | Product width in centimeters |

### Important Columns

`product_category_name` was mainly used to analyze revenue by product category.

---

# 5. Sellers

**Table:** `olist_sellers_dataset.csv`

This table contains seller information.

| Column | Description |
|---|---|
| `seller_id` | Unique seller identifier |
| `seller_zip_code_prefix` | First five digits of seller ZIP code |
| `seller_city` | Seller's city |
| `seller_state` | Seller's state |

Seller information can be used to understand seller distribution and geographic performance.

---

# 6. Payments

**Table:** `olist_order_payments_dataset.csv`

This table contains payment information for orders.

| Column | Description |
|---|---|
| `order_id` | Order identifier |
| `payment_sequential` | Sequence number of payment |
| `payment_type` | Payment method |
| `payment_installments` | Number of installments |
| `payment_value` | Payment amount |

### Important Columns

`payment_type` was used to understand customer payment preferences.

Examples include:

- Credit Card
- Boleto
- Voucher
- Debit Card

---

# 7. Reviews

**Table:** `olist_order_reviews_dataset.csv`

This table contains customer review information.

| Column | Description |
|---|---|
| `review_id` | Unique review identifier |
| `order_id` | Order identifier |
| `review_score` | Customer review score |
| `review_comment_title` | Review title |
| `review_comment_message` | Review message |
| `review_creation_date` | Date when the review was created |
| `review_answer_timestamp` | Date when the review was answered |

The review table can be used to analyze customer satisfaction and review behavior.

---

# 8. Geolocation

**Table:** `olist_geolocation_dataset.csv`

This table contains geographic information associated with ZIP code prefixes.

| Column | Description |
|---|---|
| `geolocation_zip_code_prefix` | ZIP code prefix |
| `geolocation_lat` | Latitude |
| `geolocation_lng` | Longitude |
| `geolocation_city` | City |
| `geolocation_state` | State |

This table can be used for geographic and location-based analysis.

---

# 9. Product Category Translation

**Table:** `product_category_name_translation.csv`

This table provides English translations for Portuguese product category names.

| Column | Description |
|---|---|
| `product_category_name` | Original Portuguese category name |
| `product_category_name_english` | English category name |

This table helps make product category names easier to understand during analysis and visualization.

---

# 🔗 Main Table Relationships

The major relationships between the tables are:

```text
Customers
    │
    │ customer_id
    ↓
Orders
    │
    ├──────────────→ Order Payments
    │
    ├──────────────→ Order Reviews
    │
    │ order_id
    ↓
Order Items
    │
    ├──────────────→ Products
    │
    └──────────────→ Sellers
```
---

## 🛠️ Tools & Technologies

- **SQL**
- **PostgreSQL**
- **Power BI**
- **DAX**
- **Power Query**
- **Data Cleaning & Transformation**
- **RFM Analysis**
- **Data Visualization**
- **Business Analysis**

---

# 📊 Dashboard Structure

The Power BI dashboard contains 5 analytical pages.

### 1. Overview

A high-level view of the business performance.

Key areas covered:

- Total Revenue
- Total Orders
- Total Customers
- Average Order Value
- Revenue Trend
- Top Product Categories
- Revenue by State
- Delivery Performance
- Payment Methods

---

### 2. Sales Analysis

This page focuses on sales performance and revenue trends.

It helps answer:

- How is revenue changing over time?
- Which categories generate the most revenue?
- How does order volume change over time?
- What are the major sales patterns?

---

### 3. Customers & RFM

This page focuses on customer behavior and retention.

It includes:

- Total Customers
- Repeat Customers
- Repeat Customer Rate
- Average Order Value
- Revenue per Customer
- RFM Customer Segmentation
- Revenue by RFM Segment

The RFM analysis groups customers based on:

- Recency
- Frequency
- Monetary Value

---

### 4. Delivery & Logistics

This page focuses on delivery performance.

Key metrics include:

- On-Time Delivery %
- Late Delivery %
- Average Delivery Days
- Average Delivery Delay
- Average Freight Cost
- Late Deliveries by State

This helps identify potential logistics issues and locations that require attention.

---

### 5. Key Business Insights

The final page summarizes the most important findings from the analysis.

It includes:

- Executive Summary
- Sales Insights
- Customer Insights
- RFM Insights
- Delivery Insights
- Geographic Insights
- Business Recommendations

The purpose of this page is to turn the analysis into clear business actions.

---

# 📈 Key Results

Some of the major numbers from the analysis are:

| Metric | Result |
|---|---:|
| Delivered Revenue | 15.49M |
| Orders | 96.48K |
| Customers | 93.36K |
| Average Order Value | 160.55 |
| Revenue per Customer | 165.92 |
| Repeat Customers | 2.91K |
| Repeat Customer Rate | 3.12% |
| On-Time Delivery | 92.07% |
| Late Delivery | 7.93% |
| Average Delivery Time | 12.01 days |
| Average Freight per Order | 23.47 |

---

# 🔎 Key Business Findings

## 1. Health & Beauty is the Top Revenue Category

Health & Beauty generated around **1.42M** in revenue, making it the strongest-performing product category.

It was followed by:

- Watches & Gifts — around 1.27M
- Bed Bath & Table — around 1.24M
- Sports & Leisure — around 1.12M
- Computers — around 1.04M

This shows that a few categories contribute a significant share of overall revenue.

---

## 2. Repeat Customer Rate is Very Low

The analysis shows around **93.36K customers**, but only around **2.91K** customers made repeat purchases.

That gives a repeat customer rate of approximately **3.12%**.

This is one of the biggest opportunities identified in the project.

The business may be acquiring customers successfully, but converting those customers into repeat buyers appears to be a challenge.

---

## 3. At-Risk Customers Represent Significant Revenue

The RFM analysis shows that **At Risk** customers represent around **23.45%** of customers.

More importantly, this segment contributes approximately **5.3M** in revenue.

This means customer retention is not only a marketing opportunity but also a direct revenue opportunity.

---

## 4. Delivery Performance is Generally Strong

Around **92.07% of orders were delivered on time**, while approximately **7.93% were late**.

The average delivery time was around **12.01 days**.

Overall delivery performance looks strong, but the late deliveries still represent an area where operational improvements can reduce customer dissatisfaction.

---

## 5. São Paulo is the Largest Market

São Paulo generates approximately **5.8M** in revenue, making it the largest state by revenue.

However, it also has the highest number of late deliveries, with around **2,387 late orders**.

This makes São Paulo important from both a revenue and logistics perspective.

---

# 💡 Business Recommendations

Based on the analysis, I would recommend the following actions:

### 1. Focus on Customer Retention

The repeat customer rate is only 3.12%.

The business should test:

- Personalized offers
- Follow-up campaigns
- Product recommendations
- Loyalty programs
- Re-engagement campaigns

The goal should be to convert more first-time buyers into repeat customers.

---

### 2. Prioritize At-Risk Customers

At-Risk customers contribute significant revenue.

The business should identify high-value At-Risk customers and target them with:

- Personalized discounts
- Relevant product recommendations
- Reminder campaigns
- Loyalty incentives

---

### 3. Improve Logistics in São Paulo

São Paulo has the highest revenue as well as the highest number of late deliveries.

The business should investigate:

- Carrier performance
- Delivery routes
- Regional bottlenecks
- Warehouse capacity
- Delivery partner performance

---

### 4. Prepare for Periods of Higher Delivery Pressure

Delivery performance can change significantly during different periods.

The business should review:

- Carrier capacity
- Order volume
- Warehouse workload
- Delivery routes
- Seasonal demand

This can help reduce delivery delays during high-demand periods.

---

# 🔄 Analytical Workflow

The project followed a simple end-to-end analytics workflow:

### Step 1 — Understand the Data

I first explored the available tables and understood the relationships between:

- Customers
- Orders
- Order Items
- Products
- Sellers
- Payments
- Reviews
- Geolocation

---

### Step 2 — Data Preparation

The data was cleaned and transformed before analysis.

This included:

- Handling missing values
- Checking duplicate records
- Standardizing fields
- Creating useful date fields
- Combining relevant tables
- Creating business-related metrics

---

### Step 3 — SQL Analysis

PostgreSQL was used to:

- Join multiple tables
- Calculate business metrics
- Analyze revenue
- Analyze customer behavior
- Study delivery performance
- Create analytical views

---

### Step 4 — Power BI

The prepared data was imported into Power BI.

I then created:

- KPI cards
- Line charts
- Bar charts
- Donut charts
- Scatter plots
- Maps
- Interactive filters

---

### Step 5 — DAX

DAX was used to create important measures such as:

- Total Revenue
- Orders
- Customers
- Average Order Value
- Repeat Customer Rate
- Late Delivery %
- On-Time Delivery %
- Average Delivery Delay
- Revenue Growth

---

### Step 6 — Business Insights

Finally, I converted the analysis into business insights and recommendations instead of only presenting numbers.

---

# 📐 Important Metric Definitions

### Total Revenue

Revenue generated from delivered orders.

### Average Order Value

```text
AOV = Total Revenue / Total Orders
```
### Revenue per Customer

```text
Revenue per Customer = Total Revenue / Total Customers
```
### Repeat Customer Rate

```text
Repeat Customer Rate = Repeat Customers / Total Customers
```
### On-Time Delivery % 

```text
On-Time Delivery % = On-Time Orders / Total Orders
```
### Late Delivery %

```text
Late Delivery % = Late Orders / Total Orders
```

# 📁 Project Structure

```text
Olist-Brazilian-E-Commerce-Data-Analysis/
│
├── Dataset/
│   ├── olist_geolocation_dataset
│   |        ├──olist_geolocation_dataset_01.xlsx
|   |        └──olist_geolocation_dataset_02.xlsx
|   |        └──olist_geolocation_dataset_03.xlsx
|   |
|   ├──olist_closed_deals_dataset.csv
|   └──olist_customers_dataset.csv
|   └──olist_marketing_qualified_leads_dataset.csv
|   └──olist_order_items_dataset.csv
|   └──olist_order_payments_dataset.csv
|   └──olist_orders_dataset.csv
|   └──olist_products_dataset.csv
|   └──olist_sellers_dataset.csv
|   └──order_reviews_dataset.csv
|   └──product_category_name_translation.csv
|
|
├──Docs/
|   ├──dashboard-guide.md
|   └──dax-reference.md
|   └──key-insights.md
|   └──project-metadata.md
|   └──project-story.md
|
|
├── SQL/
│   ├── Analytical_insights.sql
│   └── README.md
│   └── ecommerce_solution.sql
|   └── marketing_solution.sql
|   └── table_schema.sql
|
|
├── PowerBI/
│   └── Olist_Ecommerce_Dashboard.pbit
│   └──README.md
|
|
├── Assets/
│   ├── Overview.png
|   └── Sales.png
|   └── Customer & RFM.png
│   └── Delivery & logistics.png
│   └── Key Insights.png
│
|
└── .gitignore
└── LICENSE
└── README.md
```

## 🙋‍♂️ Author


I am **SHAMSUL HODA** an aspiring **Data Analyst** focused on building practical skills in **SQL, Power BI, Excel and Data Analysis**.

I enjoy working with real-world business problems, analyzing data to find meaningful patterns, and turning those findings into clear dashboards and actionable business insights.

This project is part of my **Data Analyst portfolio**, where I am applying my SQL and Power BI skills to solve business problems and present data in a simple, decision-oriented way.

### 🔗 Connect With Me

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Shamsul%20Hoda-blue?logo=linkedin&logoColor=black)](https://www.linkedin.com/in/shamsul-hoda-s4632/)

[![GitHub](https://img.shields.io/badge/GitHub-AnsariShams-red?logo=github&logoColor=black)](https://github.com/ansarishams)

Feel free to ⭐ this repo if you found it useful!
