/*
===============================================================================================
DDL script: create Bronze Tables
===============================================================================================
Script Purpose:
This script creates tables in the • bronze • schema, dropping existing tables
if they already exist.
Run this script to re-define the DDL structure of bronze Tables
===============================================================================================
*/
if OBJECT_ID ('bronze.crm_cust_info','U') is not null 
	drop table bronze.crm_cust_info;
create table bronze.crm_cust_info(
cst_id int,
cst_key nvarchar(50),
cst_firstname nvarchar(50),
cst_lastname nvarchar(50),
cst_marital_status nvarchar(50),
cst_gndr nvarchar(50),
cst_create_date date
);

if OBJECT_ID ('bronze.crm_sales_details','U') is not null 
	drop table bronze.crm_sales_details;
create table bronze.crm_sales_details(
sls_ord_num nvarchar(50),
sls_prd_key nvarchar(50),
sls_cust_id int,
sls_order_dt int,
sls_ship_dt int,
sls_due_dt int,
sls_sales int,
sls_quantity int,
sls_price int
)

if OBJECT_ID ('bronze.crm_prd_info','U') is not null 
	drop table bronze.crm_prd_info;
create table bronze.crm_prd_info(
prd_id nvarchar(50),
prd_key nvarchar(50),
prd_nm nvarchar(50),
prd_cost int,
prd_line nvarchar(50),
prd_start_dt datetime,
prd_end_dt datetime
)

if OBJECT_ID ('bronze.erp_CUST_AZ12','U') is not null 
	drop table bronze.erp_CUST_AZ12;
create table bronze.erp_CUST_AZ12(
CID nvarchar(50),
BDATE date,
GEN nvarchar(50)
)

if OBJECT_ID ('bronze.erp_LOC_A101','U') is not null 
	drop table bronze.erp_LOC_A101;
create table bronze.erp_LOC_A101(
CID nvarchar(50),
CNTRY nvarchar(50)
)

if OBJECT_ID ('bronze.erp_PX_CAT_G1V2','U') is not null 
	drop table bronze.erp_PX_CAT_G1V2;
create table bronze.erp_PX_CAT_G1V2(
ID nvarchar(50),
CAT nvarchar(50),
SUBCAT nvarchar(50),
MAINTENANCE nvarchar(50)
)

