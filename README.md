# Enterprise Retail Analytics Data Warehouse

A comprehensive data warehousing solution designed to transform raw ERP and CRM data into actionable business insights using a robust Medallion Architecture (Staging, Refine, Analytics).

## 🏗️ Data Architecture

The project follows a layered data architecture to ensure data quality and analytical readiness:

1.  **Staging Layer** (`etl_staging`): Ingests raw data from **CRM** and **ERP** source systems (CSV format) into the data warehouse.
2.  **Refine Layer** (`etl_refine`): Cleanses, standardizes, and integrates data. Handles deduping, null handling, and domain value mapping.
3.  **Analytics Layer** (`analytics_models`): Models data into a Star Schema (Dimensions and Facts) optimized for reporting and dashboarding.

### Key Layers
- **Staging**: `staging.crm_*`, `staging.erp_*`
- **Refine**: `refined.crm_*`, `refined.erp_*`
- **Analytics**: `analytics.dim_customers`, `analytics.dim_products`, `analytics.fact_sales`

## 📂 Project Structure

root/
├── etl_staging_refine_analytics/        # ETL scripts (DDL & Stored Procedures)
│   ├── etl_staging/                     # Staging layer: raw → structured
│   │   ├── ddl_staging.sql
│   │   ├── proc_load_staging.sql
│   │   └── init_database.sql
│   │
│   ├── etl_refine/                      # Refined layer: clean & transform
│   │   ├── ddl_refined.sql
│   │   └── proc_load_refined.sql
│   │
│   └── analytics_models/                # Analytics layer: star schema views
│       └── ddl_analytics.sql
│
├── raw_data_sources/                    # Raw source datasets (CSV)
│   ├── source_crm/                      # CRM source data
│   └── source_erp/                      # ERP source data
│
├── quality_checks/                      # Data quality & integrity checks
│   ├── quality_checks_refined.sql
│   └── quality_checks_analytics.sql
│
├── documentation/                       # Architecture & data flow diagrams
│   ├── data_architecture.png
│   ├── data_flow.png
│   ├── data_integration.png
│   └── data_model.png
│
└── README.md                            # Project documentation

```

## 🚀 Getting Started

### Prerequisites
- **SQL Server** (Express or Developer Edition)
- **SQL Server Management Studio (SSMS)** or Azure Data Studio

### Installation & Execution

1.  **Clone the Repository**
    ```bash
    git clone https://github.com/your-username/enterprise-retail-analytics.git
    ```

2.  **Initialize Database**
    Run the initialization script to create the database and schemas:
    - Path: `etl_staging_refine_analytics/init_database.sql`

3.  **Run ETL Process**
    Execute the stored procedures in the following order:

    ```sql
    -- 1. Load Staging Layer (Source -> Staging)
    EXEC staging.load_staging;

    -- 2. Load Refine Layer  (Staging -> Refine)
    EXEC refined.load_refined;

    -- Analytics views are created via DDL and reflect data automatically.
    ```

4.  **Verify Data Quality**
    Run checks in `quality_checks/` to ensure data accuracy.

## 📊 Analytics & Insights
The **Analytics Layer** enables analysis of:
- **Sales Performance**: Revenue, quantity, and trends over time.
- **Customer Demographics**: Insights by gender, location, and martial status.
- **Product Catalog**: Performance by category and product line.

---
*Built with SQL Server and Medallion Architecture.*
