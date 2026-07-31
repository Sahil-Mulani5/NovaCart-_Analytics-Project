USE novacart_analytics;

-- Total Returns

SELECT COUNT(*)
FROM returns;

-- Total Refund

SELECT SUM(refund_amount)
FROM returns;

-- Return Status

SELECT status,COUNT(*)
FROM returns
GROUP BY status;

-- Return Reasons

SELECT reason,COUNT(*)
FROM returns
GROUP BY reason
ORDER BY COUNT(*) DESC;

-- Monthly Returns

SELECT
YEAR(return_date),
MONTH(return_date),
COUNT(*)
FROM returns
GROUP BY YEAR(return_date),MONTH(return_date);