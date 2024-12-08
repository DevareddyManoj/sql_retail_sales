--SQL Retail Sales Analysis

DROP TABLE IF EXISTS retail_sales;

CREATE TABLE retail_sales (
	   			transaction_id INT PRIMARY KEY,
			    sale_date DATE,
			    sale_time TIME,
			    customer_id INT,
			    gender VARCHAR(15),
			    age INT,
			    category VARCHAR(15),
			    quantity INT,
			    price_per_unit FLOAT,
			    cogs FLOAT,
			    total_sale FLOAT
);


SELECT * from retail_sales 
WHERE 
	transaction_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantity IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL
	

DELETE from retail_sales 
WHERE 
	transaction_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantity IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL
	
-- Data Exploration

-- How many sales we have?
SELECT COUNT(*) AS Total_Sales FROM retail_sales;-1997
-- How many uniuque customers we have ?
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;--155
SELECT DISTINCT category FROM retail_sales;--3

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

select * from retail_sales where sale_date ='2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

select *
from retail_sales 
where 
category ='Clothing' and
to_char(sale_date, 'yyyy-mm')='2022-11'
and quantity >= 4


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select Category, sum(total_sale) as net_sale, count(*) from retail_sales group by Category

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select Category, round(AVG(age)) from retail_sales where Category='Beauty' group by 1

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select * from retail_sales where total_sale>1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select Category,gender, count(transaction_id) as transaction_count from retail_sales group by 1,2


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
with CTE AS (
select  
	extract(year from sale_date) as year,
	extract(month from sale_date) as month,
	AVG(total_sale),
	dense_rank () over (partition by extract(year from sale_date) order by AVG(total_sale) desc) as rank
from retail_sales  
group by 1,2)

SELECT * FROM CTE WHERE rank=1


--------------
select 	
	year,
	month,
	avg_sale
from
(
select  
	extract(year from sale_date) as year,
	extract(month from sale_date) as month,
	AVG(total_sale) as avg_sale,
	dense_rank () over (partition by extract(year from sale_date) order by AVG(total_sale) desc) as rank
from retail_sales  
group by 1,2
) as t1
where rank=1
SELECT * FROM CTE WHERE rank=1
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 


select
	customer_id, 
	sum(total_sale) as total_sales
	from retail_sales
group by 1
order by 2 desc
limit 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select
	Category,
	count(distinct customer_id)
from retail_sales
group by 1

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
with hourly_sale as
(
select sale_time,
	case 
		when extract(hour from sale_time) < 12 then 'Morning'
		when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
		else 'Evening'
	end as shift
from retail_sales
)
select 
	shift,
	count(*) 
from hourly_sale
group by shift