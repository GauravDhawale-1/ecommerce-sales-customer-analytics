# E-Commerce Sales & Customer Analytics Dashboard

## 📌 Project Overview

This project is an end-to-end E-Commerce Sales and Customer Analytics solution built using MySQL, SQL, Power BI and DAX.

The objective of this project is to analyze sales performance, customer behavior, product performance and payment trends and convert the analysis into an interactive Power BI dashboard.

---

## 🛠️ Tools & Technologies

- MySQL
- SQL
- Power BI
- DAX
- Data Modeling
- Data Visualization

---

## 🗂️ Database Structure

The project contains four main tables:

- Customers
- Products
- Orders
- Payments

### Relationships

Customers → Orders  
Products → Orders  
Orders → Payments

---

## 🔍 SQL Analysis

SQL was used to answer business questions such as:

- What is the total revenue?
- What are the top products by revenue?
- Which category generates the highest revenue?
- Who are the most valuable customers?
- What is the average order value?
- Which cities generate the most revenue?
- Which payment method is used most frequently?
- Who are the top customers by spending?
- What are the monthly revenue trends?
- Which products sell the highest quantity?
- What percentage of customers are repeat customers?
- What is the payment status distribution?

For sales and revenue analysis, only orders with `payment_status = 'Paid'` were included.

---

## 📊 Power BI Dashboard

The Power BI dashboard contains three analytical pages.

### 1. E-Commerce Sales Performance

Key metrics and visuals:

- Total Revenue
- Total Orders
- Total Customers
- Average Order Value
- Monthly Revenue Trend
- Revenue by Category
- Top 5 Products by Revenue
- Order Date Slicer

### 2. Customer & Sales Analysis

Includes:

- Top 5 Customers by Spending
- Revenue by City
- Customer Order Frequency
- Repeat Customer %
- Top 5 Customers by Order Frequency

### 3. Product & Payment Analysis

Includes:

- Top 5 Products by Revenue
- Top 5 Products by Quantity Sold
- Revenue by Payment Method
- Payment Status Analysis
- Revenue by Product Category
- Quantity Sold by Category


