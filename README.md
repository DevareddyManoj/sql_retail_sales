
# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Database**: `p1_retail_db`  

This project demonstrates my ability to analyze retail sales data using SQL. It involves creating a database, cleaning data, conducting exploratory data analysis, and answering business questions to extract actionable insights. This project emphasizes practical SQL applications for retail business analysis.

## Objectives

1. **Database Setup**: Create and populate the retail sales database.  
2. **Data Cleaning**: Address missing or inconsistent data.  
3. **Exploratory Data Analysis**: Gain insights through structured queries.  
4. **Business Insights**: Use SQL to answer key business questions and derive insights into sales and customer behavior.

## Project Structure

### 1. Database Setup

- **Database Creation**: Created a database named `p1_retail_db`.  
- **Table Structure**: Designed a `retail_sales` table with attributes for transactions, sales details, customer demographics, and product information.

```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. Data Cleaning and Exploration

Performed initial exploration and data cleaning:  

- **Count Records**:  
   ```sql
   SELECT COUNT(*) FROM retail_sales;
   ```

- **Unique Customers**:  
   ```sql
   SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
   ```

- **Product Categories**:  
   ```sql
   SELECT DISTINCT category FROM retail_sales;
   ```

- **Handle Missing Data**:  
   ```sql
   DELETE FROM retail_sales
   WHERE sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
         gender IS NULL OR age IS NULL OR category IS NULL OR 
         quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
   ```

---

### 3. Data Analysis

Below are the SQL queries addressing specific business questions:

1. **Sales on Specific Date**  
   Retrieve all sales made on `2022-11-05`.  
   ```sql
   SELECT * FROM retail_sales
   WHERE sale_date = '2022-11-05';
   ```

2. **High-Quantity Sales in Clothing Category**  
   Identify transactions where the category is `Clothing` and the quantity sold exceeds 4 in November 2022.  
   ```sql
   SELECT * FROM retail_sales
   WHERE category = 'Clothing'
         AND EXTRACT(YEAR FROM sale_date) = 2022
         AND EXTRACT(MONTH FROM sale_date) = 11
         AND quantity > 4;
   ```

3. **Category-Wise Total Sales**  
   Calculate total sales and order count for each category.  
   ```sql
   SELECT category, SUM(total_sale) AS net_sales, COUNT(*) AS total_orders
   FROM retail_sales
   GROUP BY category;
   ```

4. **Customer Insights for Beauty Products**  
   Find the average age of customers purchasing items from the `Beauty` category.  
   ```sql
   SELECT ROUND(AVG(age), 2) AS avg_age
   FROM retail_sales
   WHERE category = 'Beauty';
   ```

5. **High-Value Transactions**  
   Retrieve transactions with total sales above 1000.  
   ```sql
   SELECT * FROM retail_sales
   WHERE total_sale > 1000;
   ```

6. **Gender and Category Analysis**  
   Total transactions by gender and category.  
   ```sql
   SELECT category, gender, COUNT(*) AS total_transactions
   FROM retail_sales
   GROUP BY category, gender
   ORDER BY category, gender;
   ```

7. **Top-Selling Month per Year**  
   Determine the best month in terms of average sales for each year.  
   ```sql
   SELECT year, month, avg_sale
   FROM (
       SELECT EXTRACT(YEAR FROM sale_date) AS year,
              EXTRACT(MONTH FROM sale_date) AS month,
              AVG(total_sale) AS avg_sale,
              RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
       FROM retail_sales
       GROUP BY year, month
   ) ranked_data
   WHERE rank = 1;
   ```

8. **Top 5 Customers by Total Sales**  
   Identify the top 5 customers based on total sales.  
   ```sql
   SELECT customer_id, SUM(total_sale) AS total_sales
   FROM retail_sales
   GROUP BY customer_id
   ORDER BY total_sales DESC
   LIMIT 5;
   ```

9. **Unique Customer Count per Category**  
   Find the number of unique customers purchasing from each category.  
   ```sql
   SELECT category, COUNT(DISTINCT customer_id) AS unique_customers
   FROM retail_sales
   GROUP BY category;
   ```

10. **Order Shifts Analysis**  
    Analyze the number of orders placed in Morning, Afternoon, and Evening shifts.  
    ```sql
    WITH hourly_sales AS (
        SELECT *,
               CASE
                   WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
                   WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
                   ELSE 'Evening'
               END AS shift
        FROM retail_sales
    )
    SELECT shift, COUNT(*) AS total_orders
    FROM hourly_sales
    GROUP BY shift;
    ```

---

### 4. Insights

- **Sales Trends**: Identified peak sales months, high-value transactions, and top-performing categories.  
- **Customer Behavior**: Analyzed customer demographics, spending habits, and purchasing trends.  
- **Operational Insights**: Highlighted sales performance across shifts, aiding operational planning.  

---

## Conclusion

This project highlights my application of SQL in real-world retail analysis, showcasing my ability to extract actionable insights from data. It helped me build a solid foundation for advanced analytics and business decision-making.

## How to Use

1. **Clone Repository**: Clone this project from GitHub.  
2. **Set Up Database**: Use the `database_setup.sql` script to create and populate the database.  
3. **Run Queries**: Execute the provided SQL scripts for analysis and insights.  
4. **Customize**: Modify queries as needed to explore additional questions.
