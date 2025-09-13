create database pizzahut;

create table orders (Order_id int not null unique, order_date date not null, order_time time not null);

select * from orders;

create table order_details (Order_details_id int not null unique, order_id int not null, pizza_id text not null, quantity int not null);

## 1.Retrieve the Total no of orders placed.

select count(order_id) as Total_orders from orders;

 ## 2.Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS Total_sales
FROM
    order_details
        INNER JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id;

## 3. Determine the distribution of orders by hour of the day.

SELECT 
    HOUR(order_time), COUNT(order_id) AS order_count
FROM
    orders
GROUP BY HOUR(order_time);

## 4. Join relevant tables to find the category-wise distribution of pizzas.

select category, count(name) from pizza_types
group by category;

## 5.Identify the highest-priced pizza.

SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        INNER JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;

## 6.Identify the most common pizza size ordered.

SELECT 
    pizzas.size,
    COUNT(order_details.Order_details_id) AS Order_count
FROM
    pizzas
        INNER JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC;

## 7.List the top 5 most ordered pizza types along with their quantities.

SELECT 
    pizza_types.name, SUM(order_details.quantity) AS quantity
FROM
    pizza_types
        INNER JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        INNER JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY quantity DESC
LIMIT 5;

## 8. Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS quantity
FROM
    pizza_types
        INNER JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        INNER JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC;



## 9. Group the orders by date and calculate the average number of pizzas ordered per day.

select round(avg(quantity),0) from
(select orders.order_date,sum(order_details.quantity)as quantity from orders
inner join order_details
on orders.Order_id=order_details.order_id
group by orders.order_date) as order_quantity;

## 10. Determine the top 3 most ordered pizza types based on revenue.

SELECT pizza_types.name, SUM(order_details.quantity * pizzas.price) AS revenue
FROM pizza_types
INNER JOIN pizzas 
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
INNER JOIN
order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.name
ORDER BY revenue DESC
LIMIT 3;







