# Overview:
The project is based on a retail business dataset. 
This is to demonstrate how the stakeholders queries were resolved with SQL. 

# Queries used in the Project:
  1) BASIC SQL
  2) AND Condition
  3) GROUP & ORDER BY
  4) EXTRACT (YEAR & MONTH)
  5) CASE, WHEN & END statement
  6) CTE(Common Table Expression)
  7) WINDOW functions

# Project Objective:
It is a retail busineses data set. The general idea of this project is to identify key problems and finding the answers to it.

# Project based Questions:
  1. The total sales made on '2022-11-05'?
     ```sql
      SELECT *
      FROM retail_sales
      WHERE sale_date = '2022-11-05' ;
     ```
  2. Retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022?  
     ```sql
      SELECT *	
      FROM retail_sales
      WHERE category = 'Clothing'
      	AND 
      	TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
      	AND 
      	quantiy >=4
     ```
  3. Calculate the total sales **(total_sale)** for each category?
     ```sql
      SELECT category,
	           SUM(total_sale) as net_sale,
	           COUNT(*) as total_order
      FROM retail_sales
      GROUP BY 1
     ```
  4. Find the average age of customers who purchased items from the **'Beauty'** category?
     ```sql
      SELECT ROUND(AVG(age),0) as average_age
      FROM retail_sales
      WHERE category = 'Beauty';
     ```
  5. Find all transactions where the total_sale is greater than 1000?
	    ```sql
	      SELECT *
	      FROM retail_sales
	      WHERE total_sale > 1000;
	     ```
  6. find the total number of transactions (transaction_id) made by each gender in each category?
```sql
		SELECT category, gender, COUNT(*) as total_trans
			  FROM retail_sales
			  GROUP BY category, gender
			  ORDER BY 1
```
  7.  calculate the average sale for each month. Find out best selling month in each year:
```sql
			SELECT year, month, avg_sale
				FROM 
					(
					SELECT 
					EXTRACT(YEAR FROM sale_date) as year,
					EXTRACT(MONTH FROM sale_date) as month,
					AVG(total_sale) as avg_sale,
					RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date)ORDER BY AVG(total_sale) DESC) as rank
					FROM retail_sales
					GROUP BY 1, 2
					) as T1
				WHERE rank = 1
```
  8. Find the top 5 customers based on the highest total sales?
``` sql
			SELECT 
				customer_id,
				SUM(total_sale) as total_sales
			FROM retail_sales
			GROUP BY 1
			ORDER BY 2 DESC
			LIMIT 5
```
9. Find the number of unique customers who purchased items from each category
	```sql
		SELECT
			category,
			COUNT(DISTINCT customer_id) as count_unique_customer
		FROM retail_sales
		GROUP BY category
	```

10. Create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
	```sql
		WITH hourly_sale
		AS(
		SELECT *,
			CASE
			WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
			WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
			ELSE 'Evening'
		END AS shift
		FROM retail_sales
			)
			SELECT
				shift,
				COUNT(*) as total_orders
			FROM hourly_sale
			GROUP BY shift
	```
# Project based Questions - Advanced:

1. Find the total number of tran11.
	```sql
	SELECT COUNT(*) AS total_transactions 
	FROM SQLRetailSalesAnalysis_utf
	``` 
2. Calculate the average sale for each month. Find out best selling month in each year?
	```sql
	# -> Part 1: Finding out the average sale per month.
	
	SELECT 
		EXTRACT(MONTH FROM sale_date) as month,
	   AVG(total_sale) AS avg_sale
	FROM retail_sales
	GROUP BY 1
	ORDER BY 1;
	
	# -> Part 2: Next Step is, finding out the best selling month
	SELECT YEAR, MONTH, total_sales
			FROM (
				SELECT 
				EXTRACT(YEAR FROM sale_date) as year,
				EXTRACT(MONTH FROM sale_date) as month,
				SUM(total_sale) as total_sales,
				RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY SUM(total_sale) DESC) AS Best_selling_month
				FROM retail_sales
				GROUP BY 1, 2
				) AS t1
	WHERE Best_selling_month = 1;
	```
3. Find the top 5 customers based on the highest total sales?
```sql
	SELECT 
	    customer_id,
	    SUM(total_sale) AS total_sales
	FROM retail_sales
	GROUP BY 1
	ORDER BY 2 DESC
	LIMIT 5;
```
4. Find the number of unique customers who purchased items from each category?
	```sql
	SELECT category, COUNT(DISTINCT customer_id) as Unique_Customers
	FROM retail_sales
	GROUP BY category;
 	```
5. Create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)transactions (transaction_id) made by each gender in each category?
	```sql
	WITH hourly_sales AS (
	    SELECT *,
	        CASE
	            WHEN HOUR(sale_time) < 12 THEN 'Morning'
	            WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
	            ELSE 'Evening'
	        END as shift
	    FROM retail_sales
	)
	SELECT 
	    category,
	    gender,
	    shift,
	    COUNT(*) as total_orders
	FROM hourly_sales
	GROUP BY category, gender, shift
	ORDER BY category, total_orders DESC;
	```

