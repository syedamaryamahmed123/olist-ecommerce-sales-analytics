-- =============================================
-- E-Commerce Sales Analytics Project
-- 02 - Sales Analysis
-- =============================================

USE olist_ecommerce;

-- =============================================
-- 1. Total Revenue
-- =============================================

SELECT
    ROUND(SUM(price), 2) AS total_revenue
FROM order_items;

-- =============================================
-- 2. Total Freight Cost
-- =============================================

SELECT
    ROUND(SUM(freight_value), 2) AS total_freight_cost
FROM order_items;

-- =============================================
-- 3. Revenue from Delivered Orders
-- =============================================

SELECT
    ROUND(SUM(oi.price), 2) AS delivered_revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered';

-- =============================================
-- 4. Monthly Revenue
-- =============================================

SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS order_month,
    ROUND(SUM(oi.price), 2) AS monthly_revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')
ORDER BY
    order_month;

-- =============================================
-- 5. Monthly Revenue for Delivered Orders
-- =============================================

SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS order_month,
    ROUND(SUM(oi.price), 2) AS monthly_revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')
ORDER BY
    order_month;

-- =============================================
-- 6. Revenue by Product Category
-- =============================================

SELECT
    p.product_category_name,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items AS oi
JOIN products AS p
    ON oi.product_id = p.product_id
GROUP BY
    p.product_category_name
ORDER BY
    total_revenue DESC;

-- =============================================
-- 7. Top 10 Product Categories by Revenue
-- =============================================

SELECT
    p.product_category_name,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items AS oi
JOIN products AS p
    ON oi.product_id = p.product_id
GROUP BY
    p.product_category_name
ORDER BY
    total_revenue DESC
LIMIT 10;

-- =============================================
-- 8. Top 10 Categories by Order Volume
-- =============================================

SELECT
    p.product_category_name,
    COUNT(DISTINCT oi.order_id) AS total_orders
FROM order_items AS oi
JOIN products AS p
    ON oi.product_id = p.product_id
GROUP BY
    p.product_category_name
ORDER BY
    total_orders DESC
LIMIT 10;

-- =============================================
-- 9. Average Order Value
-- =============================================

SELECT
    ROUND(SUM(price) / COUNT(DISTINCT order_id), 2) AS average_order_value
FROM order_items;

-- =============================================
-- 10. Delivered Order Average Value
-- =============================================

SELECT
    ROUND(SUM(oi.price) / COUNT(DISTINCT o.order_id), 2) AS delivered_average_order_value
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered';

-- =============================================
-- 11. Top 10 Most Valuable Orders
-- =============================================

SELECT
    oi.order_id,
    ROUND(SUM(oi.price), 2) AS order_revenue
FROM order_items AS oi
GROUP BY
    oi.order_id
ORDER BY
    order_revenue DESC
LIMIT 10;

-- =============================================
-- 12. Revenue Per Order by Category
-- =============================================

SELECT
    p.product_category_name,
    ROUND(SUM(oi.price) / COUNT(DISTINCT oi.order_id), 2) AS revenue_per_order
FROM order_items AS oi
JOIN products AS p
    ON oi.product_id = p.product_id
GROUP BY
    p.product_category_name
ORDER BY
    revenue_per_order DESC;

-- =============================================
-- 13. Categories with More Than 1,000 Orders
-- Demonstrates the HAVING clause
-- =============================================

SELECT
    p.product_category_name,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items AS oi
JOIN products AS p
    ON oi.product_id = p.product_id
GROUP BY
    p.product_category_name
HAVING
    COUNT(DISTINCT oi.order_id) > 1000
ORDER BY
    total_revenue DESC;