## SQL Business Analysis

This project answers key business questions using SQL, including:

- Top-selling SKUs
- Revenue by product category
- Monthly sales trends
- Average Order Value (AOV)
- Highest-value orders



  


-- Q1. Which SKU generated the highest sales volume?

SELECT
    SKU,
    SUM(Qty) AS units_sold
FROM `resolute-might-491020-q6.Amazon_Sale_Report.sale report`
WHERE Status != 'Cancelled'
GROUP BY SKU
ORDER BY units_sold DESC
LIMIT 10;


-- Q2. Which product categories generated the highest sales revenue?

SELECT
    Category,
    SUM(Amount) AS revenue,
    SUM(Qty) AS units_sold
FROM `resolute-might-491020-q6.Amazon_Sale_Report.sale report`
WHERE Status != 'Cancelled'
GROUP BY Category
ORDER BY revenue DESC;


-- Q3. Which months recorded the highest and lowest sales?

SELECT
    DATE_TRUNC(Date, MONTH) AS sales_month,
    SUM(Amount) AS revenue,
    SUM(Qty) AS units_sold,
    COUNT(DISTINCT `Order ID`) AS orders
FROM `resolute-might-491020-q6.Amazon_Sale_Report.sale report`
WHERE Status != 'Cancelled'
GROUP BY sales_month
ORDER BY sales_month;


-- Q4. What is the Average Order Value (AOV)?

WITH order_totals AS (
    SELECT
        `Order ID`,
        SUM(Amount) AS order_value
    FROM `resolute-might-491020-q6.Amazon_Sale_Report.sale report`
    WHERE Status != 'Cancelled'
    GROUP BY `Order ID`
)

SELECT
    COUNT(*) AS total_orders,
    SUM(order_value) AS total_revenue,
    AVG(order_value) AS average_order_value
FROM order_totals;


-- Q5. Which orders had the highest order values?

SELECT
    `Order ID`,
    SUM(Amount) AS order_value,
    SUM(Qty) AS total_items
FROM `resolute-might-491020-q6.Amazon_Sale_Report.sale report`
WHERE Status != 'Cancelled'
GROUP BY `Order ID`
ORDER BY order_value DESC
LIMIT 10;
