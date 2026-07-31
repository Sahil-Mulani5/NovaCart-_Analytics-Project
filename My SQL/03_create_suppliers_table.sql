-- =========================================
-- Project : NovaCart Analytics
-- File    : 03_create_suppliers_table.sql
-- Purpose : Create Suppliers Table
-- =========================================

USE novacart_analytics;

CREATE TABLE suppliers (
    supplier_id VARCHAR(20) PRIMARY KEY,
    supplier_name VARCHAR(100),
    supplier_type VARCHAR(50),
    contact_person VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50),
    supplier_rating DECIMAL(3,2),
    delivery_days INT,
    is_active BOOLEAN
);