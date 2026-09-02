/* ======================================================================
   BRAZILIAN E-COMMERCE (OLIST) DATASET - FULL SQL ANALYSIS
   ======================================================================
   Tables used (standard Kaggle Olist schema):
   1. olist_orders_dataset
   2. olist_order_items_dataset
   3. olist_customers_dataset
   4. olist_sellers_dataset
   5. olist_order_payments_dataset
   6. olist_order_reviews_dataset
   7. olist_products_dataset
   8. product_category_name_translation
   9. olist_geolocation_dataset
   ====================================================================== */


/* ======================================================================
   SECTION 0: DATA QUALITY / CLEANING CHECKS (run these first)
   ====================================================================== */

-- 0.1 Null check - delivery dates
SELECT
    COUNT(*) AS total_orders,
    SUM(CASE WHEN order_delivered_customer_date IS NULL THEN 1 ELSE 0 END) AS null_delivered_date,
    SUM(CASE WHEN order_approved_at IS NULL THEN 1 ELSE 0 END) AS null_approved_date
FROM orders;

-- 0.2 Duplicate order_id check
SELECT order_id, COUNT(*) AS cnt
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- 0.3 Orphan records check (order_items without matching order)
SELECT oi.order_id
FROM order_items oi
LEFT JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

-- 0.4 Products without category translation
SELECT DISTINCT p.product_category_name
FROM products p
LEFT JOIN category_name_translation t
    ON p.product_category_name = t.product_category_name
WHERE t.product_category_name_english IS NULL;


/* ======================================================================
   SECTION 1: SALES TREND ANALYSIS
   ====================================================================== */

-- 1.1 Monthly revenue, orders, AOV
SELECT
    DATE_TRUNC('month', o.order_purchase_timestamp) AS order_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price + oi.freight_value)::numeric, 2) AS total_revenue,
    ROUND(SUM(oi.price + oi.freight_value)::numeric / COUNT(DISTINCT o.order_id), 2) AS avg_order_value
FROM orders  o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY DATE_TRUNC('month', o.order_purchase_timestamp
ORDER BY order_month;

-- 1.2 YoY growth

SELECT
    EXTRACT(YEAR FROM order_purchase_timestamp) AS order_year,
    ROUND(SUM(oi.price + oi.freight_value)::numeric, 2) AS yearly_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY EXTRACT(YEAR FROM order_purchase_timestamp)
ORDER BY order_year


/* ======================================================================
   SECTION 2: CUSTOMER ANALYSIS (New vs Repeat + RFM)
   ====================================================================== */

-- 2.1 New vs Repeat customers (based on customer_unique_id)
SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    CASE WHEN COUNT(DISTINCT o.order_id) = 1 THEN 'New' ELSE 'Repeat' END AS customer_type
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_unique_id;

-- 2.2 RFM base table
WITH rfm_base AS (
    SELECT
        c.customer_unique_id,
        MAX(o.order_purchase_timestamp) AS last_purchase_date,
        COUNT(DISTINCT o.order_id) AS frequency,
        SUM(oi.price + oi.freight_value) AS monetary
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    JOIN order_items oi ON o.order_id = oi.order_i
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
)
SELECT
    customer_unique_id,
    (SELECT MAX(order_purchase_timestamp) FROM orders) - last_purchase_date AS recency_days,
    frequency,
    ROUND(monetary::numeric, 2) AS monetary
FROM rfm_base;


/* ======================================================================
   SECTION 3: PRODUCT / CATEGORY PERFORMANCE
   ====================================================================== */

-- 3.1 Revenue by category (English name)
SELECT
    t.product_category_name_english AS category,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    SUM(oi.price) AS total_revenue,
    ROUND(AVG(oi.price)::numeric, 2) AS avg_price
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN category_name_translation t ON p.product_category_name = t.product_category_name
JOIN orders o ON oi.order_id = o.order_i
WHERE o.order_status = 'delivered'
GROUP BY t.product_category_name_english
ORDER BY total_revenue DESC;


/* ======================================================================
   SECTION 4: SELLER PERFORMANCE
   ====================================================================== */

-- 4.1 Top sellers by revenue + avg review score


/* ======================================================================
   SECTION 5: DELIVERY / LOGISTICS ANALYSIS
   ====================================================================== */

-- 5.1 Delivery performance by state
SELECT
    c.customer_state,
    COUNT(o.order_id) AS total_orders,
    ROUND(AVG(EXTRACT(DAY FROM (o.order_delivered_customer_date - o.order_purchase_timestamp)))::numeric, 1) AS avg_delivery_days,
    SUM(CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 1 ELSE 0 END) AS late_deliveries,
    ROUND(100.0 * SUM(CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 1 ELSE 0 END) / COUNT(o.order_id), 2) AS late_delivery_pct
FROMorder o
JOINcustomerc ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY late_delivery_pct DESC;

-- 5.2 Delivery delay vs review score correlation (raw data for BI)
SELECT
    o.order_id,
    EXTRACT(DAY FROM (o.order_delivered_customer_date - o.order_estimated_delivery_date)) AS delay_days,
    r.review_score
FROM orders o
JOIN order_reviews r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL;


/* ======================================================================
   SECTION 6: PAYMENT ANALYSIS
   ====================================================================== */

-- 6.1 Payment type distribution
SELECT
    payment_type,
    COUNT(*) AS total_payments,
    ROUND(AVG(payment_installments)::numeric, 1) AS avg_installments,
    ROUND(SUM(payment_value)::numeric, 2) AS total_payment_value,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_of_total
FROM payments
GROUP BY payment_type
ORDER BY total_payment_value DESC;


/* ======================================================================
   SECTION 7: REVIEW ANALYSIS
   ====================================================================== */

-- 7.1 Avg review score trend + distribution



/* ======================================================================
   SECTION 8: GEOGRAPHIC ANALYSIS
   ====================================================================== */

-- 8.1 State-wise orders, revenue, freight
SELECT
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price)::numeric, 2) AS total_revenue,
    ROUND(SUM(oi.freight_value)::numeric, 2) AS total_freight,
    ROUND(AVG(oi.freight_value)::numeric, 2) AS avg_freight_per_item
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY total_revenue DESC;


