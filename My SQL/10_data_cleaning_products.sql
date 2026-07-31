-- =====================================================
-- Project : NovaCart Analytics
-- File    : 10_data_cleaning_products.sql
-- Purpose : Data Cleaning - Products Table
-- =====================================================

USE novacart_analytics;

-- =====================================================
-- Check 01: Count Total Records
-- Purpose:
-- Verify the total number of product records before
-- starting the data cleaning process.
-- Expected Result:
-- Total product records.
-- =====================================================

SELECT COUNT(*) AS total_products
FROM products;

-- =====================================================
-- Check 02: Identify NULL Values
-- Purpose:
-- Check all columns for NULL values.
-- Expected Result:
-- All columns should return 0 NULL values.
-- =====================================================

SELECT
    SUM(product_id IS NULL) AS product_id_null,
    SUM(product_name IS NULL) AS product_name_null,
    SUM(category IS NULL) AS category_null,
    SUM(brand IS NULL) AS brand_null,
    SUM(supplier_id IS NULL) AS supplier_id_null,
    SUM(cost_price IS NULL) AS cost_price_null,
    SUM(selling_price IS NULL) AS selling_price_null,
    SUM(stock_quantity IS NULL) AS stock_quantity_null,
    SUM(rating IS NULL) AS rating_null,
    SUM(launch_date IS NULL) AS launch_date_null,
    SUM(is_active IS NULL) AS is_active_null
FROM products;

-- =====================================================
-- Check 03: Identify Duplicate Product IDs
-- Purpose:
-- Ensure product_id is unique.
-- Expected Result:
-- Empty result set.
-- =====================================================

SELECT
    product_id,
    COUNT(*) AS duplicate_count
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;

-- =====================================================
-- Check 04: Identify Blank Values
-- Purpose:
-- Check important text columns for blank values.
-- Expected Result:
-- All columns should return 0.
-- =====================================================

SELECT
    SUM(TRIM(product_name) = '') AS product_name_blank,
    SUM(TRIM(category) = '') AS category_blank,
    SUM(TRIM(brand) = '') AS brand_blank
FROM products;

-- =====================================================
-- Check 05: Validate Cost Price
-- Purpose:
-- Ensure cost price is greater than or equal to zero.
-- Expected Result:
-- No records should be returned.
-- =====================================================

SELECT *
FROM products
WHERE cost_price < 0;

-- =====================================================
-- Check 06: Validate Selling Price
-- Purpose:
-- Ensure selling price is greater than or equal to zero.
-- Expected Result:
-- No records should be returned.
-- =====================================================

SELECT *
FROM products
WHERE selling_price < 0;

-- =====================================================
-- Check 07: Validate Selling Price vs Cost Price
-- Purpose:
-- Ensure selling price is not less than cost price.
-- Expected Result:
-- No records should be returned.
-- =====================================================

SELECT *
FROM products
WHERE selling_price < cost_price;

-- =====================================================
-- Check 08: Validate Stock Quantity
-- Purpose:
-- Ensure stock quantity is not negative.
-- Expected Result:
-- No records should be returned.
-- =====================================================

SELECT *
FROM products
WHERE stock_quantity < 0;

-- =====================================================
-- Check 09: Validate Product Rating
-- Purpose:
-- Ensure ratings are between 0 and 5.
-- Expected Result:
-- No records should be returned.
-- =====================================================

SELECT *
FROM products
WHERE rating < 0
   OR rating > 5;

-- =====================================================
-- Check 10: Validate Launch Date
-- Purpose:
-- Ensure launch date is not in the future.
-- Expected Result:
-- No records should be returned.
-- =====================================================

SELECT *
FROM products
WHERE launch_date > CURDATE();

-- =====================================================
-- Check 11: Validate Active Status
-- Purpose:
-- Verify active status values.
-- Expected Result:
-- Only 0 and 1 should be returned.
-- =====================================================

SELECT
    is_active,
    COUNT(*) AS total_records
FROM products
GROUP BY is_active;

-- =====================================================
-- Check 12: Validate Supplier IDs
-- Purpose:
-- Ensure every product is linked to a supplier.
-- Expected Result:
-- No NULL supplier IDs.
-- =====================================================

SELECT *
FROM products
WHERE supplier_id IS NULL;

-- =====================================================
-- Check 13: Final Data Summary
-- Purpose:
-- Display total product records after validation.
-- Expected Result:
-- Total product records.
-- =====================================================

SELECT COUNT(*) AS total_products
FROM products;

-- =====================================================
-- Cleaning Summary
-- =====================================================
-- ✔ Total Records Checked
-- ✔ NULL Values Checked
-- ✔ Duplicate Product IDs Checked
-- ✔ Blank Values Checked
-- ✔ Cost Price Validated
-- ✔ Selling Price Validated
-- ✔ Profit Margin Validated
-- ✔ Stock Quantity Validated
-- ✔ Product Rating Validated
-- ✔ Launch Date Validated
-- ✔ Supplier ID Validated
-- ✔ Active Status Validated
-- Status : PASSED
-- =====================================================