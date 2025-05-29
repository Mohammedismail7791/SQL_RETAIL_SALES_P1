-- SQL Retail Sales Analysis --P1
CREATE DATABASE sql_project_p1;

USE sql_project_p1;

-- creating table-- 
CREATE TABLE retail_sales
(
		transactions_id	INT PRIMARY KEY,
		sale_date DATE,
		sale_time TIME,
		customer_id	INT,
		gender	VARCHAR(15),
		age	INT,
		category VARCHAR(20),	
		quantiy	INT,
		price_per_unit FLOAT,	
		cogs	FLOAT,
		total_sale FLOAT
);

SELECT * FROM retail_sales;

SELECT * FROM retail_sales
WHERE  total_sale IS NULL;

SELECT 
COUNT(*) 
FROM retail_sales;

-- DATA EXPLORATION
-- HOW MANY SALES DO WE HAVE?
SELECT COUNT(*) as total_sales FROM retail_sales;

-- HOW MANY unique CUSTOMERS DO WE HAVE?
SELECT COUNT(DISTINCT customer_id) as total_sales FROM retail_sales;

-- HOW MANY unique CATEGORY DO WE HAVE?
SELECT DISTINCT category FROM retail_sales;

-- Write a SQL query to retrieve all columns for sales made on '2022-11-05:
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
SELECT *
FROM retail_sales
WHERE category = 'Clothing' AND quantiy >= 4 AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';

-- Write a SQL query to calculate the total sales (total_sale) for each category.:

SELECT SUM(total_sale), category
FROM retail_sales
GROUP BY category;

-- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
SELECT ROUND (AVG(age), 2) as AGE
FROM retail_sales
WHERE category = 'Beauty';

-- Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT *
FROM retail_sales
WHERE total_sale > 1000;

-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
SELECT category, gender, COUNT(*) AS TOTAL_TRANS
FROM retail_sales
GROUP BY category, gender 
ORDER BY 1;

-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT 
YEAR(sale_date) AS Year, MONTH(sale_date) as Month , ROUND(AVG(total_sale),2) AS AVG_SALE, 
RANK() OVER(PARTITION BY (YEAR (sale_date)) ORDER BY AVG(total_sale) DESC)
FROM retail_sales
GROUP BY Year , Month;
-- ORDER BY 1, 3 DESC;

-- **Write a SQL query to find the top 5 customers based on the highest total sales **:
SELECT customer_id, SUM(total_sale) AS Sales
FROM retail_sales
group by customer_id 
ORDER BY 2 DESC
LIMIT 5;

-- Write a SQL query to find the number of unique customers who purchased items from each category.:
SELECT category, COUNT(DISTINCT customer_id) As CUST
FROM retail_sales
GROUP BY CATEGORY;

-- Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
WITH hourly_sale
as
(
	SELECT *,
		CASE
			WHEN HOUR(sale_time) < 12 THEN 'MORNING'
			WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
			ELSE 'Evening'
		END as Shift
	FROM retail_sales
)
SELECT 
 Shift,
 Count(*) as Orders
 FROM hourly_sale
 GROUP BY Shift;

-- END OF PROJECT--
