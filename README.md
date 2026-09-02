# Olist Brazilian E-Commerce Data Analysis

A portfolio-ready **Data Analyst project** using PostgreSQL, SQL and Power BI to analyze sales, customers, RFM segments and delivery performance.

The goal was simple: turn raw e-commerce data into clear business findings and practical actions.

## Dashboard Pages

1. **Executive Overview** — overall business performance
2. **Sales Analysis** — revenue, orders, categories and states
3. **Customers & RFM** — customer value, repeat purchases and RFM segments
4. **Delivery & Logistics** — delivery reliability, delays and freight
5. **Key Business Insights** — findings and recommendations

## Business Questions

### Overview
- How is the business performing overall?
- What are the main KPIs?
- How is revenue changing?

### Sales
- Which categories generate the most revenue?
- Which states contribute the most revenue?
- How does revenue change over time?
- What is the average order value?

### Customers & RFM
- How many customers are repeat buyers?
- Which RFM segments are most valuable?
- Which customers are at risk?
- Where is the biggest retention opportunity?

### Delivery
- What percentage of orders arrive on time?
- How long does delivery take?
- Which states have the most late deliveries?
- How does freight relate to delivery delay?

## Tools

- **PostgreSQL** — database and SQL analysis
- **SQL** — joins, validation, aggregations and business questions
- **Power BI** — modeling, DAX and interactive reporting
- **Power Query** — data preparation
- **DAX** — KPI and time-based calculations

## Key Results

- **15.49M** delivered revenue
- **96.48K** orders
- **160.55** average order value
- **4.33%** MoM revenue growth
- **3.12%** repeat customer rate
- **92.07%** on-time delivery
- **7.93%** late delivery
- **12.01 days** average delivery time
- **8.74 days** average delay among late orders
- **São Paulo** is the largest revenue market and also has the highest number of late deliveries

## Key Findings

### Sales
Health & Beauty is the highest-revenue category at approximately **1.42M**, followed by Watches & Gifts (**1.27M**) and Bed Bath & Table (**1.24M**).

Monthly revenue shows noticeable variation, reaching around **1.7M in May** and dropping to roughly **0.7M in September** before recovering.

### Customers
Only **2.91K of 93.36K customers** are repeat customers, giving a repeat customer rate of about **3.12%**.

The **At-Risk** segment represents about **23.45%** of customers and contributes approximately **5.3M** in revenue.

### Delivery
Overall delivery reliability is strong: **92.07%** of orders were delivered on time.

Average delivery time improved to around **8.6 days in August**, but increased to about **14.8 days by December**.

### Geography
São Paulo generates approximately **5.8M** in revenue and records the highest number of late deliveries at **2,387**.

## Business Recommendations

1. **Improve customer retention** with targeted re-engagement and personalized offers.
2. **Protect At-Risk revenue** by prioritizing high-value customers before they become inactive.
3. **Optimize São Paulo logistics** by reviewing carrier performance, routes and bottlenecks.
4. **Prepare for year-end delivery pressure** by reviewing capacity before periods of slower delivery.

## Analytical Workflow

```text
Raw Olist Data
      ↓
PostgreSQL
      ↓
SQL Cleaning & Validation
      ↓
Analysis-Ready Views
      ↓
Power BI
      ↓
Data Model + DimDate
      ↓
DAX Measures
      ↓
Dashboard
      ↓
Key Insights
      ↓
Business Recommendations
```

## Metric Definitions

### Average Order Value
`Delivered Revenue / Number of Orders`

### Repeat Customer Rate
`Repeat Customers / Total Customers`

### Delivery Status
```text
is_late_delivery = 0 → On-Time
is_late_delivery = 1 → Late
```

### Late Delivery Rate
`Late Orders / Total Orders`

### Average Delivery Delay
Calculated only for late orders so the KPI represents the average number of days an order was actually late.

## Repository Structure

```text
Olist_Ecommerce_Data_Analysis/
├── README.md
├── LICENSE
├── .gitignore
├── assets/
│   └── key-insights-layout.png
├── docs/
│   ├── project-story.md
│   ├── key-insights.md
│   ├── dax-reference.md
│   ├── dashboard-guide.md
│   └── project-metadata.md
├── sql/
│   └── README.md
└── power_bi/
    └── README.md
```

## Power BI File

The working `.pbix` file is not included automatically because it exists in the local Power BI environment. If you want to share it, add it as:

`power_bi/Olist_Ecommerce_Analysis.pbix`

The raw dataset is also intentionally not included.

## What This Project Demonstrates

- SQL data analysis
- PostgreSQL
- Data validation
- Business-focused KPIs
- Power BI data modeling
- DAX
- RFM segmentation
- Time-based analysis
- Dashboard design
- Business insights and recommendations

This project is designed as a practical portfolio piece for an entry-level Data Analyst role.
