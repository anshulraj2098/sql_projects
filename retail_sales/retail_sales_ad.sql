SELECT * FROM anshuldb.retail_sales;

#1 Calculate the average sale for each month. Find out best selling month in each year?
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
    
#2 Find the top 5 customers based on the highest total sales?
	SELECT 
	    customer_id,
	    SUM(total_sale) AS total_sales
	FROM retail_sales
	GROUP BY 1
	ORDER BY 2 DESC
	LIMIT 5;
    
#3. Find the number of unique customers who purchased items from each category?
	SELECT category, COUNT(DISTINCT customer_id) as Unique_Customers
	FROM retail_sales
	GROUP BY category;
    
#4. Create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)transactions (transaction_id) made by each gender in each category?
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