USE novacart_analytics;

-- Top Selling Products

SELECT
product_id,
SUM(quantity) Qty
FROM orders
GROUP BY product_id
ORDER BY Qty DESC
LIMIT 10;

-- Top Revenue Products

SELECT
product_id,
SUM(total_amount) Revenue
FROM orders
GROUP BY product_id
ORDER BY Revenue DESC
LIMIT 10;

-- Top States by Revenue

SELECT
c.state,
SUM(o.total_amount) Revenue
FROM orders o
JOIN customers c
ON o.customer_id=c.customer_id
GROUP BY c.state
ORDER BY Revenue DESC;

-- Supplier Performance

SELECT
supplier_id,
COUNT(*) Products
FROM products
GROUP BY supplier_id;

-- Return Rate

SELECT
COUNT(*)*100/
(SELECT COUNT(*) FROM orders) Return_Percentage
FROM returns;