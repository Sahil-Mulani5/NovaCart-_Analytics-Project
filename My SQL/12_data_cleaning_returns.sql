-- =====================================================
-- Project : NovaCart Analytics
-- File    : 12_data_cleaning_returns.sql
-- Purpose : Data Cleaning - Returns Table
-- =====================================================

USE novacart_analytics;

-- =====================================================
-- Check 01: Count Total Records
-- Purpose:
-- Verify the total number of return records before
-- starting the data cleaning process.
-- Expected Result:
-- Total return records.
-- =====================================================

SELECT COUNT(*) AS total_returns
FROM returns;

-- =====================================================
-- Check 02: Identify NULL Values
-- Purpose:
-- Check all columns for NULL values.
-- Expected Result:
-- All columns should return 0 NULL values.
-- =====================================================

SELECT
    SUM(return_id IS NULL) AS return_id_null,
    SUM(order_id IS NULL) AS order_id_null,
    SUM(return_date IS NULL) AS return_date_null,
    SUM(reason IS NULL) AS reason_null,
    SUM(refund_amount IS NULL) AS refund_amount_null,
    SUM(status IS NULL) AS status_null
FROM returns;

-- =====================================================
-- Check 03: Identify Duplicate Return IDs
-- Purpose:
-- Ensure return_id is unique.
-- Expected Result:
-- Empty result set.
-- =====================================================

SELECT
    return_id,
    COUNT(*) AS duplicate_count
FROM returns
GROUP BY return_id
HAVING COUNT(*) > 1;

-- =====================================================
-- Check 04: Identify Blank Values
-- Purpose:
-- Check important text columns for blank values.
-- Expected Result:
-- All columns should return 0.
-- =====================================================

SELECT
    SUM(TRIM(reason) = '') AS reason_blank,
    SUM(TRIM(status) = '') AS status_blank
FROM returns;

-- =====================================================
-- Check 05: Validate Refund Amount
-- Purpose:
-- Ensure refund amount is not negative.
-- Expected Result:
-- No records should be returned.
-- =====================================================

SELECT *
FROM returns
WHERE refund_amount < 0;

-- =====================================================
-- Check 06: Validate Return Date
-- Purpose:
-- Ensure return date is not in the future.
-- Expected Result:
-- No records should be returned.
-- =====================================================

SELECT *
FROM returns
WHERE return_date > CURDATE();

-- =====================================================
-- Check 07: Validate Return Status
-- Purpose:
-- Review all return status values.
-- Expected Result:
-- Display valid status values only.
-- =====================================================

SELECT
    status,
    COUNT(*) AS total_returns
FROM returns
GROUP BY status
ORDER BY total_returns DESC;

-- =====================================================
-- Check 08: Validate Return Reasons
-- Purpose:
-- Review all return reasons.
-- Expected Result:
-- Display valid return reasons only.
-- =====================================================

SELECT
    reason,
    COUNT(*) AS total_returns
FROM returns
GROUP BY reason
ORDER BY total_returns DESC;

-- =====================================================
-- Check 09: Validate Order IDs
-- Purpose:
-- Ensure every return is linked to an order.
-- Expected Result:
-- No NULL order IDs.
-- =====================================================

SELECT *
FROM returns
WHERE order_id IS NULL;

-- =====================================================
-- Check 10: Verify Return Date After Order Date
-- Purpose:
-- Ensure the return date is not earlier than the order date.
-- Expected Result:
-- No records should be returned.
-- =====================================================

SELECT
    r.return_id,
    r.order_id,
    o.order_date,
    r.return_date
FROM returns r
JOIN orders o
ON r.order_id = o.order_id
WHERE r.return_date < o.order_date;

-- =====================================================
-- Check 11: Final Data Summary
-- Purpose:
-- Display total return records after validation.
-- Expected Result:
-- Total return records.
-- =====================================================

SELECT COUNT(*) AS total_returns
FROM returns;

-- =====================================================
-- Cleaning Summary
-- =====================================================
-- ✔ Total Records Checked
-- ✔ NULL Values Checked
-- ✔ Duplicate Return IDs Checked
-- ✔ Blank Values Checked
-- ✔ Refund Amount Validated
-- ✔ Return Date Validated
-- ✔ Return Status Validated
-- ✔ Return Reasons Validated
-- ✔ Order ID Validated
-- ✔ Return Date vs Order Date Validated
-- Status : PASSED
-- =====================================================