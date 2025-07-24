use [pizza sales]
go

--1.   total revenue of pizza sales
SELECT  CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue  FROM pizza_sales

--2.  Avarage order value
SELECT CAST(SUM(total_price)/ COUNT(distinct order_id) AS DECIMAL(10,2)) as avg_order_value from pizza_sales

--3. total pizza sold
--to change the column to constraint 
ALTER TABLE pizza_sales
DROP CONSTRAINT pizza_sales;
--change data type of column 
ALTER TABLE pizza_sales
ALTER COLUMN quantity INT;

--3. total pizza sold
SELECT SUM(quantity) AS Total_pizza_sold from pizza_sales

--4.toal orders 
select COUNT(order_id) AS Total_orders from pizza_sales

-- 5. to find avg pizza pe order 
SELECT CAST(SUM(quantity) * 1.0 / COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS avg_pizza_per_order
FROM pizza_sales;


--chart requrnment
--1. orders by days
SELECT DATENAME(WEEKDAY, order_date) AS order_day, COUNT(DISTINCT order_id) AS Total_order FROM pizza_sales
GROUP BY DATENAME(WEEKDAY, order_date)
ORDER BY Total_order


-- 2. monthly trands for total orders 
SELECT DATENAME(MONTH, order_date) as month_name, COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY Total_orders DESC   --TOARRANGE THEM IN decending order


--3. parsentage of sales by pizZA category
SELECT 
  pizza_category, 
  SUM(total_price) AS total_sales,
  SUM(total_price) * 100.0 / 
    (SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) = 1) AS total_sales_percentage
FROM 
  pizza_sales
WHERE 
  MONTH(order_date) = 1
GROUP BY 
  pizza_category;



-- 4. parsentage of sales by pizza size
SELECT 
  pizza_size, 
  CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_sales,
  CAST(SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_sales)AS DECIMAL(10,2)) AS percentage_sales
FROM 
  pizza_sales
GROUP BY 
  pizza_size
order by percentage_sales desc


-- 5.top 5 best salers by revenue, by total quatity and total orders
SELECT TOP 5 pizza_name, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_revenue FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_revenue ASC


--top 6 pizza sold by quentity
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_quantity FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_quantity DESC












