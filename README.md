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
Revenue per Customer = Total Revenue / Total Customers
Repeat Customer Rate = Repeat Customers / Total Customers
