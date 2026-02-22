CREATE DATABASE sales_project;

USE sales_project;

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_name VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(100),
    region VARCHAR(50),
    segment VARCHAR(50),
    payment_method VARCHAR(50)
);


CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product VARCHAR(100),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    quantity INT,
    unit_price DECIMAL(10,2),
    discount DECIMAL(5,2),
    cost_price DECIMAL(10,2),
    sales DECIMAL(15,2),
    profit DECIMAL(15,2),
    
    CONSTRAINT fk_order
    FOREIGN KEY (order_id) 
    REFERENCES orders(order_id)
);

# 1 Write a query to find total sales.
SELECT SUM(sales) AS Total_Sales
From order_details;

# 2 Write a query to find total profit.
SELECT SUM(profit) AS Total_Profit
FROM order_details;

# 3 Find total orders in the dataset.
SELECT DISTINCT COUNT(order_detail_id) AS Total_Orders
FROM order_details;

# 4 Show first 10 records from order_details.
SELECT * FROM order_details
LIMIT 10;

# 5 Find distinct regions from orders table
SELECT DISTINCT(region) FROM orders;

# 6 Find region-wise total sales.
SELECT o.region, SUM(od.sales) AS total_sales from orders o
inner join order_details od ON o.order_id = od.order_id 
GROUP BY o.region 
ORDER BY total_sales desc;

# 7 Find category-wise total profit.
SELECT category, SUM(profit) AS total_profit
FROM order_details
GROUP BY category
ORDER BY total_profit DESC;

# 8 Find monthly total sales.
SELECT MONTH(order_date) AS month,
SUM(od.sales) AS total_sales 
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY Month(order_date) 
ORDER BY month;

# 9 Find payment method-wise profit.
SELECT payment_method, SUM(profit) AS total_profit
FROM orders o 
INNER JOIN order_details od ON o.order_id = od.order_id
GROUP BY payment_method;

# 10 Find average discount given per category.
SELECT category, AVG(discount) AS avg_discount 
FROM order_details 
GROUP BY category ;

# 11 Write a query to combine orders and order_details tables.
SELECT o.order_id , o.region, od.product, od.sales 
FROM orders o 
INNER JOIN order_details od ON o.order_id = od.order_id;

# 12 Find region-wise total profit using JOIN.
SELECT o.region, SUM(od.profit) AS total_profit 
FROM orders o 
INNER JOIN order_details od ON o.order_id = od.order_id
GROUP BY o.region;

# 13 Find top 5 products by total sales.
SELECT product, SUM(sales) AS total_sales 
FROM order_details 
GROUP BY product 
ORDER BY total_sales DESC
LIMIT 5;

# 14 Find which region has highest sales.
SELECT o.region, SUM(od.sales) AS highest_sales
FROM orders o 
INNER JOIN order_details od ON o.order_id = od.order_id
GROUP BY o.region
ORDER BY highest_sales DESC
LIMIT 1; 

# 15 Find total quantity sold per segment.
SELECT o.segment, SUM(od.quantity) AS total_quantity_sold 
FROM orders o 
INNER JOIN order_details od ON 
o.order_id = od.order_id 
GROUP BY segment;

# 16 Find products where profit is negative.
SELECT product, SUM(profit) AS total_profit 
FROM order_details 
GROUP BY product
HAVING total_profit < 0;

# 17 products with profit margin less than 10%.
SELECT product, (SUM(profit )/ SUM(sales) )* 100 AS profit_margin
FROM order_details 
GROUP BY product
HAVING profit_margin < 10;
 
# 18 Find regions where average discount is greater than 20%.
SELECT o.region, avg(od.discount) AS avg_discount
FROM orders o 
INNER JOIN order_details od ON o.order_id = od.order_id
GROUP BY o.region
HAVING avg_discount > 20;

# 19 Find top 3 most profitable products.
SELECT product, SUM(profit) AS total_profit 
FROM order_details 
GROUP BY product 
ORDER BY total_profit DESC
LIMIT 3;

# 20 Find sales where discount impact is highest.
SELECT product, SUM(sales) AS total_sales,
SUM(quantity * unit_price *(discount / 100)) AS discount_impact
FROM order_details 
GROUP BY product
ORDER BY discount_impact DESC
LIMIT 1 ;

# 21 Extract month from order_date.
SELECT MONTH(order_date) AS month 
FROM orders;

# 22 Find month with highest sales. \
SELECT MONTH(o.order_date) AS months , SUM(od.sales) AS highest_sales
FROM orders o 
INNER JOIN order_details od ON o.order_id = od.order_id 
GROUP BY months
ORDER BY highest_sales DESC
LIMIT 1;

# 23 Calculate year-wise total sales.
SELECT YEAR(o.order_date) AS years, SUM(od.sales) AS total_sales
FROM orders o 
INNER JOIN order_details od ON o.order_id = od.order_id
GROUP BY years
ORDER BY total_sales;
