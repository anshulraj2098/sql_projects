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

# Basic Question:
  1. How many unique customer's we have?
      ```sql
      SELECT COUNT(DISTINCT category)
      as total_category
      FROM retail_sales;
      ```
       
  2. How many unique categories? Also, what are they?
      ``` sql
      SELECT DISTINCT category
      as total_category
      FROM retail_sales;
      ``` 
# Stake Holders Question:
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
  4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category
  6. Find the average age of customers who purchased items from the 'Beauty' category?
  7. Find all transactions where the total_sale is greater than 1000?
  8. Find the total number of transactions (transaction_id) made by each gender in each category?
  9. Calculate the average sale for each month. Find out best selling month in each year?
  10. Find the top 5 customers based on the highest total sales?
  11. Find the number of unique customers who purchased items from each category?
  12.   Create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
