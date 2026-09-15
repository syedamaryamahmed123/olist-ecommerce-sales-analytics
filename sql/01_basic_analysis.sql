-- =============================================
-- E-Commerce Sales Analytics Project
-- 01 - Basic Analysis
-- Getting to know the database: row counts, date
-- ranges, and order status breakdown
-- =============================================

USE olist_ecommerce;

-- =============================================
-- 1. Row Counts per Table
-- =============================================

SELECT 'customers' AS table_name, COUNT(*) AS row_count FROM customers
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'payments', COUNT(*) FROM payments
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'reviews', COUNT(*) FROM reviews
UNION ALL
SELECT 'sellers', COUNT(*) FROM sellers;

-- =============================================
-- 2. Distinct Key Counts
-- Sanity check for duplicates / one-to-many relationships
-- =============================================

SELECT
    COUNT(DISTINCT order_id) AS unique_orders,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM orders;

SELECT
    COUNT(DISTINCT product_id) AS unique_products
FROM products;

SELECT
    COUNT(DISTINCT seller_id) AS unique_sellers
FROM sellers;

SELECT
    COUNT(*) AS total_reviews,
    COUNT(DISTINCT review_id) AS unique_review_ids
FROM reviews;

-- =============================================
-- 3. Date Range of the Dataset
-- =============================================

SELECT
    MIN(order_purchase_timestamp) AS earliest_order,
    MAX(order_purchase_timestamp) AS latest_order
FROM orders;

-- =============================================
-- 4. Order Status Breakdown
-- =============================================

SELECT
    order_status,
    COUNT(*) AS total_orders,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders), 2) AS pct_of_orders
FROM orders
GROUP BY
    order_status
ORDER BY
    total_orders DESC;

-- =============================================
-- 5. Orders per Customer
-- Confirms most customers only order once
-- =============================================

SELECT
    orders_per_customer,
    COUNT(*) AS number_of_customers
FROM (
    SELECT
        customer_id,
        COUNT(order_id) AS orders_per_customer
    FROM orders
    GROUP BY
        customer_id
) AS customer_order_counts
GROUP BY
    orders_per_customer
ORDER BY
    orders_per_customer;

-- =============================================
-- 6. Items per Order
-- =============================================

SELECT
    ROUND(AVG(items_per_order), 2) AS avg_items_per_order,
    MAX(items_per_order) AS max_items_per_order
FROM (
    SELECT
        order_id,
        COUNT(order_item_id) AS items_per_order
    FROM order_items
    GROUP BY
        order_id
) AS order_item_counts;

-- =============================================
-- 7. Payment Types Used
-- =============================================

SELECT
    payment_type,
    COUNT(*) AS total_payments,
    ROUND(SUM(payment_value), 2) AS total_value
FROM payments
GROUP BY
    payment_type
ORDER BY
    total_value DESC;

-- =============================================
-- 8. Review Score Distribution
-- =============================================

SELECT
    review_score,
    COUNT(*) AS total_reviews
FROM reviews
GROUP BY
    review_score
ORDER BY
    review_score DESC;

-- =============================================
-- 9. States Covered by Customers and Sellers
-- =============================================

SELECT
    (SELECT COUNT(DISTINCT customer_state) FROM customers) AS customer_states,
    (SELECT COUNT(DISTINCT seller_state) FROM sellers) AS seller_states;

-- =============================================
-- 10. Missing / NULL Check on Key Numeric Columns
-- =============================================

SELECT
    SUM(CASE WHEN delivery_days IS NULL THEN 1 ELSE 0 END) AS null_delivery_days,
    SUM(CASE WHEN delivery_delay_days IS NULL THEN 1 ELSE 0 END) AS null_delivery_delay_days
FROM orders;

SELECT
    SUM(CASE WHEN product_weight_g IS NULL THEN 1 ELSE 0 END) AS null_weight,
    SUM(CASE WHEN product_length_cm IS NULL THEN 1 ELSE 0 END) AS null_length
FROM products;