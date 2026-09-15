-- =============================================
-- E-Commerce Sales Analytics Project
-- 03 - Customer Analysis
--
-- Note: in this dataset customer_id is generated
-- per order, so customer_unique_id is the true
-- identifier for a real-world customer. Use
-- customer_unique_id for anything about repeat
-- behavior or customer counts.
-- =============================================

USE olist_ecommerce;

-- =============================================
-- 1. Total Unique Customers vs Total Orders
-- =============================================

SELECT
    COUNT(DISTINCT c.customer_unique_id) AS unique_customers,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id;

-- =============================================
-- 2. Customers by State
-- =============================================

SELECT
    customer_state,
    COUNT(DISTINCT customer_unique_id) AS total_customers
FROM customers
GROUP BY
    customer_state
ORDER BY
    total_customers DESC;

-- =============================================
-- 3. Top 10 States by Revenue
-- =============================================

SELECT
    c.customer_state,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_state
ORDER BY
    total_revenue DESC
LIMIT 10;

-- =============================================
-- 4. Repeat Customers
-- How many real customers placed more than one order
-- =============================================

SELECT
    orders_per_customer,
    COUNT(*) AS number_of_customers
FROM (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS orders_per_customer
    FROM customers AS c
    JOIN orders AS o
        ON c.customer_id = o.customer_id
    GROUP BY
        c.customer_unique_id
) AS customer_orders
GROUP BY
    orders_per_customer
ORDER BY
    orders_per_customer;

-- =============================================
-- 5. Repeat Purchase Rate
-- =============================================

SELECT
    ROUND(
        SUM(CASE WHEN orders_per_customer > 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*), 2
    ) AS repeat_customer_pct
FROM (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS orders_per_customer
    FROM customers AS c
    JOIN orders AS o
        ON c.customer_id = o.customer_id
    GROUP BY
        c.customer_unique_id
) AS customer_orders;

-- =============================================
-- 6. Top 10 Customers by Total Spend
-- =============================================

SELECT
    c.customer_unique_id,
    c.customer_state,
    ROUND(SUM(oi.price), 2) AS total_spend
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_unique_id,
    c.customer_state
ORDER BY
    total_spend DESC
LIMIT 10;

-- =============================================
-- 7. Average Spend per Customer
-- =============================================

SELECT
    ROUND(SUM(oi.price) / COUNT(DISTINCT c.customer_unique_id), 2) AS avg_spend_per_customer
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN order_items AS oi
    ON o.order_id = oi.order_id;

-- =============================================
-- 8. Preferred Payment Method by State
-- Top payment type per state, by usage count
-- =============================================

SELECT
    c.customer_state,
    p.payment_type,
    COUNT(*) AS total_payments
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN payments AS p
    ON o.order_id = p.order_id
GROUP BY
    c.customer_state,
    p.payment_type
ORDER BY
    c.customer_state,
    total_payments DESC;

-- =============================================
-- 9. Installment Behavior
-- Average number of installments used per state
-- =============================================

SELECT
    c.customer_state,
    ROUND(AVG(p.payment_installments), 2) AS avg_installments
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN payments AS p
    ON o.order_id = p.order_id
GROUP BY
    c.customer_state
ORDER BY
    avg_installments DESC;

-- =============================================
-- 10. Average Review Score by State
-- =============================================

SELECT
    c.customer_state,
    ROUND(AVG(r.review_score), 2) AS avg_review_score,
    COUNT(r.review_id) AS total_reviews
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN reviews AS r
    ON o.order_id = r.order_id
GROUP BY
    c.customer_state
HAVING
    COUNT(r.review_id) > 100
ORDER BY
    avg_review_score DESC;
    avg_review_score DESC;