/* ======================================================================
   SECTION 9: ORDER STATUS FUNNEL
   ====================================================================== */



/* ======================================================================
   SECTION 10: FREIGHT / PRICE RATIO ANALYSIS
   ====================================================================== */



/* ======================================================================
   SECTION 11: CUSTOMER COHORT ANALYSIS (Month-over-month retention)
   ====================================================================== */

WITH first_purchase AS (
    -- First purchase month for each customer = their cohort
    SELECT
        c.customer_unique_id,
        DATE_TRUNC('month', MIN(o.order_purchase_timestamp)) AS cohort_month
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
),
orders_with_cohort AS (
    -- Every order tagged with its customer's cohort month + the order's own month
    SELECT
        fp.customer_unique_id,
        fp.cohort_month,
        DATE_TRUNC('month', o.order_purchase_timestamp) AS order_month
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    JOIN first_purchase fp ON c.customer_unique_id = fp.customer_unique_id
    WHERE o.order_status = 'delivered'
)
SELECT
    cohort_month,
    -- month_number = 0 is the acquisition month itself, 1 = 1 month later, etc.
    EXTRACT(YEAR FROM AGE(order_month, cohort_month)) * 12
        + EXTRACT(MONTH FROM AGE(order_month, cohort_month)) AS month_number,
    COUNT(DISTINCT customer_unique_id) AS active_customers
FROM orders_with_cohort
GROUP BY cohort_month, mont_number
ORDER BY cohort_month, month_number;

-- 11.1 Cohort size (denominator, for retention % calc in Power BI)


/* ======================================================================
   SECTION 12: RFM SEGMENTATION (Champions / Loyal / At Risk / Lost etc.)
   ====================================================================== */

