-- =========================================
-- Project : NovaCart Analytics
-- File    : 04_create_products_table.sql
-- Purpose : Create Products Table
-- =========================================

USE novacart_analytics;

CREATE TABLE products (
    product_id VARCHAR(20) PRIMARY KEY,
    product_name VARCHAR(150),
    category VARCHAR(100),
    brand VARCHAR(100),
    supplier_id VARCHAR(20),
    cost_price DECIMAL(10,2),
    selling_price DECIMAL(10,2),
    stock_quantity INT,
    rating DECIMAL(3,2),
    launch_date DATE,
    is_active BOOLEAN
);