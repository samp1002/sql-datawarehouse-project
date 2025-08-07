/*
===================================================================================================
DDL Script: Create Gold Views
===================================================================================================
Script Purpose:
This script creates views for the Gold layer in the data warehouse.
The Gold layer represents the final dimension and fact tables (Star Schema)

Each view performs transformations and combines data from the Silver layer
to produce a clean, enriched, and business-ready dataset.
Usage :
- These views can be queried directly for analytics and reporting.
===================================================================================================
*/

-- ===================================================================================================
--   CREATE DIMENSION : gold.dim_customers
-- ===================================================================================================

if object_id ('gold.dim_customers') is not null 
  drop view gold.dim_customers
go

create view gold.dim_customers as
SELECT
ROW_NUMBER() over (order by cst_id) as customer_key,
ci.cst_id customer_id,
ci.cst_key customer_no,
ci.cst_firstname first_name,
ci.cst_lastname last_name,
lo.CNTRY country,
ci.cst_marital_status maritalstatus,
case when ci.cst_gndr != 'n/a' then ci.cst_gndr 
	 else coalesce(ca.gen,'n/a')
end as gender,
ca.BDATE birthdate,
ci.cst_create_date create_date

FROM silver.crm_cust_info ci
left join silver.erp_CUST_AZ12 ca
on ci.cst_key = ca.CID
left join silver.erp_LOC_A101 lo
on ci.cst_key = lo.CID

-- ===================================================================================================
--   CREATE DIMENSION : gold.dim_products
-- ===================================================================================================
if object_id ('gold.dim_products') is not null 
  drop view gold.dim_products
go

create view gold.dim_products as
select
row_number() over (order by pn.prd_key,pn.prd_start_dt) product_key,
pn.prd_id product_id,
pn.prd_key product_number,
pn.prd_nm product_no,
pn.cat_id category_id,
pc.cat category,
pc.subcat subcategory,
pn.prd_cost product_cost,
pn.prd_line product_line,
pn.prd_start_dt start_dt,
pc.MAINTENANCE maintenance

from silver.crm_prd_info pn
left join silver.erp_PX_CAT_G1V2 pc
on pn.cat_id = pc.ID
where prd_end_dt is null --erase history
-- ===================================================================================================
--   CREATE FACT : gold.fact_sales
-- ===================================================================================================

if object_id ('gold.fact_sales') is not null 
   drop view gold.fact_sales
go

create view gold.fact_sales as
select
sd.sls_ord_num order_number,
pr.product_key,
cu.customer_key,
sd.sls_order_dt order_date,
sd.sls_ship_dt ship_date,
sd.sls_due_dt due_date,
sd.sls_sales sales_amount,
sd.sls_quantity quantity,
sd.sls_price price
from silver.crm_sales_details sd
left join gold.dim_products pr
on sd.sls_prd_key = pr.product_number
left join gold.dim_customers cu
on sd.sls_cust_id = cu.customer_id























