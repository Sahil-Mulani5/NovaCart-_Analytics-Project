-- =========================================
-- Project : NovaCart Analytics
-- File    : 02_create_customers_table.sql
-- Purpose : Create Customers Table
-- =========================================

USE novacart_analytics;

CREATE TABLE customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender VARCHAR(10),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    city VARCHAR(50),
    state VARCHAR(50),
    join_date DATE,
    loyalty_points INT,
    is_active BOOLEAN
);