-- 1
SELECT od.*, 
(SELECT o.customer_id FROM orders as o WHERE od.order_id = o.id) as cust_id
FROM order_details as od;

-- 2
SELECT od.*
FROM order_details as od
WHERE order_id IN (SELECT id FROM orders WHERE shipper_id = 3);

-- 3
SELECT order_id, AVG(quantity)
FROM (SELECT * FROM order_details WHERE quantity > 10) AS quantity_above_10
GROUP BY order_id;

-- 4

WITH temp AS (SELECT * FROM order_details WHERE quantity > 10)
SELECT order_id, AVG(quantity)
FROM temp
GROUP BY order_id;

-- 5

DROP FUNCTION IF EXISTS new_function;
DELIMITER //
CREATE FUNCTION new_function (
    dividend FLOAT,
    divisor FLOAT
) RETURNS FLOAT
DETERMINISTIC
NO SQL
BEGIN
    DECLARE result FLOAT;
    SET result = dividend / divisor;
    RETURN result;
END 
// DELIMITER ;
SELECT quantity, new_function(quantity, 2)
FROM order_details;