-- =========================================
-- Project : NovaCart Analytics
-- File    : 07_add_foreign_keys.sql
-- Purpose : Add Foreign Keys
-- =========================================

USE novacart_analytics;

ALTER TABLE products
ADD CONSTRAINT fk_products_supplier
FOREIGN KEY (supplier_id)
REFERENCES suppliers(supplier_id);

ALTER TABLE orders
ADD CONSTRAINT fk_orders_customer
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

ALTER TABLE orders
ADD CONSTRAINT fk_orders_product
FOREIGN KEY (product_id)
REFERENCES products(product_id);

ALTER TABLE returns
ADD CONSTRAINT fk_returns_order
FOREIGN KEY (order_id)
REFERENCES orders(order_id);