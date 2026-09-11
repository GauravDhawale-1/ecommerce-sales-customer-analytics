USE ecommerce_powerbi_project;

SHOW TABLES;

select * from customers;

select * from payments;

select * from products limit 10;

select * from orders limit 10;


-- Finding Total Revanue
select sum(p.price*o.quantity) as total_ravanue from orders o inner join products p on o.product_id=p.product_id inner join payments m on o.order_id=m.order_id where payment_status="Paid";

-- Finding Which products perform best
with ord as (
select o.* from orders o inner join payments p on o.order_id=p.order_id where payment_status="Paid"),
prs as (
select o.product_id, p.product_name ,sum(p.price*o.quantity) as Revanue from ord o inner join products p on o.product_id=p.product_id group by o.product_id)
select * from prs order by Revanue desc limit 3 ;

-- Wtich Catogary preform best 
with ord as (
select o.* from orders o inner join payments p on o.order_id=p.order_id where payment_status="Paid"),
catg as (
select p.category, sum(p.price*o.quantity) as Revanue from ord o inner join products p on o.product_id=p.product_id group by p.category)
select * from catg where revanue=(select max(revanue) from catg);

-- Most Valuable Customer
with ord as (
select o.* from orders o inner join payments p on o.order_id=p.order_id where payment_status="Paid"),
 vcs as(
select o.customer_id,c.customer_name, sum(p.price*o.quantity) as Spend from ord o inner join customers c on c.customer_id = o.customer_id inner join products p on o.product_id=p.product_id group by customer_id)
select * from vcs order by spend desc limit 3;

-- Total Orders
select count(o.order_id)as Total_orders from orders o inner join payments p on o.order_id=p.order_id where payment_status="Paid";

-- Total Customers
select count(distinct o.customer_id) as Total_customers from orders o inner join payments p on o.order_id=p.order_id where payment_status="Paid";

-- Average Order Value
with rev as (
select sum(p.price*o.quantity) as Total_revanue,count(o.order_id) as orders from orders o inner join products p on o.product_id=p.product_id inner join payments m on o.order_id=m.order_id where payment_status="Paid")
select (Total_revanue/orders) as Avarage_order_value from rev;

-- Monthly Revenue
with ord as (
select o.* from orders o inner join payments p on o.order_id = p.order_id where payment_status ="Paid"), 
mon as (
select month(o.order_date) as months , sum(p.price*o.quantity) as Renanue from ord o inner join products p on o.product_id = p.product_id group by month(o.order_date))
select * from mon order by months asc;

-- City Performance
with city as (
select c.city , sum(p.price * o.quantity) as Revanue from orders o inner join products p on o.product_id =p.product_id inner join customers c on o.customer_id=c.customer_id  inner join payments m on m.order_id=o.order_id where payment_status="Paid" group by c.city)
select * from city order by Revanue desc;

-- Payment Method Analysis
select distinct payment_method, count(order_id) as Total_orders from payments where payment_status="Paid" group by payment_method;

-- Payment Revenue by Method
select payment_method, sum(r.price*o.quantity) as Revanue from orders o inner join payments p on o.order_id=p.order_id inner join products r on o.product_id=r.product_id where payment_status="Paid" group by payment_method;

-- Top 5 Customers by Spending
with cus as (
select o.customer_id,c.customer_name, sum(p.price*o.quantity) as Spending from orders o inner join products p on o.product_id=p.product_id inner join customers c on o.customer_id=c.customer_id  inner join payments m on o.order_id=m.order_id where payment_status ="Paid" group by o.customer_id),
rnk as (
select * ,
dense_rank() over(order by spending desc) as top 
from cus)
select * from rnk where top<= 5;

-- Top Product in Each Category
with pr as(
select p.category,p.product_name,sum(p.price*o.quantity) as Revanue from orders o inner join products p on o.product_id=p.product_id inner join payments m on o.order_id=m.order_id where payment_status="Paid" group by o.product_id ),
rnk as (
select * ,
dense_rank () over(partition by category order by Revanue desc) as rnk
from pr)
select category,product_name,Revanue from rnk where rnk =1;

