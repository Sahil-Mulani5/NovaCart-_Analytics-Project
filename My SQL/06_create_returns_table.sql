-- =========================================
-- Project : NovaCart Analytics
-- File    : 06_create_returns_table.sql
-- Purpose : Create Returns Table
-- =========================================

USE novacart_analytics;

CREATE TABLE returns (
    return_id VARCHAR(20) PRIMARY KEY,
    order_id VARCHAR(20),
    return_date DATE,
    reason VARCHAR(100),
    refund_amount DECIMAL(10,2),
    status VARCHAR(50)
);