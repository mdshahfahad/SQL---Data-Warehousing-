CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN
    -- Declare variables for execution time tracking
    DECLARE @StartTime DATETIME2, @EndTime DATETIME2, @TotalStartTime DATETIME2, @TotalEndTime DATETIME2;
    DECLARE @RowCount INT;

    -- Start tracking total execution time
    SET @TotalStartTime = SYSDATETIME();

    PRINT 'Starting Bulk Load Process...';

    -- Load bronze.crm_cust_info
    SET @StartTime = SYSDATETIME();
    TRUNCATE TABLE bronze.crm_cust_info;
    BULK INSERT bronze.crm_cust_info
    FROM 'E:\Data with baraa\SQL Data Warehouse Project\datasets\source_crm\cust_info.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );
    SET @EndTime = SYSDATETIME();
    SET @RowCount = @@ROWCOUNT;
    PRINT 'crm_cust_info: ' + CAST(@RowCount AS NVARCHAR(10)) + ' rows loaded in ' + CAST(DATEDIFF(MILLISECOND, @StartTime, @EndTime) AS NVARCHAR(10)) + ' ms';

    -- Load bronze.crm_prd_info
    SET @StartTime = SYSDATETIME();
    TRUNCATE TABLE bronze.crm_prd_info;
    BULK INSERT bronze.crm_prd_info
    FROM 'E:\Data with baraa\SQL Data Warehouse Project\datasets\source_crm\prd_info.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );
    SET @EndTime = SYSDATETIME();
    SET @RowCount = @@ROWCOUNT;
    PRINT 'crm_prd_info: ' + CAST(@RowCount AS NVARCHAR(10)) + ' rows loaded in ' + CAST(DATEDIFF(MILLISECOND, @StartTime, @EndTime) AS NVARCHAR(10)) + ' ms';

    -- Load bronze.crm_sales_details
    SET @StartTime = SYSDATETIME();
    TRUNCATE TABLE bronze.crm_sales_details;
    BULK INSERT bronze.crm_sales_details
    FROM 'E:\Data with baraa\SQL Data Warehouse Project\datasets\source_crm\sales_details.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );
    SET @EndTime = SYSDATETIME();
    SET @RowCount = @@ROWCOUNT;
    PRINT 'crm_sales_details: ' + CAST(@RowCount AS NVARCHAR(10)) + ' rows loaded in ' + CAST(DATEDIFF(MILLISECOND, @StartTime, @EndTime) AS NVARCHAR(10)) + ' ms';

    -- Load bronze.erp_cust_az12
    SET @StartTime = SYSDATETIME();
    TRUNCATE TABLE bronze.erp_cust_az12;
    BULK INSERT bronze.erp_cust_az12
    FROM 'E:\Data with baraa\SQL Data Warehouse Project\datasets\source_erp\cust_az12.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );
    SET @EndTime = SYSDATETIME();
    SET @RowCount = @@ROWCOUNT;
    PRINT 'erp_cust_az12: ' + CAST(@RowCount AS NVARCHAR(10)) + ' rows loaded in ' + CAST(DATEDIFF(MILLISECOND, @StartTime, @EndTime) AS NVARCHAR(10)) + ' ms';

    -- Load bronze.erp_lock_a101
    SET @StartTime = SYSDATETIME();
    TRUNCATE TABLE bronze.erp_lock_a101;
    BULK INSERT bronze.erp_lock_a101
    FROM 'E:\Data with baraa\SQL Data Warehouse Project\datasets\source_erp\loc_a101.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );
    SET @EndTime = SYSDATETIME();
    SET @RowCount = @@ROWCOUNT;
    PRINT 'erp_lock_a101: ' + CAST(@RowCount AS NVARCHAR(10)) + ' rows loaded in ' + CAST(DATEDIFF(MILLISECOND, @StartTime, @EndTime) AS NVARCHAR(10)) + ' ms';

    -- Load bronze.erp_px_cat_g1v2
    SET @StartTime = SYSDATETIME();
    TRUNCATE TABLE bronze.erp_px_cat_g1v2;
    BULK INSERT bronze.erp_px_cat_g1v2
    FROM 'E:\Data with baraa\SQL Data Warehouse Project\datasets\source_erp\px_cat_g1v2.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );
    SET @EndTime = SYSDATETIME();
    SET @RowCount = @@ROWCOUNT;
    PRINT 'erp_px_cat_g1v2: ' + CAST(@RowCount AS NVARCHAR(10)) + ' rows loaded in ' + CAST(DATEDIFF(MILLISECOND, @StartTime, @EndTime) AS NVARCHAR(10)) + ' ms';

    -- Calculate total execution time
    SET @TotalEndTime = SYSDATETIME();
    PRINT 'Total Bulk Load Execution Time: ' + CAST(DATEDIFF(SECOND, @TotalStartTime, @TotalEndTime) AS NVARCHAR(10)) + ' seconds';
END;
