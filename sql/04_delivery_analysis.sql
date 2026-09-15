-- =============================================
-- E-Commerce Sales Analytics Project
-- 04 - Delivery Analysis
--
-- Uses delivery_days and delivery_delay_days,
-- pre-calculated during cleaning:
--   delivery_days       = delivered_customer_date - purchase_timestamp
--   delivery_delay_days = delivered_customer_date - estimated_delivery_date
--   (positive delay = delivered later than estimated)
-- Both are NULL for orders never delivered, so they
-- are naturally excluded from AVG/SUM below.
-- =============================================

USE olist_ecommerce;

-- =============================================
-- 1. Average Delivery Time
-- =============================================

SELECT
    ROUND(AVG(delivery_days), 2) AS avg_delivery_days,
    MIN(delivery_days) AS fastest_delivery_days,
    MAX(delivery_days) AS slowest_delivery_days
FROM orders
WHERE delivery_days IS NOT NULL;

-- =============================================
-- 2. On-Time vs Late Delivery Rate
-- delivery_delay_days > 0 means delivered after
-- the estimated delivery date
-- =============================================

SELECT
    CASE
        WHEN delivery_delay_days > 0 THEN 'Late'
        ELSE 'On Time or Early'
    END AS delivery_status,
    COUNT(*) AS total_orders,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2
    ) AS pct_of_delivered_orders
FROM orders
WHERE delivery_delay_days IS NOT NULL
GROUP BY
    delivery_status;

-- =============================================
-- 3. Average Delay by Month
-- =============================================

SELECT
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS order_month,
    ROUND(AVG(delivery_delay_days), 2) AS avg_delay_days
FROM orders
WHERE delivery_delay_days IS NOT NULL
GROUP BY
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m')
ORDER BY
    order_month;

-- =============================================
-- 4. Delivery Performance by Customer State
-- =============================================

SELECT
    c.customer_state,
    ROUND(AVG(o.delivery_days), 2) AS avg_delivery_days,
    ROUND(AVG(o.delivery_delay_days), 2) AS avg_delay_days,
    COUNT(o.order_id) AS total_delivered_orders
FROM orders AS o
JOIN customers AS c
    ON o.customer_id = c.customer_id
WHERE o.delivery_days IS NOT NULL
GROUP BY
    c.customer_state
ORDER BY
    avg_delivery_days DESC;

-- =============================================
-- 5. Slowest 10 States by Average Delivery Time
-- Minimum order volume filter avoids small-sample noise
-- =============================================

SELECT
    c.customer_state,
    ROUND(AVG(o.delivery_days), 2) AS avg_delivery_days,
    COUNT(o.order_id) AS total_delivered_orders
FROM orders AS o
JOIN customers AS c
    ON o.customer_id = c.customer_id
WHERE o.delivery_days IS NOT NULL
GROUP BY
    c.customer_state
HAVING
    COUNT(o.order_id) > 50
ORDER BY
    avg_delivery_days DESC
LIMIT 10;

-- =============================================
-- 6. Delivery Performance by Seller
-- Top 10 slowest sellers with meaningful order volume
-- =============================================

SELECT
    s.seller_id,
    s.seller_state,
    ROUND(AVG(o.delivery_days), 2) AS avg_delivery_days,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
JOIN sellers AS s
    ON oi.seller_id = s.seller_id
WHERE o.delivery_days IS NOT NULL
GROUP BY
    s.seller_id,
    s.seller_state
HAVING
    COUNT(DISTINCT o.order_id) > 20
ORDER BY
    avg_delivery_days DESC
LIMIT 10;

-- =============================================
-- 7. Late Deliveries and Review Score
-- Does a late delivery correlate with a lower review score?
-- =============================================

SELECT
    CASE
        WHEN o.delivery_delay_days > 0 THEN 'Late'
        ELSE 'On Time or Early'
    END AS delivery_status,
    ROUND(AVG(r.review_score), 2) AS avg_review_score,
    COUNT(r.review_id) AS total_reviews
FROM orders AS o
JOIN reviews AS r
    ON o.order_id = r.order_id
WHERE o.delivery_delay_days IS NOT NULL
GROUP BY
    delivery_status;

-- =============================================
-- 8. Undelivered Orders by Status
-- Orders with no delivery_days value, broken down
-- by their current order_status
-- =============================================

SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
WHERE delivery_days IS NULL
GROUP BY
    order_status
ORDER BY
    total_orders DESC;

-- =============================================
-- 9. Freight Cost vs Delivery Time
-- Does paying more freight correlate with faster delivery?
-- =============================================

SELECT
    CASE
        WHEN oi.freight_value < 10 THEN 'Under $10'
        WHEN oi.freight_value < 20 THEN '$10-$20'
        WHEN oi.freight_value < 30 THEN '$20-$30'
        ELSE '$30+'
    END AS freight_bucket,
    ROUND(AVG(o.delivery_days), 2) AS avg_delivery_days,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.delivery_days IS NOT NULL
GROUP BY
    freight_bucket
ORDER BY
    avg_delivery_days DESC;

-- =============================================
-- 10. Extremely Late Orders (Delay > 15 Days)
-- =============================================

SELECT
    o.order_id,
    c.customer_state,
    o.order_purchase_timestamp,
    o.order_estimated_delivery_date,
    o.order_delivered_customer_date,
    o.delivery_delay_days
FROM orders AS o
JOIN customers AS c
    ON o.customer_id = c.customer_id
WHERE o.delivery_delay_days > 15
ORDER BY
    o.delivery_delay_days DESC
LIMIT 20;