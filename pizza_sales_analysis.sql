select * from pizza_sales;

-- total revenue
SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales;

-- average order value
SELECT SUM(total_price)/COUNT(DISTINCT order_id) AS Average_Order_Value FROM pizza_sales;

-- total pizza sold
SELECT SUM(quantity) AS Total_Pizza_Sold from pizza_sales;

-- total orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales;

-- average pizzas per order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2))/CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Average_Pizzas_Per_Order
FROM pizza_sales;

-- revenue per pizza
SELECT ROUND(SUM(total_price) / SUM(quantity), 2) AS revenue_per_pizza
FROM pizza_sales;

-- Chart Visualization

-- daily trend for total orders
SELECT DATENAME(DW,order_date) AS Order_Day,COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales
GROUP BY DATENAME(DW,order_date);

-- monthly trend for total orders
SELECT DATENAME(MONTH,order_date) AS Month_Name,COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales
GROUP BY DATENAME(MONTH,order_date)
ORDER BY Total_Orders DESC;

-- Weekday vs Weekend Orders
SELECT
CASE
WHEN DATENAME(WEEKDAY, order_date) IN ('Saturday', 'Sunday')
THEN 'Weekend'
ELSE 'Weekday'
END AS day_type,COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY
CASE
WHEN DATENAME(WEEKDAY, order_date) IN ('Saturday', 'Sunday')
THEN 'Weekend'
ELSE 'Weekday'
END
ORDER BY total_orders DESC;

-- percentage of sales by pizza category 
SELECT pizza_category,SUM(total_price)*100/(SELECT sum(total_price) from pizza_sales) AS PCT
from pizza_sales
GROUP BY pizza_category;

-- if you want to filter for month jan
SELECT pizza_category,SUM(total_price)*100/(SELECT sum(total_price) from pizza_sales WHERE MONTH(order_date)=1) AS PCT
from pizza_sales
WHERE MONTH(order_date)=1
GROUP BY pizza_category;

-- percentage of sales by pizza size
SELECT pizza_size,SUM(total_price) AS Total_Sales, SUM(total_price)*100/(SELECT sum(total_price) from pizza_sales) AS PCT
from pizza_sales
GROUP BY pizza_size
ORDER BY PCT DESC;

-- total pizzas sold by pizza category
SELECT pizza_category,SUM(quantity) AS Total_Pizzas_Sold FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Pizzas_Sold DESC;

-- top 5 bestselling pizzas by total revenue
SELECT TOP 5 pizza_name,SUM(total_price) AS Total_Revenue FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC;

-- top 5 bestselling pizzas by total quantity
SELECT TOP 5 pizza_name,SUM(quantity) AS Total_Quantity FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC;

-- top 5 bestselling pizzas by total orders
SELECT TOP 5 pizza_name,COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC;

-- bottom 5 bestselling pizzas by total revenue
SELECT TOP 5 pizza_name,SUM(total_price) AS Total_Revenue FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC;

-- bottom 5 bestselling pizzas by total quantity
SELECT TOP 5 pizza_name,SUM(quantity) AS Total_Quantity FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity ASC;

-- bottom 5 bestselling pizzas by total orders
SELECT TOP 5 pizza_name,COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC;