CREATE DATABASE SalesPerformanceDB;
GO

USE SalesPerformanceDB;
GO

CREATE TABLE sales_data (
    row_id INT,
    order_id VARCHAR(50),
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(50),
    customer_id VARCHAR(50),
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    region VARCHAR(50),
    product_id VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(255),
    sales DECIMAL(12,2),
    quantity INT,
    discount DECIMAL(5,2),
    profit DECIMAL(12,2),
    order_year INT,
    order_month INT,
    order_month_name VARCHAR(20),
    order_quarter INT,
    profit_margin DECIMAL(10,2),
    shipping_days INT,
    sales_category VARCHAR(20)
);
GO