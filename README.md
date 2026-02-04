# Enterprise Retail Analytics Data Warehouse

A comprehensive SQL-based data warehousing solution designed to transform raw **ERP** and **CRM** data into actionable business insights. This project implements a robust **Medallion Architecture** (Staging, Refined, Analytics) to ensure data quality, scalability, and analytical readiness.

---

## 🏗️ Data Architecture

The project follows a layered data architecture that mirrors real-world enterprise data platforms. Each layer has a clearly defined responsibility, enabling maintainable and scalable analytics workflows.

### 1. Staging Layer (`etl_staging`)
The staging layer ingests raw data from **CRM** and **ERP** source systems in CSV format.  
- Minimal validation  
- No business transformations  
- Preserves source-level granularity for traceability  

### 2. Refined Layer (`etl_refine`)
The refined layer focuses on data quality and integration.  
- Data cleansing and standardization  
- Deduplication and null handling  
- Domain value mapping and enrichment  
- Harmonization of CRM and ERP datasets  

### 3. Analytics Layer (`analytics_models`)
The analytics layer models data into a **Star Schema** optimized for reporting and dashboarding.  
- Fact and dimension tables  
- Business-ready metrics  
- Optimized for BI and ad-hoc analysis  

![Data Architecture](documentation/data_architecture.png)

### Key Schemas
- **Staging**: `staging.crm_*`, `staging.erp_*`
- **Refined**: `refined.crm_*`, `refined.erp_*`
- **Analytics**:  
  - `analytics.dim_customers`  
  - `analytics.dim_products`  
  - `analytics.fact_sales`

---

## 📂 Project Structure

root/
├── etl_staging_refine_analytics/ # ETL scripts (DDL & stored procedures)
│ ├── etl_staging/ # Staging layer: raw → structured
│ │ ├── ddl_staging.sql
│ │ ├── proc_load_staging.sql
│ │ └── init_database.sql
│ │
│ ├── etl_refine/ # Refined layer: clean & transform
│ │ ├── ddl_refined.sql
│ │ └── proc_load_refined.sql
│ │
│ └── analytics_models/ # Analytics layer: star schema models
│ └── ddl_analytics.sql
│
├── raw_data_sources/ # Raw source datasets (CSV)
│ ├── source_crm/ # CRM source data
│ └── source_erp/ # ERP source data
│
├── quality_checks/ # Data quality & integrity checks
│ ├── quality_checks_refined.sql
│ └── quality_checks_analytics.sql
│
├── documentation/ # Architecture & data flow diagrams
│ ├── data_architecture.png
│ ├── data_flow.png
│ ├── data_integration.png
│ └── data_model.png
│
└── README.md # Project documentation

---

## 🚀 Getting Started

### Prerequisites
- **SQL Server** (Express or Developer Edition)
- **SQL Server Management Studio (SSMS)** or **Azure Data Studio**

### Installation & Execution

1. **Clone the Repository**
   ```bash
   git clone https://github.com/your-username/enterprise-retail-analytics.git
2.Initialize the Database
Run the initialization script to create the database and required schemas:

etl_staging_refine_analytics/etl_staging/init_database.sql

3.Execute the ETL Pipeline
Run the stored procedures in the following order:
-- Load data from source files into staging
EXEC staging.load_staging;

-- Transform and integrate data into refined layer
EXEC refined.load_refined;

-- Analytics layer objects are created via DDL
-- and automatically reflect refined data

4.Validate Data Quality
Execute the scripts in the quality_checks/ directory to verify data accuracy and integrity.
📊 Analytics & Insights

The Analytics Layer enables business-focused analysis, including:

Sales Performance
Revenue, quantities, and trends over time

Customer Demographics
Insights by gender, location, and marital status

Product Analytics
Performance by product category and product line
🛠️ Technologies Used

SQL Server

SQL (DDL, stored procedures, transformations)

Medallion Architecture

Dimensional Modeling (Star Schema)
