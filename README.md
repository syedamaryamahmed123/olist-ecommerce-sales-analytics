# Olist E-commerce Sales Analytics

An end-to-end e-commerce data analytics project analyzing sales, customers, payments, product categories, and delivery performance using **Python, SQL, and Power BI**.

## Project Overview

This project analyzes the Brazilian Olist e-commerce dataset to identify business trends and customer insights across sales, products, customers, payments, and delivery operations.

The project follows a real-world analytics workflow:

**Data Cleaning → Exploratory Data Analysis → Feature Engineering → SQL Analysis → Power BI Dashboard → Business Insights**

## Tools & Technologies

* **Python**

  * Pandas
  * NumPy
  * Matplotlib
  * Seaborn
  * Jupyter Notebook

* **SQL**

  * MySQL
  * Aggregations
  * Joins
  * CTEs
  * Date analysis
  * Customer and sales analysis

* **Power BI**

  * Data modeling
  * DAX
  * Interactive dashboards
  * Time-series analysis
  * KPI cards
  * Customer and delivery analysis

## Dataset

The project uses the public Olist Brazilian E-commerce dataset.

The dataset contains information about:

* Customers
* Orders
* Order items
* Payments
* Reviews
* Products
* Sellers
* Geolocation
* Product categories

## Project Workflow

### 1. Data Cleaning

The raw datasets were inspected and cleaned using Python.

Tasks included:

* Checking missing values
* Checking duplicate records
* Reviewing data types
* Handling date columns
* Investigating order statuses
* Creating analysis-ready datasets

### 2. Exploratory Data Analysis

Python was used to analyze:

* Sales trends
* Product categories
* Customer behavior
* Payment methods
* Geographic distribution
* Order delivery performance
* Review scores

### 3. Feature Engineering

Additional analytical features were created, including:

* `is_delivered`
* `is_canceled`
* `delivery_pending`
* `delivery_days`
* `delivery_delay_days`
* `approval_time_hours`
* `shipping_time_days`
* `delivery_vs_estimate`

### 4. SQL Analysis

SQL analysis was organized into four sections:

```text
01_basic_analysis.sql
02_sales_analysis.sql
03_customer_analysis.sql
04_delivery_analysis.sql
```

The analysis covers:

* Overall sales performance
* Order trends
* Customer spending
* Product/category performance
* Payment methods
* Delivery performance
* Delivery delays
* Customer behavior

### 5. Power BI Dashboard

The Power BI report contains three main pages:

#### Sales Overview

* Total Revenue
* Total Orders
* Total Customers
* Average Spend per Customer
* Revenue trends
* Sales by category
* Sales by state

#### Customer Analysis

* Customer order frequency
* Customer spending
* Payment method analysis
* Customer distribution by state
* Customer-level performance

#### Delivery Analysis

* Delivery performance
* Average delivery time
* Delivery delays
* Estimated vs actual delivery
* Order status analysis

## Dashboard Preview

![Power BI Dashboard](images/dashboard.png)

## Key Business Insights

The analysis was used to identify:

* Revenue and order trends over time
* High-performing product categories
* Geographic sales patterns
* Customer spending behavior
* Popular payment methods
* Delivery performance and delays
* Differences between estimated and actual delivery times

## Repository Structure

```text
olist-ecommerce-sales-analytics/
│
├── data/
│   ├── raw/
│   └── processed/
│
├── notebooks/
│   ├── data_cleaning.ipynb
│   ├── eda.ipynb
│   └── feature_engineering.ipynb
│
├── sql/
│   ├── 01_basic_analysis.sql
│   ├── 02_sales_analysis.sql
│   ├── 03_customer_analysis.sql
│   └── 04_delivery_analysis.sql
│
├── powerbi/
│   └── Olist_Ecommerce_Analytics.pbix
│
├── reports/
│   └── project_summary.md
│
├── images/
│   ├── dashboard.png
│   ├── revenue_trend.png
│   ├── sales_by_category.png
│   └── sales_by_state.png
│
├── README.md
├── requirements.txt
└── .gitignore
```

## Skills Demonstrated

**Data Analysis:** Python, Pandas, NumPy, EDA

**SQL:** MySQL, joins, aggregations, CTEs, date analysis

**Data Visualization:** Matplotlib, Seaborn, Power BI

**Business Analytics:** Sales analysis, customer analysis, delivery analysis, KPI reporting

**Data Preparation:** Data cleaning, missing-value analysis, feature engineering

## Author

**[Syeda Maryam Ahmed]**

Aspiring Data Analyst | SQL | Python | Power BI

GitHub: [https://github.com/syedamaryamahmed123]

LinkedIn: [https://www.linkedin.com/in/syeda-maryam-ahmed/]
