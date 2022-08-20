USE maven;


-- checking for null values
SELECT *
FROM sales, products, inventory, stores
WHERE null = null;


-- ANALYSIS on the STORES table
SELECT * 
FROM stores;


-- Count the number of stores in a city
SELECT count(Store_ID) , Store_City  
FROM stores
GROUP BY Store_city
ORDER BY count(Store_ID) DESC;


-- Number of cities 
SELECT Count(DISTINCT Store_City)
FROM stores;


-- Number of Location 
SELECT Count(DISTINCT Store_Location) 
FROM stores;


-- ANALYSIS on the Products Table
SELECT *
FROM products;


SELECT COUNT(DISTINCT Product_Name)
FROM Products;


-- Removing the dollar sign to enable easy calc
UPDATE products
SET product_cost = REPLACE(product_cost, '$', ''); 


 -- Removing the dollar sign to enable easy calc
UPDATE products
SET product_price = REPLACE(product_price, '$', '');


-- modifyig the product_cost column from text to int
ALTER TABLE products
MODIFY COLUMN product_cost INT; 


 -- modifyig the product_price column from text to int
ALTER TABLE products
MODIFY COLUMN product_price INT;

DESC products;


-- Adding a new column for the profits of each product
ALTER TABLE products 
ADD Profit INT;

UPDATE products
SET Profit = (product_price - product_cost);


 SELECT 
	*,
    (product_price - product_cost) AS profit,
    DENSE_RANK() over (ORDER BY profit DESC) as proft_order
FROM products;    
 
SELECT 
	product_category,
    AVG(product_price - product_cost) AS Avg_profit,
    MIN(product_price - product_cost) AS Min_profit,
    MAX(product_price - product_cost) AS Max_profit
 FROM products
 GROUP BY product_category;   
 
 
 -- ANALYSIS on Invenory table
 SELECT *
 FROM inventory;
 
 -- Joining inventory, products and stores
SELECT *
FROM inventory i 
JOIN stores s 
	USING (store_id)
JOIN products p 
	USING (product_id);


-- Returning the product with the maximum profit
SELECT * 
FROM products
where profit =
(SELECT	MAX(profit)
FROM products
ORDER BY profit DESC);


-- returning the product with the 10th highest profit
SELECT * 
FROM products
where profit <
(SELECT	MAX(profit)
FROM products
ORDER BY profit DESC)
LIMIT 9,1;
    
   
(SELECT 
	*,
    MAX(profit)
FROM inventory i 
JOIN stores s 
	USING (store_id)
JOIN products p 
	USING (product_id));     
        
SELECT 
	store_name,
    count(product_name) AS Total_products
FROM inventory i 
JOIN stores s 
	USING (store_id)
JOIN products p 
	USING (product_id)
GROUP BY store_name
ORDER BY Total_products;

SELECT 
	store_name, 
    stock_on_hand,
    product_cost, 
    (stock_on_hand * product_cost) AS Invent_Value
FROM inventory i 
JOIN stores s 
	USING (store_id)
JOIN products p 
	USING (product_id);
    
SELECT SUM(stock_on_hand * product_cost) AS Total_Value
FROM inventory i 
JOIN stores s 
	USING (store_id)
JOIN products p 
	USING (product_id);


-- Total Inventory of each store
SELECT 
	store_name,
    SUM(stock_on_hand * product_cost) AS Total_Value
FROM inventory i 
JOIN stores s 
	USING (store_id)
JOIN products p 
	USING (product_id)
GROUP BY store_name    
ORDER BY Total_value DESC;


--  Total stock of each products
SELECT 
	product_name,
    SUM(stock_on_hand) AS Total_Value
FROM inventory i 
JOIN stores s 
	USING (store_id)
JOIN products p 
	USING (product_id)
GROUP BY product_name    
ORDER BY Total_value DESC;


-- ANALYSIS on sales table
SELECT * 
FROM sales;

SELECT *
FROM sales s
JOIN stores st  
	USING (store_id)
JOIN products p 
	USING (product_id);


-- Total cost/sales/profit from 2017-2018    
SELECT 
	SUM(units * product_cost) AS Total_Cost,
    SUM(units * product_price) AS Total_sales,
    SUM(units * profit) AS Total_Profit
FROM sales s
JOIN stores st  
	USING (store_id)
JOIN products p 
	USING (product_id);
        
-- Total cost/sales/profit by date  
SELECT 
	Date,
	SUM(units * product_cost) AS Total_Cost,
    SUM(units * product_price) AS Total_sales,
    SUM(units * profit) AS Total_Profit
FROM sales s
JOIN stores st  
	USING (store_id)
JOIN products p 
	USING (product_id)
GROUP BY date
#ORDER BY profit DESC
LIMIT 5;
    

-- Returning store with the highest profit/cost/sales
SELECT 
	Store_name,
	SUM(units * product_cost) AS Total_Cost,
    SUM(units * product_price) AS Total_sales,
    SUM(units * profit) AS Total_Profit
FROM sales s
JOIN stores st  
	USING (store_id)
JOIN products p 
	USING (product_id)
GROUP BY Store_name
ORDER BY Total_profit DESC;

          
-- Returning Location with the highest profit/cost/sales          
SELECT 
	Store_location,
	SUM(units * product_cost) AS Total_Cost,
    SUM(units * product_price) AS Total_sales,
    SUM(units * profit) AS Total_Profit
FROM sales s
JOIN stores st  
	USING (store_id)
JOIN products p 
	USING (product_id)
GROUP BY Store_location
ORDER BY Total_profit DESC;


-- Returning city with the highest profit/cost/sales          
SELECT 
	Store_city,
	SUM(units * product_cost) AS Total_Cost,
    SUM(units * product_price) AS Total_sales,
    SUM(units * profit) AS Total_Profit
FROM sales s
JOIN stores st  
	USING (store_id)
JOIN products p 
	USING (product_id)
GROUP BY Store_city
ORDER BY Total_profit DESC;

-- File exported for visualization


                    