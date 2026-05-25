
create database Retailsale

use retailsale

--2. Data Exploration & Cleaning

--Record Count: Determine the total number of records in the dataset.
select count(*) as total_no_of_record from Retailsalesanalysis


--Customer Count: Find out how many unique customers are in the dataset.
select count( distinct customer_id) from RetailSalesanalysis 


--Category Count: Identify all unique product categories in the dataset.
select count(distinct category) from RetailSalesanalysis
select distinct category from RetailSalesanalysis


--Null Value Check: Check for any null values in the dataset and delete records with missing data.

select * from RetailSalesanalysis
where
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantiy IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

delete from RetailSalesanalysis
   where
   sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantiy IS NULL OR price_per_unit IS NULL OR cogs IS NULL;


--- DATA ANALYSIS

--- 1 Write a SQL query to retrieve all columns for sales made on '2022-11-05:
select * from Retailsalesanalysis
where sale_date = '2022-11-05'


--- 2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and
---   the quantity sold is more than 4 in the month of Nov-2022:
select * from Retailsalesanalysis
where category = 'CLothing' and quantiy > =3 and year(sale_date) = 2022 and month(sale_date) =11


--- 3 Write a SQL query to calculate the total sales (total_sale) for each category.
select sum(total_sale) as Total_sale, category, COUNT(*) as total_orders from Retailsalesanalysis
group by category

    

--- 4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
select avg(age) as cust_AVG_AGe, category from Retailsalesanalysis
where category = 'Beauty'
group by category



--- 5 Write a SQL query to find all transactions where the total_sale is greater than 1000.:
select  * from Retailsalesanalysis
where total_sale >1000


--- 6 Write a SQL query to find the total number of transactions (transaction_id) 
---   made by each gender in each category.:

select count(transactions_id) as total_trans, gender, category from Retailsalesanalysis
group by gender, category


--- 7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

select year, month, avgsale from 
(
select avg(total_sale) as avgsale, month(sale_date) as month, year(sale_date) as Year,
rank () over(partition by month(sale_date) order by avg(total_sale) desc) as rank
from Retailsalesanalysis
group by month(sale_date), year(sale_date) 
) as A



--- 8 Write a SQL query to find the top 5 customers based on the highest total sales:
select top 5 customer_id, sum(Total_sale) as total_sale
from Retailsalesanalysis
group by customer_id
order by sum(Total_sale) desc


--- 9 Write a SQL query to find the number of unique customers who purchased items from each category.:

select count(distinct customer_id) as Uni_count, category from Retailsalesanalysis 
group by category


--- 10 Write a SQL query to create each shift and number of orders 
---   (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
with worklyhour
as
(
select *,
case
when hour(sale_time)<12 then 'Morning'
when hour(sale_time) between 12 and 17 then 'Afternoon'
else 'Evening'
end as shift
from Retailsalesanalysis
)
select shift, count(*) as total_orders
from worklyhour
group  by shift 



--Findings
--Customer Demographics: The dataset includes customers from various age groups, 
---             with sales distributed across different categories such as Clothing and Beauty.
--High-Value Transactions: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
--Sales Trends: Monthly analysis shows variations in sales, helping identify peak seasons.
--Customer Insights: The analysis identifies the top-spending customers and the most popular product categories.



--Reports
--Sales Summary: A detailed report summarizing total sales, customer demographics, and category performance.
--Trend Analysis: Insights into sales trends across different months and shifts.
--Customer Insights: Reports on top customers and unique customer counts per category.



--Conclusion
--This project serves as a comprehensive introduction to SQL for data analysts, 
---covering database setup, data cleaning,exploratory data analysis, and business-driven 
--- SQL queries. The findings from this project can help drive business 
--- decisions by understanding sales patterns, customer behavior, and product performance.