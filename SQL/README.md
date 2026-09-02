# SQL

This folder is for the PostgreSQL analysis and Power BI source views used in the project.

Recommended structure:

```text
sql/
├── 01_Analytical_insights.sql
├── 02_ecommerce_solution.sql
├── 03_marketing_solution.sql
├── 04_table_schema.sql
```

## SQL work covered

### Data validation
- Duplicate checks
- Null checks
- Date-range checks
- Order-status validation
- Delivery calculation validation

### Sales
- Revenue
- Orders
- Average order value
- Monthly trends
- Category performance
- State performance

### Customer
- Unique customers
- Repeat customers
- RFM scores
- RFM segments
- Revenue by segment

### Delivery
- Actual vs estimated delivery
- Late-delivery flag
- On-time rate
- Average delivery time
- Late deliveries by state
- Freight analysis

Add the exact SQL queries used in the local project before publishing if you want the repository to be fully reproducible.

Never commit database passwords, connection strings or other credentials.
