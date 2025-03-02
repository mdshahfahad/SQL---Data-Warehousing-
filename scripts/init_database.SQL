-- --------------------------------------------------------------------------------
-- Script: Data Warehouse Schema Creation
-- Description: This script drops and recreates the 'datawarehouse' database 
--              and defines tables for customer, product, sales, and ERP data.
-- Warning: Running this script will **DELETE all existing data** in the database.
-- Author: [Md Shah Fahad]
-- --------------------------------------------------------------------------------

-- Drop the database if it already exists (Warning: This will remove all data)
DROP DATABASE IF EXISTS datawarehouse;
CREATE DATABASE datawarehouse;
USE datawarehouse;

-- --------------------------------------------------------------------------------
-- Customer Information Table
-- --------------------------------------------------------------------------------
DROP TABLE IF EXISTS bronze_crm_cust_info;
CREATE TABLE bronze_crm_cust_info (
    cust_id INT PRIMARY KEY, -- Unique Customer Identifier
    cust_key VARCHAR(50) UNIQUE, -- Alternative key for customers
    cust_firstname VARCHAR(50),
    cust_lastname VARCHAR(50),
    cust_marital_status VARCHAR(50),
    cust_gndr VARCHAR(50),
    cust_create_date DATE -- Date when customer was created
);

-- --------------------------------------------------------------------------------
-- Product Information Table
-- --------------------------------------------------------------------------------
DROP TABLE IF EXISTS bronze_crm_prd_info;
CREATE TABLE bronze_crm_prd_info (
    prd_id INT PRIMARY KEY, -- Unique Product Identifier
    prd_key VARCHAR(50) UNIQUE, -- Alternative key for products
    prd_nm VARCHAR(50),
    prd_cost INT,
    prd_line VARCHAR(50),
    prd_start_dt DATE,
    prd_end_dt DATE
);

-- --------------------------------------------------------------------------------
-- Sales Details Table (Links Customers and Products)
-- --------------------------------------------------------------------------------
DROP TABLE IF EXISTS bronze_crm_sales_details;
CREATE TABLE bronze_crm_sales_details (
    sls_ord_num VARCHAR(50) PRIMARY KEY, -- Unique Sales Order Number
    sls_prd_key VARCHAR(50), -- Foreign Key referencing prd_key in Product Table
    sls_cust_id INT, -- Foreign Key referencing cust_id in Customer Table
    sls_order_dt INT, -- Order Date (Fixed data type)
    sls_ship_dt INT, -- Shipment Date (Fixed data type)
    sls_due_dt INT, -- Due Date (Fixed data type)
    sls_sales INT,
    sls_quantity INT,
    sls_price INT,
    FOREIGN KEY (sls_prd_key) REFERENCES bronze_crm_prd_info(prd_key),
    FOREIGN KEY (sls_cust_id) REFERENCES bronze_crm_cust_info(cust_id)
);

-- --------------------------------------------------------------------------------
-- ERP Customer Data Table
-- --------------------------------------------------------------------------------
DROP TABLE IF EXISTS bronze_erp_cust_az12;
CREATE TABLE bronze_erp_cust_az12 (
    CID VARCHAR(50) PRIMARY KEY, -- Customer Identifier
    BDATE DATE, -- Birth Date
    GEN VARCHAR(50) -- Gender
);

-- --------------------------------------------------------------------------------
-- ERP Country Lock Table
-- --------------------------------------------------------------------------------
DROP TABLE IF EXISTS bronze_erp_lock_a101;
CREATE TABLE bronze_erp_lock_a101 (
    CID VARCHAR(50), -- Customer Identifier
    CNTRY VARCHAR(50), -- Country
    FOREIGN KEY (CID) REFERENCES bronze_erp_cust_az12(CID) -- Linking to ERP Customers
);

-- --------------------------------------------------------------------------------
-- ERP Product Category Table
-- --------------------------------------------------------------------------------
DROP TABLE IF EXISTS bronze_erp_px_cat_g1v2;
CREATE TABLE bronze_erp_px_cat_g1v2 (
    ID VARCHAR(50) PRIMARY KEY, -- Unique Identifier for Product Category
    CAT VARCHAR(50), -- Category Name
    SUBCAT VARCHAR(50), -- Subcategory Name
    MAINTENANCE VARCHAR(50) -- Maintenance Information
);

-- --------------------------------------------------------------------------------
-- End of Script
-- --------------------------------------------------------------------------------
