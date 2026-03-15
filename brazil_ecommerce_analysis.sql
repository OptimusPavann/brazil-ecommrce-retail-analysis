
-- List the tables in your database
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'

SELECT name
FROM sys.tables;
--Check the row count in all the tables
SELECT COUNT(*) total_customers FROM customers;

SELECT COUNT(*) total_products FROM products;

SELECT COUNT(*) total_product_category FROM product_category;

SELECT COUNT(*) total_geolocations FROM geolocation;

SELECT COUNT(*) total_orders FROM orders;

SELECT COUNT(*) total_order_items FROM order_items;

SELECT COUNT(*) total_order_payments FROM order_payments;

SELECT COUNT(*) total_order_reviews FROM order_reviews;

SELECT COUNT(*) total_sellers FROM sellers;

--Instead of running many queries separately, use this for better output and understand
SELECT 'customers' AS table_name, COUNT(*) AS total_rows FROM customers
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'order_reviews', COUNT(*) FROM order_reviews
UNION ALL
SELECT 'order_payments', COUNT(*) FROM order_payments
UNION ALL
SELECT 'sellers', COUNT(*) FROM sellers
UNION ALL
SELECT 'geolocation', COUNT(*) FROM geolocation
UNION ALL
SELECT 'product_category', COUNT(*) FROM product_category;

-- Inspect table structure
EXEC sp_help customers;
EXEC sp_help orders;
EXEC sp_help geolocation;
EXEC sp_help order_items;
EXEC sp_help order_payments;
EXEC sp_help order_reviews;
EXEC sp_help products;
EXEC sp_help product_category;
EXEC sp_help sellers;

-- Alternative way to explore the table metadata
SELECT COLUMN_NAME, DATA_TYPE,CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'customers' --(Do it for all the tables)

--Explore the data in each Table
SELECT TOP 100 * FROM customers;
SELECT TOP 100 * FROM geolocation;
SELECT TOP 100 * FROM products;
SELECT TOP 100 * FROM product_category;
SELECT TOP 100 * FROM orders;
SELECT TOP 100 * FROM order_items;
SELECT TOP 100 * FROM order_payments;
SELECT TOP 100 * FROM order_reviews;
SELECT TOP 100 * FROM sellers;

--Find the NULL values in each table
SELECT 
	SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS null_customer_id,
	SUM(CASE WHEN customer_unique_id IS NULL THEN 1 ELSE 0 END) AS null_customer_unique_id,
	SUM(CASE WHEN customer_zip_code_prefix IS NULL THEN 1 ELSE 0 END) AS null_customer_zip_code_prefix,
	SUM(CASE WHEN customer_city IS NULL THEN 1 ELSE 0 END) AS null_customer_city,
	SUM(CASE WHEN customer_state IS NULL THEN 1 ELSE 0 END) AS null_customer_state
FROM customers

SELECT 
	COUNT(*) - COUNT(customer_id) AS null_customer_id,
	COUNT(*) - COUNT(customer_unique_id) AS null_customer_unique_id ,
	COUNT(*) - COUNT(customer_zip_code_prefix) AS null_customer_zip_code_prefix,
	COUNT(*) - COUNT(customer_city) AS null_customer_city,
	COUNT(*) - COUNT(customer_state) AS null_customer_state
FROM customers

--one query to check all blank and null values in all tables
DECLARE @sql NVARCHAR(MAX) = '';

SELECT @sql = @sql + 
'SELECT ''' + TABLE_NAME + ''' AS table_name,
        ''' + COLUMN_NAME + ''' AS column_name,
        COUNT(*) AS total_rows,
        SUM(CASE WHEN [' + COLUMN_NAME + '] IS NULL THEN 1 ELSE 0 END) AS null_values,
        SUM(CASE WHEN [' + COLUMN_NAME + '] = '''' THEN 1 ELSE 0 END) AS blank_values
FROM [' + TABLE_NAME + ']
UNION ALL
'
FROM INFORMATION_SCHEMA.COLUMNS
WHERE DATA_TYPE IN ('varchar','nvarchar','char','nchar');

-- remove last UNION ALL
SET @sql = LEFT(@sql, LEN(@sql) - 10);

EXEC sp_executesql @sql;