/*
===============================================================================
DDL Script: Create Analytics Views
===============================================================================
Script Purpose:
    This script creates views for the Analytics layer in the data warehouse. 
    The Analytics layer represents the final dimension and fact tables (Star Schema).

    Each view performs transformations and combines data from the Refined layer 
    to produce a clean, enriched, and business-ready dataset.

Usage:
    - These views can be queried directly for analytics and reporting.
===============================================================================
*/

-- =============================================================================
-- Create Dimension: analytics.dim_customers
-- =============================================================================
IF OBJECT_ID('analytics.dim_customers', 'V') IS NOT NULL
    DROP VIEW analytics.dim_customers;
GO

CREATE VIEW analytics.dim_customers AS
SELECT
    ROW_NUMBER() OVER (ORDER BY ci.cst_id) AS customer_key, -- Surrogate key
    ci.cst_id                          AS customer_id,
    ci.cst_key                         AS customer_number,
    ci.cst_firstname                   AS first_name,
    ci.cst_lastname                    AS last_name,
    la.cntry                           AS country,
    ci.cst_marital_status              AS marital_status,
    CASE 
        WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr
        ELSE COALESCE(ca.gen, 'n/a')
    END                                AS gender,
    ca.bdate                           AS birthdate,
    ci.cst_create_date                 AS create_date
FROM refined.crm_cust_info ci
LEFT JOIN refined.erp_cust_az12 ca
    ON ci.cst_key = ca.cid
LEFT JOIN refined.erp_loc_a101 la
    ON ci.cst_key = la.cid;
GO

-- =============================================================================
-- Create Dimension: analytics.dim_products
-- =============================================================================
IF OBJECT_ID('analytics.dim_products', 'V') IS NOT NULL
    DROP VIEW analytics.dim_products;
GO

CREATE VIEW analytics.dim_products AS
SELECT
    ROW_NUMBER() OVER (ORDER BY pn.prd_start_dt, pn.prd_key) AS product_key, -- Surrogate key
    pn.prd_id       AS product_id,
    pn.prd_key      AS product_number,
    pn.prd_nm       AS product_name,
    pn.cat_id       AS category_id,
    pc.cat          AS category,
    pc.subcat       AS subcategory,
    pc.maintenance  AS maintenance,
    pn.prd_cost     AS cost,
    pn.prd_line     AS product_line,
    pn.prd_start_dt AS start_date
FROM refined.crm_prd_info pn
LEFT JOIN refined.erp_px_cat_g1v2 pc
    ON pn.cat_id = pc.id
WHERE pn.prd_end_dt IS NULL;
GO

-- =============================================================================
-- Create Fact View: analytics.fact_sales
-- =============================================================================
IF OBJECT_ID('analytics.fact_sales', 'V') IS NOT NULL
    DROP VIEW analytics.fact_sales;
GO

CREATE VIEW analytics.fact_sales AS
SELECT
    sd.sls_ord_num  AS order_number,
    pr.product_key  AS product_key,
    cu.customer_key AS customer_key,
    sd.sls_order_dt AS order_date,
    sd.sls_ship_dt  AS shipping_date,
    sd.sls_due_dt   AS due_date,
    sd.sls_sales    AS sales_amount,
    sd.sls_quantity AS quantity,
    sd.sls_price    AS price
FROM refined.crm_sales_details sd
LEFT JOIN analytics.dim_products pr
    ON sd.sls_prd_key = pr.product_number
LEFT JOIN analytics.dim_customers cu
    ON sd.sls_cust_id = cu.customer_id;
GO
