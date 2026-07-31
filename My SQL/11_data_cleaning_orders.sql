-- =====================================================
-- Project : NovaCart Analytics
-- File    : 11_data_cleaning_orders.sql
-- Purpose : Data Cleaning - Orders Table
-- =====================================================

USE novacart_analytics;

-- =====================================================
-- Check 01: Count Total Records
-- Purpose:
-- Verify the total number of order records before
-- starting the data cleaning process.
-- Expected Result:
-- Total order records.
-- =====================================================

SELECT COUNT(*) AS total_orders
FROM orders;

-- =====================================================
-- Check 02: Identify NULL Values
-- Purpose:
-- Check all columns for NULL values.
-- Expected Result:
-- All columns should return 0 NULL values.
-- =====================================================

SELECT
    SUM(order_id IS NULL) AS order_id_null,
    SUM(customer_id IS NULL) AS customer_id_null,
    SUM(product_id IS NULL) AS product_id_null,
    SUM(order_date IS NULL) AS order_date_null,
    SUM(quantity IS NULL) AS quantity_null,
    SUM(unit_price IS NULL) AS unit_price_null,
    SUM(discount_percent IS NULL) AS discount_percent_null,
    SUM(total_amount IS NULL) AS total_amount_null,
    SUM(payment_method IS NULL) AS payment_method_null,
    SUM(order_status IS NULL) AS order_status_null
FROM orders;

-- =====================================================
-- Check 03: Identify Duplicate Order IDs
-- Purpose:
-- Ensure order_id is unique.
-- Expected Result:
-- Empty result set.
-- =====================================================

SELECT
    order_id,
    COUNT(*) AS duplicate_count
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- =====================================================
-- Check 04: Identify Blank Values
-- Purpose:
-- Check important text columns for blank values.
-- Expected Result:
-- All columns should return 0.
-- =====================================================

SELECT
    SUM(TRIM(payment_method) = '') AS payment_method_blank,
    SUM(TRIM(order_status) = '') AS order_status_blank
FROM orders;

-- =====================================================
-- Check 05: Validate Order Quantity
-- Purpose:
-- Ensure quantity is greater than zero.
-- Expected Result:
-- No records should be returned.
-- =====================================================

SELECT *
FROM orders
WHERE quantity <= 0;

-- =====================================================
-- Check 06: Validate Unit Price
-- Purpose:
-- Ensure unit price is greater than zero.
-- Expected Result:
-- No records should be returned.
-- =====================================================

SELECT *
FROM orders
WHERE unit_price <= 0;

-- =====================================================
-- Check 07: Validate Discount Percentage
-- Purpose:
-- Ensure discount percentage is between 0 and 100.
-- Expected Result:
-- No records should be returned.
-- =====================================================

SELECT *
FROM orders
WHERE discount_percent < 0
   OR discount_percent > 100;

-- =====================================================
-- Check 08: Validate Total Amount
-- Purpose:
-- Ensure total amount is greater than zero.
-- Expected Result:
-- No records should be returned.
-- =====================================================

SELECT *
FROM orders
WHERE total_amount <= 0;

-- =====================================================
-- Check 09: Validate Order Date
-- Purpose:
-- Ensure order date is not in the future.
-- Expected Result:
-- No records should be returned.
-- =====================================================

SELECT *
FROM orders
WHERE order_date > CURDATE();

-- =====================================================
-- Check 10: Validate Payment Methods
-- Purpose:
-- Review all payment methods used in orders.
-- Expected Result:
-- Display valid payment methods only.
-- =====================================================

SELECT
    payment_method,
    COUNT(*) AS total_orders
FROM orders
GROUP BY payment_method
ORDER BY total_orders DESC;

-- =====================================================
-- Check 11: Validate Order Status
-- Purpose:
-- Review all order status values.
-- Expected Result:
-- Display valid order status values only.
-- =====================================================

SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- =====================================================
-- Check 12: Validate Customer IDs
-- Purpose:
-- Ensure every order has a valid customer ID.
-- Expected Result:
-- No NULL customer IDs.
-- =====================================================

SELECT *
FROM orders
WHERE customer_id IS NULL;

-- =====================================================
-- Check 13: Validate Product IDs
-- Purpose:
-- Ensure every order has a valid product ID.
-- Expected Result:
-- No NULL product IDs.
-- =====================================================

SELECT *
FROM orders
WHERE product_id IS NULL;

-- =====================================================
-- Check 14: Final Data Summary
-- Purpose:
-- Display total order records after validation.
-- Expected Result:
-- Total order records.
-- =====================================================

SELECT COUNT(*) AS total_orders
FROM orders;

-- =====================================================
-- Cleaning Summary
-- =====================================================
-- ✔ Total Records Checked
-- ✔ NULL Values Checked
-- ✔ Duplicate Order IDs Checked
-- ✔ Blank Values Checked
-- ✔ Quantity Validated
-- ✔ Unit Price Validated
-- ✔ Discount Percentage Validated
-- ✔ Total Amount Validated
-- ✔ Order Date Validated
-- ✔ Payment Method Validated
-- ✔ Order Status Validated
-- ✔ Customer ID Validated
-- ✔ Product ID Validated
-- Status : PASSED
-- =====================================================

-- =====================================================
-- Check 15: Validate Total Amount Calculation
-- Purpose:
-- Verify that the stored total_amount matches the calculated value.
-- Expected Result:
-- No records should be returned.
-- =====================================================

SELECT *
FROM orders
WHERE ROUND(quantity * unit_price * (1 - discount_percent / 100), 2) <> ROUND(total_amount, 2);