WITH rfm_base AS (
    SELECT
        c.customer_unique_id,
        MAX(o.order_purchase_timestamp) AS last_purchase_date,
        COUNT(DISTINCT o.order_id) AS frequency,
        SUM(oi.price + oi.freight_value) AS monetary
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
),
rfm_calc AS (
    SELECT
        customer_unique_id,
        EXTRACT(DAY FROM ((SELECT MAX(order_purchase_timestamp) FROM orders) - last_purchase_date)) AS recency_days,
        frequency,
        monetary
    FROM rfm_base
),
rfm_scored AS (
    SELECT
        customer_unique_id,
        recency_days,
        frequency,
        monetary,
        -- 1 = worst, 5 = best on each dimension (quintile-based scoring)
        NTILE(5) OVER (ORDER BY recency_days DESC) AS r_score,
        NTILE(5) OVER (ORDER BY frequency ASC)     AS f_score,
        NTILE(5) OVER (ORDER BY monetary ASC)      AS m_score
    FROM rfm_calc
)
SELECT
    customer_unique_id,
    recency_days,
    frequency,
    ROUND(monetary::numeric, 2) AS monetary,
    r_score, f_score, m_score,
    (r_score + f_score + m_score) AS rfm_total_score,
    CASE
        WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4 THEN 'Champions'
        WHEN r_score >= 3 AND f_score >= 3 THEN 'Loyal Customers'
        WHEN r_score >= 4 AND f_score <= 2 THEN 'New Customers'
        WHEN r_score <= 2 AND f_score >= 3 THEN 'At Risk'
        WHEN r_score <= 2 AND f_score <= 2 AND m_score <= 2 THEN 'Lost'
        ELSE 'Needs Attention'
    END AS customer_segment
FROM rfm_scored
ORDER BY rfm_total_score DESC;

/* ======================================================================
   SECTION 13: SELLER SLA / DISPATCH RELIABILITY
   ====================================================================== */




/* ======================================================================
   SECTION 14: TIME-TO-REVIEW ANALYSIS
   ====================================================================== */

SELECT
    o.order_id,
    o.order_delivered_customer_date,
    r.review_creation_date,
    EXTRACT(DAY FROM (r.review_creation_date - o.order_delivered_customer_date)) AS days_to_review,
    r.review_score
FROM orders o
JOIN order_reviews r ON o.order_id = r.order_id
WHERE o.order_delivered_customer_date IS NOT NULL;


 
/* ======================================================================
   SECTION 15: SELLER MARKETING FUNNEL ANALYSIS
   Tables added: olist_marketing_qualified_leads_dataset, olist_closed_deals_dataset
   Note: this is Olist's OWN seller-acquisition funnel (how sellers were
   recruited onto the platform) - not customer-facing marketing.
   ====================================================================== */
 
-- 15.1 Lead-to-Deal conversion rate (overall)
SELECT
    COUNT(DISTINCT mql.mql_id) AS total_leads,
    COUNT(DISTINCT cd.mql_id) AS converted_leads,
    ROUND(100.0 * COUNT(DISTINCT cd.mql_id) / NULLIF(COUNT(DISTINCT mql.mql_id),0), 2) AS conversion_rate_pct
FROM marketing_qualified_leads mql
LEFT JOIN marketing_closed_deals cd ON mql.mql_id = cd.mql_id;
 
-- 15.2 Conversion rate by lead origin (channel)

 
-- 15.3 Sales rep performance (deals closed, business type mix)

 
-- 15.4 Time-to-conversion (lead first contact date -> deal won date)
SELECT
    cd.mql_id,
    mql.first_contact_date,
    cd.won_date,
    cd.won_date::date - mql.first_contact_date::date AS days_to_convert,
    mql.origin,
    cd.business_segment
FROM marketing_qualified_leads mql
JOIN marketing_closed_deals cd ON mql.mql_id = cd.mql_id
WHERE cd.won_date IS NOT NULL;
 
-- 15.5 ROI: revenue generated by sellers who came through the marketing funnel
SELECT
    cd.business_segment,
    cd.lead_type,
    COUNT(DISTINCT cd.seller_id) AS sellers_onboarded,
    ROUND(SUM(m.total_item_value)::numeric, 2) AS revenue_generated,
    ROUND(SUM(m.total_item_value) / NULLIF(COUNT(DISTINCT cd.seller_id),0), 2) AS avg_revenue_per_seller
