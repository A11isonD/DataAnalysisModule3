-- ==================================
-- FILTERS & AGGREGATION
-- ==================================

USE coffeeshop_db;


-- Q1) Compute total items per order.
--     Return (order_id, total_items) from order_items.
select order_id, sum(quantity) as total_items from order_items
group by order_id
order by order_id;

-- Q2) Compute total items per order for PAID orders only.
--     Return (order_id, total_items). Hint: order_id IN (SELECT ... FROM orders WHERE status='paid').
select order_items.order_id, sum(order_items.quantity) as total_items from order_items
left join orders ON order_items.order_id = orders.order_id
where orders.status = 'paid'
group by order_items.order_id;

-- Subquery use:

select order_id, sum(quantity) as total_items	
from order_items
where order_id in (select order_id
from orders
where status = 'paid')
group by order_id;

	
-- Q3) How many orders were placed per day (all statuses)?
--     Return (order_date, orders_count) from orders.
-- need order_datetime from orders
-- need the number of orders
-- group by order_date  - group by has a hierarchy - if you put it at the front, you need to put it at the end, too.
-- sort by date (using order by)   
-- select order_datetime
select order_datetime as order_date, sum(quantity) as orders_count
from orders 
inner join order_items on orders.order_id = order_items.order_id
group by order_date;
-- I know this isn't completely correct. I cannot figure out how to get a sum for each day (yet). I would keep trying if I had unlimited time but I must go on to other questions in order to finish the assignment.  



-- Q4) What is the average number of items per PAID order?
--     Use a subquery or CTE over order_items filtered by order_id IN (...).
-- select avg, where status = 'paid'. Need a subquery
select avg(quantity) as avg_quantity from order_items 
where order_id in (select order_id
from orders
where status = 'paid');

-- Q5) Which products (by product_id) have sold the most units overall across all stores?
--     Return (product_id, total_units), sorted desc.

-- Q6) Among PAID orders only, which product_ids have the most units sold?
--     Return (product_id, total_units_paid), sorted desc.
--     Hint: order_id IN (SELECT order_id FROM orders WHERE status='paid').

-- Q7) For each store, how many UNIQUE customers have placed a PAID order?
--     Return (store_id, unique_customers) using only the orders table.

-- Q8) Which day of week has the highest number of PAID orders?
--     Return (day_name, orders_count). Hint: DAYNAME(order_datetime). Return ties if any.


-- Q9) Show the calendar days whose total orders (any status) exceed 3.
--     Use HAVING. Return (order_date, orders_count).

-- Q10) Per store, list payment_method and the number of PAID orders.
--      Return (store_id, payment_method, paid_orders_count).


-- Q11) Among PAID orders, what percent used 'app' as the payment_method?
--      Return a single row with pct_app_paid_orders (0–100).

-- Q12) Busiest hour: for PAID orders, show (hour_of_day, orders_count) sorted desc.


-- ================

SELECT DISTINCT c.customer_id, c.first_name, c.last_name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE oi.product_id IN (    
SELECT product_id    
FROM products    
WHERE category_id = (        
SELECT category_id        
FROM categories        
WHERE name = 'Roasting Equipment'    
)
); 


SELECT product_id, name, price
FROM products
WHERE price > (    
SELECT AVG(price)    
FROM products
);
