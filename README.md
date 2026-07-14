# 📊 E-Commerce Sales Analytics Dashboard

An end-to-end Data Analytics project built using **Python, SQL Server, and Power BI** to analyze the Brazilian Olist E-commerce dataset. The project focuses on transforming raw transactional data into actionable business insights through data cleaning, SQL analysis, and interactive dashboards.

---

## 📌 Business Problem

Olist, a Brazilian e-commerce marketplace, wants to understand its sales performance, customer behavior, and delivery efficiency to improve business decisions. This project analyzes historical transaction data to identify trends, evaluate operational performance, and provide data-driven recommendations.

---

## 🎯 Project Objectives

- Analyze sales and revenue performance.
- Identify top-performing product categories and states.
- Understand customer purchasing behavior.
- Evaluate delivery performance and late deliveries.
- Analyze customer review ratings.
- Build interactive dashboards for business decision-making.

---

## 🛠️ Tech Stack

- **Python** (Pandas, NumPy)
- **SQL Server**
- **Power BI**
- **Jupyter Notebook**
- **Git & GitHub**

---

## 📂 Dataset

- **Dataset:** Brazilian E-Commerce Public Dataset by Olist
- **Source:** https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

The dataset contains approximately **100,000 orders** and consists of multiple related tables including customers, orders, products, payments, sellers, and reviews.

---

## 🔄 Project Workflow

```
CSV Files
    ↓
Python
(Data Cleaning & Feature Engineering)
    ↓
SQL Server
(Data Storage & Business Analysis)
    ↓
Power BI
(Dashboard Development)
    ↓
Business Insights & Recommendations
```

---

## 🧹 Data Cleaning & Feature Engineering

- Standardized column names
- Removed duplicate records
- Handled missing values
- Fixed data types
- Removed unnecessary columns
- Mapped product categories to English
- Created new features:
  - Purchase Year
  - Purchase Month
  - Delivery Days
  - Delivered On Time

---

## 📈 SQL Business Analysis

The following business questions were answered using SQL:

- Total Revenue
- Top 5 States by Revenue
- Top 5 States by Customers
- Top Product Categories by Revenue
- Product Categories by Average Review
- Yearly Revenue Trend
- Monthly Revenue Trend
- Average Delivery Days
- Late Delivery Percentage
- Month-over-Month Revenue Growth
- Top 20% Customers by Revenue
- Revenue Contribution by Category
- Categories Above Average Revenue
- Product Categories with Highest Late Deliveries
- Most Used Payment Method

---

## 📊 Power BI Dashboard

The dashboard consists of three pages:

### 📌 Sales Performance
- Revenue KPIs
- Sales Trend
- Revenue by State
- Revenue by Product Category

### 👥 Customer Behaviour
- Customer Distribution
- Repeat Customers
- Payment Analysis
- Review Analysis

### 🚚 Delivery Efficiency
- Average Delivery Days
- Late Delivery Percentage
- Delivery Performance by State
- Late Delivery Analysis

---

## 💡 Key Insights

- Sales are concentrated in a few major states.
- Credit Card is the most frequently used payment method.
- A small percentage of customers are repeat buyers.
- Approximately 7.6% of delivered orders were delayed.
- Certain product categories experience higher late delivery rates.
- Customer satisfaction remains high with an average review score above 4.

---

## 📁 Repository Structure

```
├── Python/
│   └── Data_Cleaning.ipynb
├── SQL/
│   └── SQL_Analysis.sql
├── Power BI/
│   └── Dashboard.pbix
├── Report/
│   └── Project_Report.pdf
├── Dashboard Images/
├── README.md
```

---

## 🚀 Future Improvements

- Develop sales forecasting models.
- Build customer segmentation using machine learning.
- Publish the dashboard to Power BI Service.
- Integrate the dashboard with a live SQL database.

---

## 👨‍💻 Author

**Dhruv Bansal**

- LinkedIn: *(Add your LinkedIn URL)*
- GitHub: *(Add your GitHub Profile URL)*