-- Payment Status Analysis
select payment_status , count(order_id) as orders from payments group by payment_status;

-- Top 3 Cities
with cit as (
select c.city, sum(p.price*o.quantity) as Revanue from customers c inner join orders o on c.customer_id=o.customer_id inner join products p on o.product_id=p.product_id inner join payments m on m.order_id=o.order_id  where payment_status="Paid" group by c.city)
select * from cit order by revanue desc limit 3;

-- Customer Order Frequency
with co as (
select o.customer_id,c.customer_name, count(o.order_id) as Total_order from orders o inner join customers c on o.customer_id=c.customer_id inner join payments p on o.order_id=p.order_id where payment_status="Paid" group by o.customer_id )
select * from co order by Total_order desc;

-- 
select o.customer_id,c.customer_name, count(o.order_id) as Total_order from orders o inner join customers c on o.customer_id=c.customer_id inner join payments p on o.order_id=p.order_id where payment_status="Paid" group by o.customer_id,c.customer_name having count(o.order_id)>1;

-- Monthly Order Count
select month(o.order_date), count(o.order_id) from orders o inner join payments p on o.order_id=p.order_id where payment_status="Paid" group by month(o.order_date);

-- Top 5 Products by Quantity Sold
with qua as (
select p.product_name,sum(o.quantity) as Total_Quantity from orders o inner join products p on o.product_id=p.product_id inner join payments m on o.order_id=m.order_id where payment_status="Paid" group by o.product_id),
rnk as(
select * ,
dense_rank() over(order by Total_Quantity desc) as Top
from qua)
select product_name,Total_quantity from rnk where top <=5;

-- Category Performance
select p.category,count(o.order_id)as Total_orders,sum(o.quantity)as Total_quantity,sum(p.price*o.quantity)as Revanue
from orders o inner join products p on o.product_id=p.product_id inner join payments m on o.order_id=m.order_id 
where m.payment_status="Paid" group by p.category;

-- Category Performance
with cus as(
select c.customer_name , sum(p.price*o.quantity) as Revanue from orders o inner join customers c on o.customer_id=c.customer_id inner join products p on p.product_id=o.product_id inner join payments m on o.order_id=m.order_id where payment_status="Paid" group by o.customer_id )
select  * from cus where Revanue > (select avg(revanue) from cus);

-- Best-Selling Product
with bp as (
select p.product_id,p.product_name,sum(p.price*o.quantity) as Revanue from orders o inner join products p on o.product_id=p.product_id inner join payments m on o.order_id=m.order_id where payment_status="Paid" group by o.product_id)
select * from bp where revanue =(select max(revanue) from bp);

-- Lowest-Selling Product
with ls as (
select p.product_id,p.product_name,sum(p.price*o.quantity) as Revanue from orders o inner join products p on o.product_id=p.product_id inner join payments m on o.order_id=m.order_id where payment_status="Paid" group by o.product_id)
select * from ls where revanue =(select min(revanue) from ls);

-- Repeat Customer Percentage
WITH cp AS (
    SELECT c.customer_id,
           c.customer_name,
           COUNT(o.order_id) AS orders
    FROM customers c
    INNER JOIN orders o ON o.customer_id = c.customer_id
    INNER JOIN payments m ON o.order_id = m.order_id
    WHERE m.payment_status = 'Paid'
    GROUP BY c.customer_id, c.customer_name
    HAVING COUNT(o.order_id) > 1
),
total_customer AS (
    SELECT COUNT(DISTINCT o.customer_id) AS total_customers
    FROM orders o
    INNER JOIN payments m ON o.order_id = m.order_id
    WHERE m.payment_status = 'Paid'
)
SELECT 
    COUNT(*) AS repeat_customers,
    MAX(total_customers) AS total_customers,
    ROUND(COUNT(*) * 100.0 / MAX(total_customers), 2) AS repeat_customer_percentage
FROM cp
CROSS JOIN total_customer;