FROM marketing_closed_deals cd
JOIN vw_master m ON cd.seller_id = m.seller_id
WHERE m.order_status = 'delivered'
GROUP BY cd.business_segment, cd.lead_type
ORDER BY revenue_generated DESC;
 
 
/* ======================================================================
   THIRD VIEW: SELLER MARKETING FUNNEL (Power BI import)
   Grain: 1 row per closed deal (i.e. per onboarded seller)
   Relate to vw_olist_master on seller_id (1-to-many) to bring in
   post-onboarding revenue/order performance.
   ====================================================================== */
CREATE OR REPLACE VIEW vw_seller_marketing_funnel AS
SELECT
    mql.mql_id,
    mql.first_contact_date,
    mql.landing_page_id,
    mql.origin AS lead_origin,
 
    cd.seller_id,
    cd.sdr_id,
    cd.sr_id AS sales_rep_id,
    cd.won_date,
    cd.business_segment,
    cd.lead_type,
    cd.lead_behaviour_profile,
    cd.business_type,
    cd.declared_monthly_revenue,
 
    cd.won_date::date - mql.first_contact_date::date AS days_to_convert,
    EXTRACT(YEAR FROM cd.won_date::Date)  AS won_year,
    EXTRACT(MONTH FROM cd.won_date::Date) AS won_month_num,
    TO_CHAR(cd.won_date::Date, 'YYYY-MM') AS won_year_month
 
FROM marketing_qualified_leads mql
LEFT JOIN marketing_closed_deals cd ON mql.mql_id = cd.mql_id;
 

/* ======================================================================
   ======================================================================
   MASTER VIEW FOR POWER BI IMPORT
   Grain: 1 row per order_item (most granular, Power BI DAX will aggregate)
   This single view covers ALL columns needed for every page/KPI/visual
   discussed: Sales, Customer, Product, Seller, Delivery, Payment, Review,
   Geography, Order Status, Freight.
   ======================================================================
   ====================================================================== */

CREATE OR REPLACE VIEW vw_master AS
SELECT
    -- Order-item grain identifiers
    oi.order_id,
    oi.order_item_id,
    oi.product_id,
    oi.seller_id,
    oi.shipping_limit_date,
    CASE WHEN o.order_delivered_carrier_date <= oi.shipping_limit_date
         THEN 1 ELSE 0 END AS is_on_time_dispatch,

    -- Order info
    o.customer_id,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_approved_at,
    o.order_delivered_carrier_date,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,

    -- Date parts (pre-computed for easy DAX / slicers)
    EXTRACT(YEAR FROM o.order_purchase_timestamp)  AS order_year,
    EXTRACT(MONTH FROM o.order_purchase_timestamp) AS order_month_num,
    TO_CHAR(o.order_purchase_timestamp, 'YYYY-MM') AS order_year_month,

    -- Delivery metrics (pre-computed, avoids date-diff DAX)
    EXTRACT(DAY FROM (o.order_delivered_customer_date - o.order_purchase_timestamp))   AS delivery_days_actual,
    EXTRACT(DAY FROM (o.order_estimated_delivery_date - o.order_purchase_timestamp))   AS delivery_days_estimated,
    EXTRACT(DAY FROM (o.order_delivered_customer_date - o.order_estimated_delivery_date)) AS delivery_delay_days,
    CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date
         THEN 1 ELSE 0 END AS is_late_delivery,

    -- Customer info
    c.customer_unique_id,
    c.customer_city,
    c.customer_state,
    c.customer_zip_code_prefix,

    -- Seller info
    s.seller_city,
    s.seller_state,
    s.seller_zip_code_prefix,

    -- Product info
    p.product_category_name,
    t.product_category_name_english,
    p.product_weight_g,
    p.product_length_cm,
    p.product_height_cm,
    p.product_width_cm,

    -- Financials
    oi.price,
    oi.freight_value,
    (oi.price + oi.freight_value) AS total_item_value,
    ROUND((oi.freight_value / NULLIF(oi.price,0))::numeric, 3) AS freight_to_price_ratio,

    -- Payment (aggregated per order since payments can be multiple rows/order)
    pay.payment_type,
    pay.payment_installments,
    pay.payment_value,

    -- Review
    rev.review_score,
    rev.review_creation_date,
    rev.review_answer_timestamp

