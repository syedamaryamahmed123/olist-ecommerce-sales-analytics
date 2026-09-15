# E-Commerce Sales Analytics — Project Summary

## 1. Project Overview

This project analyzes e-commerce sales data to understand revenue performance, customer behavior, product performance, payment behavior, and delivery performance.

The project combines Python, MySQL, and Power BI to transform raw e-commerce data into actionable business insights.

The analysis is based on the Brazilian E-Commerce Public Dataset by Olist.

---

## 2. Business Objectives

The main objectives of this project are:

- Analyze overall sales and revenue performance.
- Identify the highest-performing product categories.
- Understand customer distribution and purchasing behavior.
- Identify repeat customers and high-value customers.
- Analyze payment methods and installment behavior.
- Evaluate delivery performance.
- Identify states and sellers with slower delivery times.
- Investigate the relationship between delivery performance and customer review scores.
- Build an interactive Power BI dashboard for business reporting.

---

## 3. Dataset

The project uses the Olist Brazilian E-Commerce dataset.

The dataset contains information about:

- Customers
- Orders
- Order items
- Payments
- Reviews
- Products
- Sellers
- Geolocation
- Product category translations

The main analytical tables used in the project are:

- customers
- orders
- order_items
- payments
- reviews
- products
- sellers

---

## 4. Tools and Technologies

### Python

Python was used for:

- Data understanding
- Data cleaning
- Exploratory data analysis
- Data transformation
- Business analysis

Main libraries:

- pandas
- numpy
- matplotlib
- seaborn
- jupyter

### MySQL

MySQL was used for:

- Relational data analysis
- Aggregations
- JOIN operations
- GROUP BY analysis
- Window functions
- Customer analysis
- Sales analysis
- Delivery analysis

### Power BI

Power BI was used to create an interactive dashboard containing:

- Sales Overview
- Customer Analysis
- Delivery Analysis

---

## 5. Data Preparation

The raw datasets were inspected for:

- Missing values
- Duplicate records
- Incorrect data types
- Invalid dates
- Inconsistent values
- Relationships between tables

Important date fields were converted into appropriate date formats.

Additional delivery metrics were created, including:

- Delivery days
- Delivery delay days

### Delivery Days

Delivery days were calculated as:

`Delivered Customer Date - Order Purchase Date`

### Delivery Delay Days

Delivery delay was calculated as:

`Delivered Customer Date - Estimated Delivery Date`

A positive delivery delay indicates that an order was delivered later than the estimated delivery date.

---

## 6. SQL Analysis

The SQL analysis was divided into four scripts.

### 01 — Basic Analysis

The basic analysis includes:

- Row counts
- Distinct key counts
- Dataset date range
- Order status distribution
- Orders per customer
- Items per order
- Payment type distribution
- Review score distribution
- Customer and seller state coverage
- NULL value checks

### 02 — Sales Analysis

The sales analysis includes:

- Total revenue
- Total freight cost
- Revenue from delivered orders
- Monthly revenue
- Revenue by product category
- Top product categories
- Order volume by category
- Average order value
- Highest-value orders
- Revenue per order by category

### 03 — Customer Analysis

The customer analysis includes:

- Unique customer count
- Customer distribution by state
- Revenue by state
- Repeat customer analysis
- Repeat purchase rate
- Top customers by spending
- Average customer spending
- Payment preferences by state
- Installment behavior
- Review scores by state

### 04 — Delivery Analysis

The delivery analysis includes:

- Average delivery time
- Fastest and slowest delivery
- On-time versus late delivery
- Monthly delivery delay
- Delivery performance by state
- Slowest states
- Delivery performance by seller
- Delivery performance versus review score
- Undelivered orders
- Freight cost versus delivery time
- Extremely late orders

---

## 7. Power BI Dashboard

The Power BI dashboard was designed to provide an interactive view of the business performance.

### Sales Overview

The Sales Overview page focuses on:

- Total Revenue
- Total Orders
- Average Order Value
- Monthly Revenue Trend
- Revenue by Product Category
- Sales by State
- Top Categories

### Customer Analysis

The Customer Analysis page focuses on:

- Total Customers
- Repeat Customer Rate
- Average Customer Spend
- Average Review Score
- Customers by State
- Top Customers
- Payment Preferences
- Payment behavior

### Delivery Analysis

The Delivery Analysis page focuses on:

- Average Delivery Time
- On-Time Delivery Rate
- Average Delivery Delay
- Average Review Score
- Delivery Delay Trend
- Delivery Time by State
- Slowest States
- Seller Delivery Performance
- Extremely Late Orders

---

## 8. Key Business Questions

The project answers questions such as:

1. How much revenue was generated?
2. Which product categories generate the most revenue?
3. Which states generate the highest revenue?
4. How many unique customers are there?
5. How many customers make repeat purchases?
6. Which customers have the highest total spending?
7. Which payment methods are most commonly used?
8. What is the average delivery time?
9. What percentage of orders are delivered late?
10. Which states have the slowest delivery?
11. Which sellers have poor delivery performance?
12. Does late delivery appear to be associated with lower review scores?

---

## 9. Business Insights

The final insights should be based on the actual results obtained from the SQL queries and Power BI dashboard.

Examples of insights to document include:

- Revenue is concentrated among a smaller number of high-performing product categories.
- Customer activity varies significantly by geographic region.
- A large proportion of customers place only one order, highlighting an opportunity for customer retention strategies.
- Delivery performance varies across states and sellers.
- Late deliveries may be associated with lower customer satisfaction.
- Payment behavior differs across customer locations.

> Replace these statements with the exact numerical findings from the final analysis before publishing the project.

---

## 10. Business Recommendations

Based on the analysis, potential recommendations include:

### Customer Retention

Develop targeted campaigns for first-time customers to encourage repeat purchases.

### Product Strategy

Prioritize high-performing product categories while investigating underperforming categories.

### Delivery Optimization

Investigate states and sellers with consistently high delivery times.

### Customer Experience

Monitor late deliveries because delivery performance can influence customer satisfaction.

### Payment Strategy

Optimize payment options based on customer preferences and geographic behavior.

---

## 11. Project Structure

```text
ecommerce-sales-analytics/
│
├── data/
│   ├── raw/
│   └── processed/
│
├── notebooks/
│   ├── 01_data_understanding.ipynb
│   ├── 02_data_cleaning.ipynb
│   ├── 03_exploratory_data_analysis.ipynb
│   └── 04_business_analysis.ipynb
│
├── sql/
│   ├── 01_basic_analysis.sql
│   ├── 02_sales_analysis.sql
│   ├── 03_customer_analysis.sql
│   └── 04_delivery_analysis.sql
│
├── dashboard/
│   └── ecommerce_sales_dashboard.pbix
│
├── images/
│   ├── dashboard.png
│   ├── revenue_trend.png
│   ├── sales_by_category.png
│   └── sales_by_state.png
│
├── reports/
│   └── project_summary.md
│
├── README.md
├── requirements.txt
└── .gitignore