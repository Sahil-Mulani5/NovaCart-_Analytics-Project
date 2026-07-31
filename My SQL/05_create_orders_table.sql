-- =========================================
-- Project : NovaCart Analytics
-- File    : 05_create_orders_table.sql
-- Purpose : Create Orders Table
-- =========================================

USE novacart_analytics;

CREATE TABLE orders (
    order_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20),
    product_id VARCHAR(20),
    order_date DATE,
    quantity INT,
    unit_price DECIMAL(10,2),
    discount_percent DECIMAL(5,2),
    total_amount DECIMAL(10,2),
    payment_method VARCHAR(50),
    order_status VARCHAR(50)
);