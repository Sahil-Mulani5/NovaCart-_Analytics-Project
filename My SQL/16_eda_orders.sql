USE novacart_analytics;

-- Total Orders

SELECT COUNT(*)
FROM orders;

-- Revenue

SELECT SUM(total_amount)
FROM orders;

-- Average Order Value

SELECT AVG(total_amount)
FROM orders;

-- Order Status

SELECT order_status,COUNT(*)
FROM orders
GROUP BY order_status;

-- Payment Method

SELECT payment_method,COUNT(*)
FROM orders
GROUP BY payment_method;

-- Monthly Sales

SELECT
YEAR(order_date) Year,
MONTH(order_date) Month,
SUM(total_amount) Revenue
FROM orders
GROUP BY YEAR(order_date),MONTH(order_date)
ORDER BY Year,Month;

-- Top 10 Customers

SELECT
customer_id,
SUM(total_amount) Revenue
FROM orders
GROUP BY customer_id
ORDER BY Revenue DESC
LIMIT 10;