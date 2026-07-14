use OlistDB
-- Q1 What are the Total Number of completed Orders 
select count(*) As [No.of Orders]
from orders
where order_status <> 'canceled'

-- Q2 What are the Top 5 States where No.of customers are highest
select top 5 
	upper(customer_state) as customer_state,
	count(Distinct customer_unique_id) As [No.of customer]
from customers
group by customer_state
order by [No.of customer] desc

-- Q3 What are the Top 5 States where Total Sales are highest
select top 5 
	upper(c.customer_state) as customer_state,
	round(sum(revenue),2)As Total_Sales
from orders as o
left join (
		select 
			order_id,
			sum(price) as Revenue 
		from order_items
		group by order_id) as ot
	on o.order_id = ot.order_id
inner join customers as c
	on o.customer_id = c.customer_id
group by c.customer_state
order by Total_Sales desc

-- Q4 What are the Top 5 products category based on the Total Sales 
select top 5 
	p.product_category_name,
	sum(revenue) as Total_Sales
from products as p 
right join (
		select 
			product_id,
			sum(price) as Revenue
		from order_items 
		group by product_id) as ot
	on p.product_id = ot.product_id
group by p.product_category_name
order by Total_Sales desc 

-- Q5 What are the Top 5 products category based on the Average Reviews
select top 5 
	p.product_category_name,
	round(Avg(ors.avg_review),2) As avg_review
from (
	select 
		order_id,
		avg(cast(review_score as float)) as avg_review
	from order_reviews
	group by order_id ) as ors
left join order_items as ot
	on ors.order_id = ot.order_id
left join products as p
	on ot.product_id = p.product_id
group by p.product_category_name
order by avg_review desc

-- Q6 Do Total Sales Increase from past years ?
select 
	o.purchase_year,
	round(sum(revenue),2) as Annual_Revenue
from(
		select 
			order_id,
			sum(price) as revenue
		from order_items as ot
		group by order_id) as ot
left join orders as o 
	on ot.order_id = o.order_id
group by o.purchase_year
order by purchase_year

-- Q7 Trend of Total Sales by each month
select 
	o.purchase_month,
	round(sum(revenue),2) as Annual_Revenue
from(
		select 
			order_id,
			sum(price) as revenue
		from order_items as ot
		group by order_id) as ot
left join orders as o 
	on ot.order_id = o.order_id
group by o.purchase_month
order by o.purchase_month

-- Q8 Trend of Total Sales by each week day
select 
	o.purchase_day,
	round(sum(revenue),2) as Annual_Revenue
from(
		select 
			order_id,
			sum(price) as revenue
		from order_items as ot
		group by order_id) as ot
left join orders as o 
	on ot.order_id = o.order_id
group by o.purchase_day
order by o.purchase_day

-- Q9 Which Customer State have the highest delivery days
select top 5 
	upper(customer_state) as customer_state ,
	round(Avg(order_delivered_day),2) as avg_delivered_day
from (
	select 
		customer_id,
		order_delivered_day
	from orders
	where order_status = 'delivered' ) as o
left join customers as c
	on o.customer_id = c.customer_id
group by customer_state
order by avg_delivered_day desc

-- Q10 How much percentage of orders are getting late delivery ?
select 
	delivered_on_time,
	round((no_of_delivery*100)/sum(no_of_delivery) over (),2)  [delivery %]
from (
select 
	delivered_on_time,
	cast(count(*) as float ) As no_of_delivery
from orders
where order_status = 'delivered'
group by delivered_on_time
) as x

-- Q11 Which product categories experience the most late deliveries?
with order_cte as (
select 
	order_id,
	case when delivered_on_time = 'No' then 1.0 else 0.0 end late_count
from orders
where order_Status = 'delivered')
select 
	p.product_category_name,
	avg(late_count)*100 as late_percent
from order_cte as oc
left join order_items as ot	
	on oc.order_id = ot.order_id
left join products as p
	on p.product_id = ot.product_id
group by product_category_name
order by late_percent desc

-- Q12 Concate customer state with seller state and find where the delivery system is inefficient 
select 
	customer_state_to_seller,
	AVG(delivered_on_time)*100 as late_delivery_percent
