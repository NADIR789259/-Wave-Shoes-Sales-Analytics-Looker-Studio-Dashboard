CREATE TABLE wave_shoes (
    order_number VARCHAR(20),
    order_date DATE,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    order_type VARCHAR(20),
    product VARCHAR(100),
    category VARCHAR(50),
    cost_per_unit NUMERIC,
    selling_price_unit NUMERIC,
    quantity INT,
    cost NUMERIC,
    sales_amount NUMERIC
);

select*from wave_shoes;


-- 🟢 LEVEL 1 (Basic)

-- 1.	Find the total number of orders. 
         SELECT COUNT(*) AS total_orders
		 FROM wave_shoes;
-- 2.	Calculate the total sales amount.
        SELECT SUM(sales_amount) AS total_sales_billing
		FROM wave_shoes;
        
-- 3.	Find the total quantity sold.
        SELECT SUM(quantity) AS total_quantity
		select*FROM wave_shoes;
-- 4.	Count the number of unique customers.
        SELECT COUNT(distinct customer_name) AS unique_coustomers
		FROM wave_shoes;
-- 5.	List all unique products.
        SELECT DISTINCT product AS unique_product
		from wave_shoes;
-- 6.	Find the highest order value.
		
		-- SELECT sales_amount As highest_order_value
		-- FROM wave_shoes
		-- ORDER BY highest_order_value desc 
		-- LIMIT 1;

		SELECT MAX(sales_amount) AS highest_order
		FROM wave_shoes;

-- 7.	Find the lowest order value.
        SELECT MIN(sales_amount) AS lowest_order
		FROM wave_shoes;
________________________________________
-- 🟡 LEVEL 2 (Intermediate)

-- 8.	Find the total quantity sold for each product. 
    	select product,SUM(quantity) AS sold_products
		FROM wave_shoes
		GROUP BY product;

-- 9.	Calculate total spending by each customer.
		SELECT customer_name,SUM(sales_amount) AS total_spending
		FROM wave_shoes
		GROUP BY customer_name;

-- 10.	Find total sales for each city. 
		SELECT city,SUM(sales_amount)AS sales_each_city
		from wave_shoes
		group by city;

-- 11.	Calculate total sales for each category.
		select category,SUM(sales_amount)AS sales_each_category
		FROM wave_shoes
		group by category;

-- 12.	Find the top 5 best-selling products based on quantity.
		select product,sum(quantity)as best_selling
		from wave_shoes
		group  by product
		order by best_selling desc 
		limit 5;

-- 13.	Find the top 5 customers based on total spending. 
		select customer_name, SUM(sales_amount) AS best_selling
		from wave_shoes
		group by customer_name
		order by best_selling desc 
		limit 5;

-- 14.	Identify the least selling product.

		select customer_name,SUM(sales_amount) As least_Selling 
		from wave_shoes
		group by customer_name
		order by least_selling ASC
		LIMIT 1;

________________________________________
-- 🟠 LEVEL 3 (Advanced)

-- 15.	Calculate profit for each order. 
		SELECT order_number,product,(sales_amount - cost) As profit_Amount
		FROM wave_shoes;

		
-- 16.	Find all loss-making orders. 
		SELECT order_number,product,(sales_amount - cost) As loss_making_orders
		FROM wave_shoes
		WHERE (sales_amount - cost) <0; 



-- 17.	Find the top 5 most profitable products.
		SELECT product,SUM(sales_amount-cost) AS highest_profitable
		FROM wave_shoes
		GROUP BY product
		ORDER BY highest_profitable DESC 
		LIMIT 5;
		

-- 18.	Calculate the average order value.
		SELECT round(avg(sales_amount),2) AS avg_order_value
		FROM wave_shoes;
	

-- 19.	Find the average spending per customer. 
		SELECT customer_name,round(avg(sales_amount),2)AS avg_spending_customer
		FROM wave_shoes
		group by customer_name;

-- 20.	Identify the most profitable city. 
		SELECT city,SUM(sales_amount-cost)As profitable_city
		FROM wave_shoes
		GROUP BY city
		ORDER BY profitable_city desc 
		limit 1 ;

________________________________________
-- 🔴 LEVEL 4 (Real Business Level)

-- 21.	Analyze monthly sales trends.
		SELECT EXTRACT(MONTH FROM order_date) AS months,
		SUM(sales_amount)AS total_sales
		FROM wave_shoes
		GROUP BY EXTRACT(MONTH FROM order_date)
		ORDER BY months;


-- 22.	Calculate monthly profit. 
		SELECT EXTRACT(MONTH FROM order_date) AS month,
		SUM(sales_amount-cost)AS month_profite
		FROM wave_shoes
		GROUP BY  EXTRACT(MONTH FROM order_date)
		ORDER BY month;

-- 23.	Identify repeat customers (customers with more than one order).
		SELECT customer_name,COUNT(*)AS repated_customer
		FROM wave_shoes
		GROUP BY customer_name
		HAVING COUNT(*)>1;
		

-- 24.	Calculate average profit per product.
		SELECT product,ROUND(avg(sales_amount-cost),2) As avg_product
		FROM wave_shoes
		GROUP BY product;

-- 25.	Find the top 3 cities by revenue. 
		SELECT city,SUM(sales_amount) AS highest_city
		FROM wave_shoes
		GROUP BY city
		ORDER BY highest_city desc 
		LIMIT 3;

-- 26.	Identify the order with the highest profit. 
		SELECT order_number,city,SUM(sales_amount-cost) AS highest_profit
		FROM wave_shoes
		GROUP BY order_number,city
		ORDER BY highest_profit desc
		LIMIT 1;

-- 27.	Segment customers into High, Medium, and Low spenders based on total spending.
		SELECT customer_name,SUM(sales_amount)AS total_spent,
		CASE 
		    WHEN SUM(sales_amount)>50000 THEN 'High'
		    WHEN SUM(sales_amount) BETWEEN 20000 AND 60000 THEN 'Medium'
			ELSE 'Low'
			END AS Customer_Segmentation
			from wave_shoes
			group by customer_name;
________________________________________
-- 🟣 LEVEL 5 (Interview Level 🔥)

-- 28.	Identify products with high sales but low profit.
		SELECT product,SUM(sales_amount) AS total_sales,
    	SUM(sales_amount - Cost) AS total_profit
		FROM wave_shoes
		GROUP BY Product;

-- 29.	Find customers who purchase consistently every month.
		SELECT customer_name
		FROM wave_shoes
		GROUP BY customer_name
		HAVING COUNT(DISTINCT EXTRACT(MONTH FROM order_date)) = 
(
    	SELECT COUNT(DISTINCT EXTRACT(MONTH FROM order_date)) 
    	FROM wave_shoes
);

-- 30.	Compare total sales and total profit for each product.
		SELECT product,SUM(sales_amount) AS total_sales,
    	SUM(sales_amount- Cost) AS total_profit
		FROM wave_shoes
		GROUP BY Product;

-- 31.	Identify categories that are generating losses. 
		SELECT category,SUM(sales_amount - cost) AS total_profit
		FROM wave_shoes
		GROUP BY category HAVING SUM(sales_amount - Cost) < 0;

-- 32.	Find the top 10% of customers based on revenue. 
		SELECT *FROM (SELECT customer_name, SUM(sales_amount) AS total_spent,
    	NTILE(10) OVER (ORDER BY SUM(sales_amount) DESC) AS percentile_rank
    	FROM wave_shoes
    	GROUP BY customer_name
) t
WHERE percentile_rank = 1;
