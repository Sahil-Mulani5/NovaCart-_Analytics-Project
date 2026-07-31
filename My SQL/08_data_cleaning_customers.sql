-- =========================================
-- Project : NovaCart Analytics
-- File    : 08_data_cleaning_customers.sql
-- Purpose : Customers Data Cleaning
-- =========================================

USE novacart_analytics;


-- =====================================================
-- Check 01: Count Total Customer Records
-- Purpose:
-- Verify the total number of records in the customers table
-- before starting the data cleaning process.
-- Expected Result:
-- 200000 records
-- =====================================================

SELECT COUNT(*) AS total_customers
FROM customers;

-- =====================================================
-- Check 02: Identify NULL Values
-- Purpose:
-- Check each column for NULL values to ensure data completeness.
-- Expected Result:
-- All columns should return 0 NULL values.
-- =====================================================
SELECT
    SUM(customer_id IS NULL) AS customer_id_null,
    SUM(first_name IS NULL) AS first_name_null,
    SUM(last_name IS NULL) AS last_name_null,
    SUM(gender IS NULL) AS gender_null,
    SUM(email IS NULL) AS email_null,
    SUM(phone IS NULL) AS phone_null,
    SUM(city IS NULL) AS city_null,
    SUM(state IS NULL) AS state_null,
    SUM(join_date IS NULL) AS join_date_null,
    SUM(loyalty_points IS NULL) AS loyalty_points_null,
    SUM(is_active IS NULL) AS is_active_null
FROM customers;


-- =====================================================
-- Check 03: Identify Duplicate Customer IDs
-- Purpose:
-- Ensure that each customer_id is unique.
-- Duplicate customer IDs can cause data integrity issues.
-- Expected Result:
-- Empty result set (0 duplicate records)
-- =====================================================

SELECT
    customer_id,
    COUNT(*) AS duplicate_count
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- =====================================================
-- Check 04: Identify Duplicate Email Addresses
-- Purpose:
-- Verify that each customer has a unique email address.
-- Duplicate emails may indicate duplicate customer records.
-- Expected Result:
-- Empty result set (0 duplicate email addresses)
-- =====================================================
SELECT
    email,
    COUNT(*) AS duplicate_count
FROM customers
GROUP BY email
HAVING COUNT(*) > 1;

-- =====================================================
-- Check 05: Identify Blank (Empty) Values
-- Purpose:
-- Check for empty strings in important text columns.
-- Blank values are different from NULL values and may
-- affect reporting and data analysis.
-- Expected Result:
-- All columns should return 0 blank values.
-- =====================================================

SELECT
    SUM(TRIM(first_name) = '') AS first_name_blank,
    SUM(TRIM(last_name) = '') AS last_name_blank,
    SUM(TRIM(email) = '') AS email_blank,
    SUM(TRIM(phone) = '') AS phone_blank,
    SUM(TRIM(city) = '') AS city_blank,
    SUM(TRIM(state) = '') AS state_blank
FROM customers;

-- =====================================================
-- Check 06: Validate Gender Values
-- Purpose:
-- Verify that the gender column contains only valid values.
-- Expected Result:
-- Only 'Male' and 'Female' should be returned.
-- =====================================================

SELECT
    gender,
    COUNT(*) AS total_records
FROM customers
GROUP BY gender;

-- =====================================================
-- Check 08: Validate Join Date
-- Purpose:
-- Check for future join dates.
-- Expected Result:
-- No records should be returned.
-- =====================================================

SELECT *
FROM customers
WHERE join_date > CURDATE();

-- =====================================================
-- Check 08: Validate Join Date
-- Purpose:
-- Check for future join dates.
-- Expected Result:
-- No records should be returned.
-- =====================================================

SELECT *
FROM customers
WHERE join_date > CURDATE();

-- =====================================================
-- Check 09: Validate Active Status
-- Purpose:
-- Verify that is_active contains only valid values.
-- Expected Result:
-- Only 0 and 1 should be returned.
-- =====================================================

SELECT
    is_active,
    COUNT(*) AS total_records
FROM customers
GROUP BY is_active;


-- =====================================================
-- Check 10: Validate Email Format
-- Purpose:
-- Identify invalid email addresses.
-- Expected Result:
-- No records should be returned.
-- =====================================================

SELECT *
FROM customers
WHERE email NOT LIKE '%@%.%';



-- =====================================================
-- Check 11: Validate Phone Numbers
-- Purpose:
-- Identify blank or unusually short phone numbers.
-- Expected Result:
-- No records should be returned.
-- =====================================================

SELECT *
FROM customers
WHERE phone IS NULL
   OR TRIM(phone) = ''
   OR LENGTH(TRIM(phone)) < 10;
   
   
   -- =====================================================
-- Check 12: Validate City and State Values
-- Purpose:
-- Ensure city and state fields are not blank.
-- Expected Result:
-- No records should be returned.
-- =====================================================

SELECT *
FROM customers
WHERE TRIM(city) = ''
   OR TRIM(state) = '';
   
   
   
   -- =====================================================
-- Check 13: Final Customer Data Summary
-- Purpose:
-- Display total number of records after validation.
-- Expected Result:
-- 200000 records.
-- =====================================================

SELECT COUNT(*) AS total_customers
FROM customers;

