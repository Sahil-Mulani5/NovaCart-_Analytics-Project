-- =====================================================
-- Project : NovaCart Analytics
-- File    : 13_data_validation.sql
-- Purpose : Cross Table Data Validation
-- =====================================================

USE novacart_analytics;

-- =====================================================
-- Validation 01
-- Orders without Customers
-- =====================================================

SELECT o.*
FROM orders o
LEFT JOIN customers c
ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- =====================================================
-- Validation 02
-- Orders without Products
-- =====================================================

SELECT o.*
FROM orders o
LEFT JOIN products p
ON o.product_id = p.product_id
WHERE p.product_id IS NULL;

-- =====================================================
-- Validation 03
-- Products without Suppliers
-- =====================================================

SELECT p.*
FROM products p
LEFT JOIN suppliers s
ON p.supplier_id=s.supplier_id
WHERE s.supplier_id IS NULL;

-- =====================================================
-- Validation 04
-- Returns without Orders
-- =====================================================

SELECT r.*
FROM returns r
LEFT JOIN orders o
ON r.order_id=o.order_id
WHERE o.order_id IS NULL;

-- =====================================================
-- Validation 05
-- Duplicate Customer Emails
-- =====================================================

SELECT email,COUNT(*)
FROM customers
GROUP BY email
HAVING COUNT(*)>1;

-- =====================================================
-- Validation 06
-- Selling Price should be greater than Cost Price
-- =====================================================

SELECT *
FROM products
WHERE selling_price<cost_price;

-- =====================================================
-- Validation 07
-- Invalid Discount
-- =====================================================

SELECT *
FROM orders
WHERE discount_percent<0
OR discount_percent>100;

-- =====================================================
-- Validation 08
-- Negative Refund
-- =====================================================

SELECT *
FROM returns
WHERE refund_amount<0;