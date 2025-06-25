# Walmart Sales Data Analysis Project

This project analyzes a Walmart sales dataset using SQL to derive insights into customer behavior, sales performance, and business trends. It demonstrates practical data analytics and business intelligence skills, focusing on various KPIs such as payment methods, branch performance, ratings, and revenue trends.

## Dataset Overview

- **Source:** `Walmart.csv`
- **Size:** ~10,000 records
- **Attributes include:**
  - Invoice ID
  - Branch
  - City
  - Customer Type
  - Gender
  - Product Category
  - Unit Price
  - Quantity
  - Tax and Total
  - Date and Time
  - Payment Method
  - Rating

## Tools & Technologies

- **Database:** MySQL
- **Language:** SQL
- **Platform:** Local SQL Server (or any SQL-compatible interface)

## Key Business Questions Answered

### 1. **Popular Payment Methods**
- What are the different payment methods?
- How many transactions and quantities are associated with each?

### 2. **Top-Rated Product Categories per Branch**
- Identify the highest-rated category in each branch using average customer ratings.

### 3. **Busiest Day per Branch**
- Determine which weekday had the highest number of transactions per branch.

### 4. **Branch Diversity**
- Count how many unique branches exist.

### 5. **Category Ratings per City**
- What are the average, minimum, and maximum ratings of each product category across different cities?

### 6. **Most Profitable Categories**
- Total profit per category calculated using:  
  `Total Profit = Total * profit_margin`  
  (assuming a given profit margin variable in your calculations).

### 7. **Preferred Payment Method per Branch**
- Which payment method is most common in each branch?

### 8. **Sales by Time of Day**
- Categorize sales into:
  - Morning (before 12 PM)
  - Afternoon (12–5 PM)
  - Evening (after 5 PM)
- Then count number of invoices in each category.

### 9. **Revenue Decrease Year-over-Year**
- Identify top 5 branches with the highest revenue decrease ratio from 2022 to 2023:
  - `Revenue Decrease Ratio = ((Last Year Rev - Current Year Rev) / Last Year Rev) * 100`

## Sample Queries

```sql
-- Total quantity sold by payment method
SELECT payment_method, COUNT(*) AS no_of_transactions, SUM(quantity) AS no_quant_sold
FROM walmart
GROUP BY payment_method;