FROM order_items oi
JOIN orders o        ON oi.order_id = o.order_id
JOIN customers c     ON o.customer_id = c.customer_id
JOIN sellers s       ON oi.seller_id = s.seller_id
LEFT JOIN products p ON oi.product_id = p.product_id
LEFT JOIN category_name_translation t
       ON p.product_category_name = t.product_category_name
LEFT JOIN order_reviews rev
       ON o.order_id = rev.order_id
LEFT JOIN (
    -- one payment row per order (main payment method = highest payment_value)
    SELECT DISTINCT ON (order_id)
        order_id, payment_type, payment_installments, payment_value
    FROM payments
    ORDER BY order_id, payment_value DESC
) pay ON o.order_id = pay.order_id;

/* ======================================================================
   SECOND VIEW: CUSTOMER-GRAIN RFM SEGMENTS + COHORT MONTH
   Grain: 1 row per customer_unique_id
   Import this ALONGSIDE vw_olist_master and relate on customer_unique_id
   in Power BI. Needed separately because RFM/cohort are customer-level,
   not order-item-level, and mixing grains in one view causes wrong totals.
   ====================================================================== */

CREATE OR REPLACE VIEW vw_customer_rfm_segment AS
WITH rfm_base AS (
    SELECT
        c.customer_unique_id,
        MIN(o.order_purchase_timestamp) AS first_purchase_date,
        MAX(o.order_purchase_timestamp) AS last_purchase_date,
        COUNT(DISTINCT o.order_id) AS frequency,
        SUM(oi.price + oi.freight_value) AS monetary
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
),
rfm_calc AS (
    SELECT
        customer_unique_id,
        DATE_TRUNC('month', first_purchase_date) AS cohort_month,
        EXTRACT(DAY FROM ((SELECT MAX(order_purchase_timestamp) FROM orders) - last_purchase_date)) AS recency_days,
        frequency,
        monetary
    FROM rfm_base
),
rfm_scored AS (
    SELECT
        customer_unique_id,
        cohort_month,
        recency_days,
        frequency,
        monetary,
        NTILE(5) OVER (ORDER BY recency_days DESC) AS r_score,
        NTILE(5) OVER (ORDER BY frequency ASC)     AS f_score,
        NTILE(5) OVER (ORDER BY monetary ASC)      AS m_score
    FROM rfm_calc
)
SELECT
    customer_unique_id,
    cohort_month,
    recency_days,
    frequency,
    ROUND(monetary::numeric, 2) AS monetary,
    r_score, f_score, m_score,
    (r_score + f_score + m_score) AS rfm_total_score,
    CASE
        WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4 THEN 'Champions'
        WHEN r_score >= 3 AND f_score >= 3 THEN 'Loyal Customers'
        WHEN r_score >= 4 AND f_score <= 2 THEN 'New Customers'
        WHEN r_score <= 2 AND f_score >= 3 THEN 'At Risk'
        WHEN r_score <= 2 AND f_score <= 2 AND m_score <= 2 THEN 'Lost'
        ELSE 'Needs Attention'
    END AS customer_segment
FROM rfm_scored;


/* ======================================================================
   HOW TO USE IN POWER BI:
   1. Get Data -> Database (Postgres/MySQL/SQL Server connector)
   2. Import "vw_olist_master" (order-item grain - Sales/Product/Delivery/
      Payment/Review/Seller SLA pages use this)
   3. Import "vw_customer_rfm_segment" (customer grain - Customer
      Segmentation + Cohort pages use this)
   4. Relate the two: vw_customer_rfm_segment[customer_unique_id]
      -> vw_olist_master[customer_unique_id] (1-to-many)
   5. Also import: olist_geolocation_dataset separately (for map lat/lng,
      since it's zip-prefix grain and would cause row explosion if joined
      into the master view directly)
   6. In Power BI, create a Date table and mark it as Date table for
      proper time-intelligence DAX (SAMEPERIODLASTYEAR, MoM growth etc.)
   ====================================================================== */