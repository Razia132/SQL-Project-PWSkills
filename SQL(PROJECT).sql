create database project;
use project;
-- retrieving entire dataset
select * from superstore;
-- retrieving column names
show columns from superstore;
-- No of rows
select count(*) from superstore;
DROP TABLE IF EXISTS superstore;
-- get unique ship mode(using tic symbol)
select distinct `Ship Mode` from superstore  ;
-- if column names has spaces in between if not samee just use distinct
select distinct city from superstore;
-- count how many orders were placed
select count(distinct `Order ID`) from superstore;
-- show total sales per category
select Category, sum(sales) as total_sales from superstore group by Category;
-- list allcustomers from California
select distinct `Customer Name` ,State from superstore where State ='California';
-- find total no of unique customers
select count(distinct `Customer Name`)as unique_customers from superstore;
-- profit acquired by the product chairs
select  sum(profit) from superstore where `Sub-Category`='Chairs';
-- Show top 5 products by sales
select `Product Name` ,sum(Sales) as Total_sales_of_product from superstore group by `Product Name` order by Total_sales_of_product desc limit 5;
-- Find the earliest and latest order date(bcoz it has backward slash it is string convert into perfect date format first
select min(STR_TO_DATE (`Order Date`,'%m-%d-%Y')) as early_date,max(STR_TO_DATE (`Order Date`,'%m-%d-%Y')) as late_date from superstore;
-- Average discount per region
select Region,avg(discount) as avg_discount from superstore group by Region;
-- State with highest total sales
select State ,sum(sales) as total_sales from superstore group by State order by total_sales desc limit 1;
-- total quantity of products sold per sub-category
select `Sub-Category`,sum(Quantity) from superstore group by `Sub-Category`;
-- Number of orders shipped using 'Second class'
select `Ship Mode`,count(distinct `Order ID`) as no_of_orders from superstore where `Ship Mode`='Second Class';
-- List customers woth more than 2 orders
select `Customer ID`,`Customer Name`,count(distinct `Order ID`) as orders from superstore group by `Customer Name`,`Customer ID` having orders>2; 
-- Top 3 sub categories by profit in each category
select * from(
select Category,`Sub-Category` ,sum(profit), rank() over(Partition by category order by sum(profit)desc)as rk
 from superstore group by Category ,`Sub-Category`) as ranked_subs where rk<=3;
-- find orders with negative profit
select `Order ID`,`Product Name`,Profit from superstore where Profit<0;
-- Cities where more than 10000 of sales happened
select City,sum(Sales) as total_sales from superstore group by City having total_sales>10000;
-- find the products with zero profits but non zero sales
select `Product Name` ,Sales,Profit from superstore where Profit=0 AND sales>0;
-- Sub-Category where discount was always 0.
select `Sub-Category` from superstore group by `Sub-Category`  having max(Discount)=0;
-- Rank customers by profit in each region
select * from(select `Customer Name` ,sum(Profit) as total_profit ,rank() over(partition by Region order by sum(profit) desc) as rk from superstore  group by Region ,`Customer Name` )as region_coustomers;







