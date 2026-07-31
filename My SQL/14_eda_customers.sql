USE novacart_analytics;

-- Total Customers

SELECT COUNT(*) Total_Customers
FROM customers;

-- Gender Distribution

SELECT gender,COUNT(*) Total
FROM customers
GROUP BY gender;

-- State Wise Customers

SELECT state,COUNT(*) Total_Customers
FROM customers
GROUP BY state
ORDER BY Total_Customers DESC;

-- City Wise Customers

SELECT city,COUNT(*) Total_Customers
FROM customers
GROUP BY city
ORDER BY Total_Customers DESC;

-- Average Loyalty Points

SELECT AVG(loyalty_points)
FROM customers;

-- Active Customers

SELECT is_active,COUNT(*)
FROM customers
GROUP BY is_active;