from (
select 
	o.order_id,
	concat(upper(customer_state),'-',seller_state) as customer_state_to_seller ,
	case when delivered_on_time ='No'then 1.0 else 0.0 end delivered_on_time
from orders as o
left join customers as c
	on c.customer_id = o.customer_id
left join order_items as ot
	on o.order_id = ot.order_id
left join sellers as s
	on s.seller_id = ot.seller_id
where order_status = 'delivered'
) as x
group by customer_state_to_seller
order by late_delivery_percent desc

-- Q13 Find categories with revenue above the average category revenue.
select
	product_category_name,
	round(revenue_by_category,2) as revenue_by_category,
	round(avg_revenue,2) as avg_revenue
from (
select 
	p.product_category_name,
	sum(price) as revenue_by_category,
	avg(sum(price)) over () as avg_revenue
from order_items as ot
left join products as p 
	on ot.product_id = p.product_id
group by p.product_category_name) as x
where revenue_by_category >= avg_revenue
order by revenue_by_category desc

-- Q14 Calculate each category's contribution to total revenue (%).
select top 5
	product_category_name,
	round(revenue_by_category,2) as revenue_by_category,
	round(revenue,2) as revenue,
	round(revenue_by_category/revenue*100,2) as contribution_by_category
from (
select 
	p.product_category_name,
	sum(price) as revenue_by_category,
	sum(sum(price)) over () revenue
from order_items as ot
left join products as p 
	on ot.product_id = p.product_id
group by p.product_category_name) as x
order by contribution_by_category desc;

-- Q15 Calculate month-over-month revenue growth.
with month_revenue as (
select 
	o.purchase_year,
	o.purchase_month,
	sum(price) as revenue_by_month,
	lag(sum(price),1) over (order by  o.purchase_year,o.purchase_month) as previous_revenue_by_month
from order_items  as ot
inner join orders as o
	on o.order_id = ot.order_id
group by 
	o.purchase_year,
	o.purchase_month)
select 
	purchase_year,
	purchase_month,
	revenue_by_month,
	previous_revenue_by_month,
	(revenue_by_month-previous_revenue_by_month)/previous_revenue_by_month*100 as growth_by_month_percent
from month_revenue
where previous_revenue_by_month is not null

-- Q16 Which cities generate the highest revenue?
select top 10
	c.customer_city,
	round(sum(revenue),2)As Total_Sales
from orders as o
left join (
		select 
			order_id,
			sum(price) as Revenue 
		from order_items
		group by order_id) as ot
	on o.order_id = ot.order_id
inner join customers as c
	on o.customer_id = c.customer_id
group by c.customer_city
order by Total_Sales desc

-- Q17 What is the cancellation rate by state?
select top 5
	Customer_state,
	no_of_cancel/no_of_orders*100 as percent_of_cancel
from (
select
	upper(c.customer_state) customer_state,
	sum(case when o.order_status = 'canceled' then 1.0 else 0.0 end) as no_of_cancel,
	count(o.order_id) as no_of_orders
from orders as o
left join customers as c
	on o.customer_id = c.customer_id
group by c.customer_state) as x
order by percent_of_cancel desc

-- Q18 Rank the Most used payment Methods by customers based on the number of time uses
select
	payment_type,
	count(distinct order_id) as no_of_use
from order_payments
group by payment_type
order by no_of_use desc

-- Q19 Calculate the Average Payment Amount of payment methods 
select 
	payment_type,
	AVG(payment_value) as avg_amount
from order_payments
group by payment_type
order by avg_amount desc ;

-- Q20 Find Customers state with the highest percentage of late orders delivery
with orders_cte as (
select 
	o.customer_id,
	upper(c.customer_state) as customer_state,
	case when delivered_on_time = 'No' then 1.0 else 0.0 end as delivered_on_time
from orders as o
left join customers as c
	on o.customer_id = c.customer_id
where order_status = 'delivered' 
), customer_cte as (
select 
	customer_state,
	avg(delivered_on_time)*100 as count_by_state
from orders_cte
group by customer_state
)
select top 5 *
from customer_cte
order by count_by_state desc
