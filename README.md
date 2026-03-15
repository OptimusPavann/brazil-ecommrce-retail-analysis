# 🛒 Brazilian E-Commerce SQL Data Exploration

## 📌 Project Overview

This project focuses on **exploring and understanding the Brazilian E-Commerce dataset using SQL Server**.
The goal is to perform **data exploration, data quality checks, and schema inspection** before moving into deeper business analysis.

This project demonstrates a **structured SQL data analysis workflow**, similar to what data analysts perform when working with a new dataset.

---

# 📂 Dataset

The dataset used in this project is the **Brazilian E-Commerce Public Dataset**.

It contains information about:

* Customers
* Orders
* Products
* Sellers
* Payments
* Reviews
* Geolocation

The dataset includes **multiple related tables**, allowing analysis of the entire e-commerce lifecycle.

---

# 🧰 Tools Used

* **SQL Server**
* **SSMS (SQL Server Management Studio)**
* **Git**
* **GitHub**

---

# 📊 Database Tables

The dataset contains the following tables:

| Table Name       | Description                     |
| ---------------- | ------------------------------- |
| customers        | Customer information            |
| orders           | Order details                   |
| order_items      | Products included in each order |
| order_payments   | Payment information             |
| order_reviews    | Customer reviews                |
| products         | Product details                 |
| product_category | Product category mapping        |
| sellers          | Seller information              |
| geolocation      | Customer location data          |

---

# 🔎 Data Exploration Workflow

The project follows a structured **data exploration process**.

## 1️⃣ Load Dataset into Database

CSV files were imported into SQL Server tables.

---

## 2️⃣ Verify Tables in Database

Check that all tables were successfully loaded.

```sql
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES;
```

---

## 3️⃣ Validate Row Counts

Verify that the expected number of records exists.

```sql
SELECT COUNT(*) AS total_orders
FROM orders;
```

---

## 4️⃣ Inspect Table Structure

Understand schema and column definitions.

```sql
EXEC sp_help 'orders';
```

---

## 5️⃣ Inspect Column Metadata

```sql
SELECT 
TABLE_NAME,
COLUMN_NAME,
DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS;
```

This helps identify:

* column types
* nullable fields
* schema structure

---

## 6️⃣ Preview Dataset Samples

```sql
SELECT TOP 100 *
FROM orders;
```

Used to understand:

* data format
* column meaning
* sample records

---

## 7️⃣ Check Duplicate Records

```sql
SELECT order_id, COUNT(*)
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;
```

Purpose:

* detect duplicate entries
* ensure data integrity

---

## 8️⃣ Check NULL Values

```sql
SELECT
COUNT(*) - COUNT(customer_city) AS null_customer_city
FROM customers;
```

Used to identify missing data.

---

# 📈 Insights from Exploration

Through the exploration process we understand:

* dataset size
* table relationships
* column structures
* missing values
* potential data quality issues

These steps are essential before performing **business analytics queries**.

---

# 🚀 Next Steps

Upcoming analysis will focus on:

* sales trend analysis
* top selling products
* seller performance
* customer distribution
* delivery performance

---

# 📁 Project Structure

```
brazilian-ecommerce-sql-analysis
│
├── datasets
│
├── sql
│   ├── table_verification.sql
│   ├── row_counts.sql
│   ├── schema_inspection.sql
│   ├── data_preview.sql
│   ├── duplicate_check.sql
│   └── null_value_check.sql
│
└── README.md
```

---

# 📌 Author

**Optimus**

SQL Data Analysis Project
