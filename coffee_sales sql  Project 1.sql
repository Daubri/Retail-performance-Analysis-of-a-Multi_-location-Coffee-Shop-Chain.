CREATE TABLE coffee_sales (
    transaction_id INT,
    transaction_date DATE,
    transaction_time TIME,
    transaction_qty INT,
    store_id INT,
    store_location TEXT,
    product_id INT,
    unit_price NUMERIC,
    product_category TEXT,
    product_type TEXT,
    product_detail TEXT
);

SELECT COUNT(*) FROM coffee_sales;

SELECT * FROM coffee_sales
LIMIT 10;

SELECT column_name,data_type
FROM information_schema.columns
WHERE table_name = 'table

---What is the unit of analysis?
--what does ONE row represent?
	SELECT COUNT(*) AS total_rows,
	COUNT(DISTINCT transaction_id)AS unique_transactions
	FROM coffee_sales;


---TIME COVERAGE
what period does this data cover?

SELECT MIN(transaction_date) AS start_date,
       MAX(transaction_date) AS end_date
FROM coffee_sales;

📊 Core KPI: Revenue & Volume

🎯 Business Question

How is the business performing overall?
SELECT 
    SUM(transaction_qty * unit_price) AS total_revenue,
    SUM(transaction_qty) AS total_units_sold,
    COUNT(DISTINCT transaction_id) AS total_transactions
FROM coffee_sales;

⑥ 🏪 Store Performance

🎯 Business Question

Which locations perform best?
SELECT 
    store_location,
    ROUND(SUM(transaction_qty * unit_price),0) AS revenue
FROM coffee_sales
GROUP BY store_location
ORDER BY revenue DESC;


⑦ 🛍️ Product Performance

🎯 Business Question

What products drive sales?

By category:

SELECT 
    product_category,
    SUM(transaction_qty) AS units_sold
FROM coffee_sales
GROUP BY product_category
ORDER BY units_sold DESC;

SELECT 
    product_type,
    SUM(transaction_qty * unit_price) AS revenue
FROM coffee_sales
GROUP BY product_type
ORDER BY revenue DESC;

--HIGH-VALUE BUSINESS INSIGHT
⏰ Peak Sales Hours

🎯 Question

When should staffing be highest?

SELECT 
    EXTRACT(HOUR FROM transaction_time) AS hour,
    COUNT(*) AS transactions
FROM coffee_sales
GROUP BY hour
ORDER BY transactions DESC;

📆 Daily Trends

🎯 Question

How do sales fluctuate over time?

SELECT 
    transaction_date,
    SUM(transaction_qty * unit_price) AS daily_revenue
FROM coffee_sales
GROUP BY transaction_date
ORDER BY transaction_date;


Top Products by Revenue

🎯 Question

What should be promoted or stocked more?

SELECT 
    product_detail,
    ROUND(SUM(transaction_qty * unit_price),0) AS revenue
FROM coffee_sales
GROUP BY product_detail
ORDER BY revenue DESC
LIMIT 10;

📉 Underperforming Stores

🎯 Question

Which locations may need intervention?

SELECT 
    store_location,
   ROUND(SUM(transaction_qty * unit_price),0) AS revenue
FROM coffee_sales
GROUP BY store_location
ORDER BY revenue ASC;

Overall Business Health (Executive KPIs)

🎯 Question

How is the business performing overall?
SELECT
    ROUND(SUM(transaction_qty * unit_price), 0) AS total_revenue,
    SUM(transaction_qty) AS total_units_sold,
    COUNT(DISTINCT transaction_id) AS total_transactions
FROM coffee_sales;

Store Performance Analysis

🎯 Question A

Which store generates the most revenue?

SELECT 
    store_location,
    ROUND(SUM(transaction_qty * unit_price),0) AS revenue
FROM coffee_sales
GROUP BY store_location
ORDER BY revenue DESC;

🎯 Question B

Which store needs intervention?

SELECT
    store_location,
    ROUND(SUM(transaction_qty * unit_price), 0) AS revenue
FROM coffee_sales
GROUP BY store_location
ORDER BY revenue ASC;

Product Performance

🎯 Question A

Which product categories drive sales?
SELECT
    product_category,
    ROUND(SUM(transaction_qty), 0) AS units_sold
FROM coffee_sales
GROUP BY product_category
ORDER BY units_sold DESC;

🎯 Question B

Which products generate the most revenue?

SELECT
    product_detail,
    ROUND(SUM(transaction_qty * unit_price), 0) AS revenue
FROM coffee_sales
GROUP BY product_detail
ORDER BY revenue DESC
LIMIT 10;
       This are the top 10 product advisable to promote.

🎯 Question C

Which products underperform?
	   
 SELECT
    product_detail,
    ROUND(SUM(transaction_qty * unit_price), 0) AS revenue
FROM coffee_sales
GROUP BY product_detail
ORDER BY revenue ASC
LIMIT 10;


Time & Demand Patterns

🎯 Question A

What time of day drives peak sales?

SELECT
    EXTRACT(HOUR FROM transaction_time) AS hour,
    COUNT(*) AS transactions
FROM coffee_sales
GROUP BY hour
ORDER BY transactions DESC;

Question B

Daily revenue trend
SELECT
    transaction_date,
    ROUND(SUM(transaction_qty * unit_price), 0) AS daily_revenue
FROM coffee_sales
GROUP BY transaction_date
ORDER BY transaction_date;

🎯 Question C

Weekday vs Weekend performanc
SELECT
    EXTRACT(DOW FROM transaction_date) AS day_of_week,
    ROUND(SUM(transaction_qty * unit_price), 0) AS revenue
FROM coffee_sales
GROUP BY day_of_week
ORDER BY day_of_week;
0= Sunday,6=Saturday


Strategic Questions 
🎯 Question
Which store-product combinations drive revenue?

SELECT
    store_location,
    product_category,
    ROUND(SUM(transaction_qty * unit_price), 0) AS revenue
FROM coffee_sales
GROUP BY store_location, product_category
ORDER BY revenue DESC;

Question

Average transaction value

SELECT
    ROUND(
        SUM(transaction_qty * unit_price) /
        COUNT(DISTINCT transaction_id),
        2
    ) AS avg_transaction_value
FROM coffee_sales;

















