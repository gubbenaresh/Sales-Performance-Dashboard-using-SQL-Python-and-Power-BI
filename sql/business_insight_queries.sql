USE SalesPerformanceDB;
GO

/* Final business insight queries */

-- 1. Executive KPI summary
select 
     round(sum(sales),2) as total_sales,
	 round(sum(profit),2) as total_profit,
	 count(distinct(order_id)) as total_orders,
	 count(distinct(customer_id)) as total_customres,
	 round((sum(sales)/count(distinct(order_id))),2) as average_order_value
from sales_data;

-- 2. Category performance summary
SELECT
    category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin_percentage
FROM sales_data
GROUP BY category
ORDER BY total_sales DESC;

-- 3. Region performance summary
SELECT
    region,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND((SUM(profit) / SUM(sales)) * 100, 2) AS profit_margin_percentage
FROM sales_data
GROUP BY region
ORDER BY total_sales DESC;

-- 4. Monthly sales and profit trend
SELECT
    order_year,
    order_month,
    ROUND(SUM(sales), 2) AS monthly_sales,
    ROUND(SUM(profit), 2) AS monthly_profit
FROM sales_data
GROUP BY order_year, order_month
ORDER BY order_year, order_month;

-- 5. Month-over-month sales growth
WITH monthly_sales AS (
    SELECT
        DATEFROMPARTS(order_year, order_month, 1) AS sales_month,
        SUM(sales) AS monthly_sales
    FROM sales_data
    GROUP BY order_year, order_month
),
growth AS (
    SELECT
        sales_month,
        monthly_sales,
        LAG(monthly_sales) OVER (ORDER BY sales_month) AS previous_month_sales
    FROM monthly_sales
)
SELECT
    sales_month,
    ROUND(monthly_sales, 2) AS monthly_sales,
    ROUND(previous_month_sales, 2) AS previous_month_sales,
    ROUND(monthly_sales - previous_month_sales, 2) AS sales_difference,
    ROUND(((monthly_sales - previous_month_sales) / NULLIF(previous_month_sales, 0)) * 100, 2) AS growth_percentage
FROM growth
ORDER BY sales_month;

-- 6. Top 10 products by sales
SELECT TOP 10
    product_name,
    category,
    sub_category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM sales_data
GROUP BY product_name, category, sub_category
ORDER BY total_sales DESC;

-- 7. Top 10 loss-making products
SELECT TOP 10
    product_name,
    category,
    sub_category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM sales_data
GROUP BY product_name, category, sub_category
HAVING SUM(profit) < 0
ORDER BY total_profit ASC;

-- 8. Top 10 customers
SELECT TOP 10
    customer_name,
    segment,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders
FROM sales_data
GROUP BY customer_name, segment
ORDER BY total_sales DESC;

-- 9. State performance
SELECT TOP 10
    state,
    region,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM sales_data
GROUP BY state, region
ORDER BY total_sales DESC;


-- 10. Segment performance
SELECT
    segment,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    COUNT(DISTINCT customer_id) AS total_customers
FROM sales_data
GROUP BY segment
ORDER BY total_sales DESC;

-- 11. Shipping mode performance
SELECT
    ship_mode,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(AVG(shipping_days), 2) AS avg_shipping_days
FROM sales_data
GROUP BY ship_mode
ORDER BY total_sales DESC;

-- 12. Discount vs profit analysis
SELECT
    discount,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    COUNT(*) AS total_records
FROM sales_data
GROUP BY discount
ORDER BY discount;

-- 13. Product rank inside each category
WITH product_sales AS (
    SELECT
        product_name,
        category,
        SUM(sales) AS total_sales
    FROM sales_data
    GROUP BY product_name, category
)
SELECT
    product_name,
    category,
    ROUND(total_sales, 2) AS total_sales,
    RANK() OVER (
        PARTITION BY category
        ORDER BY total_sales DESC
    ) AS product_rank
FROM product_sales
ORDER BY category, product_rank;


-- 14. Customer rank by sales
WITH customer_sales AS (
    SELECT
        customer_name,
        SUM(sales) AS total_sales
    FROM sales_data
    GROUP BY customer_name
)
SELECT
    customer_name,
    ROUND(total_sales, 2) AS total_sales,
    RANK() OVER (
        ORDER BY total_sales DESC
    ) AS customer_rank
FROM customer_sales;