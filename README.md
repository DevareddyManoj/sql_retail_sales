# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Database**: `p1_retail_db`

This project showcases my ability to analyze retail sales data using SQL. It involves setting up a retail sales database, cleaning the data, performing exploratory data analysis (EDA), and deriving actionable business insights. Through this project, I aimed to strengthen my SQL skills while addressing real-world retail scenarios.  

## Objectives

1. **Database Setup**: Create and populate a retail sales database.  
2. **Data Cleaning**: Identify and handle missing or inconsistent data.  
3. **Exploratory Data Analysis**: Gain a deeper understanding of the data through structured queries.  
4. **Business Insights**: Use SQL queries to answer key business questions and provide insights into sales trends and customer behavior.

## Project Structure

### 1. Database Setup

- **Database Creation**: Established a database named `p1_retail_db`.  
- **Table Structure**: Created a `retail_sales` table to store sales transaction data. The table contains attributes such as transaction ID, sale date and time, customer demographics, product categories, and sales metrics.

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

- **Initial Exploration**: Checked record count, unique customer IDs, and product categories.  
- **Null Handling**: Identified and removed records with missing values.  

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. Data Analysis

Key SQL queries were designed to address specific business questions:

1. **Sales on Specific Dates**:  
   Retrieve sales data for November 5, 2022.  

   ```sql
   SELECT * FROM retail_sales WHERE sale_date = '2022-11-05';
   ```

2. **Category Insights**:  
   Identify high-volume sales for 'Clothing' in November 2022.  

   ```sql
   SELECT * FROM retail_sales
   WHERE category = 'Clothing' AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11' AND quantity > 4;
   ```

3. **Top Performers**:  
   Find the top 5 customers based on total sales. 

   ```sql
   SELECT customer_id, SUM(total_sale) AS total_sales
   FROM retail_sales
   GROUP BY customer_id
   ORDER BY total_sales DESC
   LIMIT 5;
   ```

4. **Sales Trends**:  
   Calculate the best-selling month each year.  

   ```sql
   SELECT year, month, avg_sale
   FROM (
       SELECT EXTRACT(YEAR FROM sale_date) AS year, EXTRACT(MONTH FROM sale_date) AS month,
              AVG(total_sale) AS avg_sale,
              RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
       FROM retail_sales
       GROUP BY 1, 2
   ) t
   WHERE rank = 1;
   ```

... (Include all queries as per your content).

### 4. Insights

- **Customer Insights**: Identified top-spending customers and analyzed demographic trends.  
- **Sales Trends**: Determined peak months and high-demand product categories.  
- **Operational Analysis**: Assessed sales performance across different shifts (morning, afternoon, evening).  

## Conclusion

This project provided a comprehensive understanding of SQL's role in retail sales analysis, from database setup and data cleaning to delivering actionable business insights. It demonstrates my ability to apply SQL skills to analyze data effectively, identify trends, and support decision-making.

## How to Use

1. **Clone the Repository**: Clone the GitHub repository to your local environment.  
2. **Database Setup**: Run the provided SQL scripts to set up the database and populate data.  
3. **Execute Queries**: Use the SQL queries to explore the dataset and derive insights.  
4. **Customize**: Feel free to adapt the queries to explore additional dimensions of the data.
