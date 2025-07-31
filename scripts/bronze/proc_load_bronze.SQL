/*
================================================================================================================
Stored Prpcedure : Load Bronze Layer 
================================================================================================================
Script Purpose :
This Stored procedure loads data into the bronze schema from external CSV files .
It the follwing actions:
-truncates the bronze table before loading data.
- uses the bulk insert comand to load data csv Files to bronze

parameter: 
none
this stored procedure does not acccept any paramters or values
usage example:
EXEC bronze.load bronze;
*/


exec  bronze.load_bronze

create or alter procedure bronze.load_bronze as
BEGIN
	DECLARE @start_time datetime,@end_time datetime,@batch_start_time datetime,@batch_end_time datetime
	BEGIN TRY
		set @batch_start_time = getdate();
		print('===============================================')
		print('LOADING BRONZE LAYER')
		PRINT('===============================================')

		PRINT('LOADING CRM SECTION')

		set @start_time = getdate();
		truncate table  bronze.crm_cust_info
		bulk insert bronze.crm_cust_info
		from 'C:\Users\Samruddhi Patil\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate(); 
		print '>>load dration :' + cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds'


		set @start_time = getdate();
		truncate table  bronze.crm_prd_info
		bulk insert bronze.crm_prd_info
		from 'C:\Users\Samruddhi Patil\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print '>>load dration :' + cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds'


		set @start_time = getdate();
		truncate table  bronze.crm_sales_details
		bulk insert bronze.crm_sales_details
		from 'C:\Users\Samruddhi Patil\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print '>>load dration :' + cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds'


	PRINT('LOADING ERP SECTION')

		set @start_time = getdate();
		truncate table  bronze.erp_CUST_AZ12
		bulk insert bronze.erp_CUST_AZ12
		from 'C:\Users\Samruddhi Patil\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print '>>load dration :' + cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds'


		set @start_time = getdate();
		truncate table bronze.erp_LOC_A101
		bulk insert bronze.erp_LOC_A101
		from 'C:\Users\Samruddhi Patil\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print '>>load dration :' + cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds'

		set @start_time = getdate();
		truncate table bronze.erp_PX_CAT_G1V2
		bulk insert bronze.erp_PX_CAT_G1V2
		from 'C:\Users\Samruddhi Patil\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate(); 
		print '>>load duration :' + cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds'

		
		set @batch_end_time = getdate();
		print '=============================================================================================='
		print 'bronze layer batch duration'
		print '>>batch load duration :' + cast(datediff(second,@batch_start_time,@batch_end_time) as nvarchar) + 'seconds'
		print '=============================================================================================='
	END TRY
	BEGIN CATCH
	PRINT '======================================================================================'
	PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
	PRINT 'Error Message' + ERROR_MESSAGE();
	PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
	PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
	PRINT '======================================================================================'
	END CATCH
END



