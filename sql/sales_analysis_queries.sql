USE SalesPerformanceDB;
GO

-- 1. Check all data
SELECT TOP 10 *
FROM sales_data;

-- 2. Count total records
SELECT COUNT(*) AS total_records
FROM sales_data;

-- 3. Total sales
SELECT 
    SUM(sales) AS total_sales
FROM sales_data;

-- 4. Total profit
SELECT 
    SUM(profit) AS total_profit
FROM sales_data;

-- 5. Total orders
SELECT 
    COUNT(DISTINCT order_id) AS total_orders
FROM sales_data;

-- 6. Total customers
SELECT 
    COUNT(DISTINCT customer_id) AS total_customers
FROM sales_data;

-- 7. Average order value
SELECT 
    ROUND(SUM(sales) / COUNT(DISTINCT order_id), 2) AS average_order_value
FROM sales_data;

-- 8. Sales by category
SELECT 
    category,
    SUM(sales) AS total_sales
FROM sales_data
GROUP BY category
ORDER BY total_sales DESC;

-- 9. Profit by category
SELECT 
    category,
    SUM(profit) AS total_profit
FROM sales_data
GROUP BY category
ORDER BY total_profit DESC;

-- 10. Sales by region
SELECT 
    region,
    SUM(sales) AS total_sales
FROM sales_data
GROUP BY region
ORDER BY total_sales DESC;

-- 11. Profit by region
SELECT 
    region,
    SUM(profit) AS total_profit
FROM sales_data
GROUP BY region
ORDER BY total_profit DESC;

-- 12. Monthly sales trend
SELECT 
    order_year,
    order_month,
    SUM(sales) AS monthly_sales
FROM sales_data
GROUP BY order_year, order_month
ORDER BY order_year, order_month;

-- 13. Monthly profit trend
SELECT 
    order_year,
    order_month,
    SUM(profit) AS monthly_profit
FROM sales_data
GROUP BY order_year, order_month
ORDER BY order_year, order_month;

-- 14. Top 10 products by sales
SELECT TOP 10
    product_name,
    SUM(sales) AS total_sales
FROM sales_data
GROUP BY product_name
ORDER BY total_sales DESC;

-- 15. Top 10 customers by sales
SELECT TOP 10
    customer_name,
    SUM(sales) AS total_sales
FROM sales_data
GROUP BY customer_name
ORDER BY total_sales DESC;

-- 16. Segment-wise sales
SELECT 
    segment,
    SUM(sales) AS total_sales
FROM sales_data
GROUP BY segment
ORDER BY total_sales DESC;

-- 17. State-wise sales
SELECT TOP 10
    state,
    SUM(sales) AS total_sales
FROM sales_data
GROUP BY state
ORDER BY total_sales DESC;

-- 18. Discount impact
SELECT 
    discount,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM sales_data
GROUP BY discount
ORDER BY discount;