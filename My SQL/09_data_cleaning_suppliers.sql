-- =====================================================
-- Project : NovaCart Analytics
-- File    : 09_data_cleaning_suppliers.sql
-- Purpose : Data Cleaning - Suppliers Table
-- =====================================================

USE novacart_analytics;

-- =====================================================
-- Check 01: Count Total Records
-- Purpose:
-- Verify the total number of supplier records before
-- starting the data cleaning process.
-- Expected Result:
-- Total supplier records.
-- =====================================================

SELECT COUNT(*) AS total_suppliers
FROM suppliers;

-- =====================================================
-- Check 02: Identify NULL Values
-- Purpose:
-- Check all columns for NULL values.
-- Expected Result:
-- All columns should return 0 NULL values.
-- =====================================================

SELECT
    SUM(supplier_id IS NULL) AS supplier_id_null,
    SUM(supplier_name IS NULL) AS supplier_name_null,
    SUM(supplier_type IS NULL) AS supplier_type_null,
    SUM(contact_person IS NULL) AS contact_person_null,
    SUM(email IS NULL) AS email_null,
    SUM(phone IS NULL) AS phone_null,
    SUM(city IS NULL) AS city_null,
    SUM(state IS NULL) AS state_null,
    SUM(country IS NULL) AS country_null,
    SUM(supplier_rating IS NULL) AS supplier_rating_null,
    SUM(delivery_days IS NULL) AS delivery_days_null,
    SUM(is_active IS NULL) AS is_active_null
FROM suppliers;

-- =====================================================
-- Check 03: Identify Duplicate Supplier IDs
-- Purpose:
-- Ensure supplier_id is unique.
-- Expected Result:
-- Empty result set.
-- =====================================================

SELECT
    supplier_id,
    COUNT(*) AS duplicate_count
FROM suppliers
GROUP BY supplier_id
HAVING COUNT(*) > 1;

-- =====================================================
-- Check 04: Identify Duplicate Email Addresses
-- Purpose:
-- Verify that each supplier has a unique email address.
-- Expected Result:
-- Empty result set.
-- =====================================================

SELECT
    email,
    COUNT(*) AS duplicate_count
FROM suppliers
GROUP BY email
HAVING COUNT(*) > 1;

-- =====================================================
-- Check 05: Identify Blank Values
-- Purpose:
-- Check important text columns for blank values.
-- Expected Result:
-- All columns should return 0.
-- =====================================================

SELECT
    SUM(TRIM(supplier_name) = '') AS supplier_name_blank,
    SUM(TRIM(contact_person) = '') AS contact_person_blank,
    SUM(TRIM(email) = '') AS email_blank,
    SUM(TRIM(phone) = '') AS phone_blank,
    SUM(TRIM(city) = '') AS city_blank,
    SUM(TRIM(state) = '') AS state_blank,
    SUM(TRIM(country) = '') AS country_blank
FROM suppliers;

-- =====================================================
-- Check 06: Validate Supplier Rating
-- Purpose:
-- Ensure supplier ratings are between 0 and 5.
-- Expected Result:
-- No records should be returned.
-- =====================================================

SELECT *
FROM suppliers
WHERE supplier_rating < 0
   OR supplier_rating > 5;

-- =====================================================
-- Check 07: Validate Delivery Days
-- Purpose:
-- Ensure delivery days are not negative.
-- Expected Result:
-- No records should be returned.
-- =====================================================

SELECT *
FROM suppliers
WHERE delivery_days < 0;

-- =====================================================
-- Check 08: Validate Active Status
-- Purpose:
-- Verify active status values.
-- Expected Result:
-- Only 0 and 1 should be returned.
-- =====================================================

SELECT
    is_active,
    COUNT(*) AS total_records
FROM suppliers
GROUP BY is_active;

-- =====================================================
-- Check 09: Validate Email Format
-- Purpose:
-- Identify invalid email addresses.
-- Expected Result:
-- No records should be returned.
-- =====================================================

SELECT *
FROM suppliers
WHERE email NOT LIKE '%@%.%';

-- =====================================================
-- Check 10: Validate Phone Numbers
-- Purpose:
-- Identify blank or invalid phone numbers.
-- Expected Result:
-- No records should be returned.
-- =====================================================

SELECT *
FROM suppliers
WHERE phone IS NULL
   OR TRIM(phone) = ''
   OR LENGTH(TRIM(phone)) < 10;

-- =====================================================
-- Check 11: Final Data Summary
-- Purpose:
-- Display the total number of supplier records after
-- validation.
-- Expected Result:
-- Total supplier records.
-- =====================================================

SELECT COUNT(*) AS total_suppliers
FROM suppliers;

-- =====================================================
-- Cleaning Summary
-- =====================================================
-- ✔ Total Records Checked
-- ✔ NULL Values Checked
-- ✔ Duplicate IDs Checked
-- ✔ Duplicate Emails Checked
-- ✔ Blank Values Checked
-- ✔ Rating Validated
-- ✔ Delivery Days Validated
-- ✔ Email Format Validated
-- ✔ Phone Numbers Validated
-- ✔ Active Status Validated
-- Status : PASSED
-- =====================================================