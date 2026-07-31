USE novacart_analytics;

-- Total Products

SELECT COUNT(*)
FROM products;

-- Category Distribution

SELECT category,COUNT(*)
FROM products
GROUP BY category
ORDER BY COUNT(*) DESC;

-- Brand Distribution

SELECT brand,COUNT(*)
FROM products
GROUP BY brand;

-- Average Selling Price

SELECT AVG(selling_price)
FROM products;

-- Average Cost Price

SELECT AVG(cost_price)
FROM products;

-- Average Rating

SELECT AVG(rating)
FROM products;

-- Low Stock

SELECT *
FROM products
WHERE stock_quantity<20;