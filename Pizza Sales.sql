SELECT * FROM pizzasales;

-- total revenue

SELECT SUM(total_price) AS total_revenue
FROM pizzasales;

-- average order value

SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS avg_order_value
FROM pizzasales;

-- total pizzas sold

SELECT SUM(quantity) AS total_pizza_sold
FROM pizzasales;

-- total orders

SELECT COUNT(DISTINCT order_id) AS total_orders
FROM pizzasales;

-- average pizzas per order

SELECT CAST(SUM(quantity) AS DECIMAL(10,2)) /
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS avg_orders
FROM pizzasales;

-- ----------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------

-- daily trend for total orders

SELECT DATE_FORMAT(order_date, '%d') AS order_day, COUNT(DISTINCT order_id) AS total_orders
FROM pizzasales
GROUP BY DATE_FORMAT(order_date, '%d');

-- monthly trend for total orders

SELECT DATE_FORMAT(order_date, '%M') AS month_name, COUNT(DISTINCT order_id) AS total_orders
FROM pizzasales
GROUP BY DATE_FORMAT(order_date, '%M')
ORDER BY total_orders DESC;

-- percentage of sales by pizza category

SELECT pizza_category,  SUM(total_price) AS total_sales,
SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizzasales) AS PCT
FROM pizzasales
GROUP BY pizza_category;

-- percentage of sales by pizza size

SELECT pizza_size, 
       SUM(total_price) AS total_sales, 
       (SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizzasales)) AS PCT
FROM pizzasales
GROUP BY pizza_size
ORDER BY PCT DESC;

-- top 5 best sellers by revenue, total quantity, total orders

SELECT pizza_name, SUM(total_price) AS total_revenue
FROM pizzasales
GROUP BY pizza_name
ORDER BY SUM(total_price) DESC;

SELECT pizza_name, SUM(quantity) AS total_quantity
FROM pizzasales
GROUP BY pizza_name
ORDER BY total_quantity DESC;

SELECT pizza_name, COUNT(DISTINCT order_id) AS total_orders
FROM pizzasales
GROUP BY pizza_name
ORDER BY total_orders DESC;
