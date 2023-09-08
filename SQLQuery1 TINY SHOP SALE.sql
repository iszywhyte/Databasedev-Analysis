

-- create a database call Tiny_shop where will can store our data
--CREATE DATABASE TINY_SHOP;

-- create a table to hold our customers information
CREATE TABLE customers (
    customer_id integer PRIMARY KEY,
    first_name varchar(100),
    last_name varchar(100),
    email varchar(100)
);

-- create a table to hold customer product item information
CREATE TABLE products (
    product_id integer PRIMARY KEY,
    product_name varchar(100),
    price decimal
);

-- create a table to hold customers orders details
CREATE TABLE orders (
    order_id integer PRIMARY KEY,
    customer_id integer,
    order_date date
);

--create a table to hold customer table order_items
CREATE TABLE order_items (
    order_id integer,
    product_id integer,
    quantity integer
);

--let's insert relevant customer information into our customer table
INSERT INTO customers (customer_id, first_name, last_name, email) VALUES
(1, 'John', 'Doe', 'johndoe@email.com'),
(2, 'Jane', 'Smith', 'janesmith@email.com'),
(3, 'Bob', 'Johnson', 'bobjohnson@email.com'),
(4, 'Alice', 'Brown', 'alicebrown@email.com'),
(5, 'Charlie', 'Davis', 'charliedavis@email.com'),
(6, 'Eva', 'Fisher', 'evafisher@email.com'),
(7, 'George', 'Harris', 'georgeharris@email.com'),
(8, 'Ivy', 'Jones', 'ivyjones@email.com'),
(9, 'Kevin', 'Miller', 'kevinmiller@email.com'),
(10, 'Lily', 'Nelson', 'lilynelson@email.com'),
(11, 'Oliver', 'Patterson', 'oliverpatterson@email.com'),
(12, 'Quinn', 'Roberts', 'quinnroberts@email.com'),
(13, 'Sophia', 'Thomas', 'sophiathomas@email.com');


--- insert customer production information into the product table we have create above
INSERT INTO products (product_id, product_name, price) VALUES
(1, 'Product A', 10.00),
(2, 'Product B', 15.00),
(3, 'Product C', 20.00),
(4, 'Product D', 25.00),
(5, 'Product E', 30.00),
(6, 'Product F', 35.00),
(7, 'Product G', 40.00),
(8, 'Product H', 45.00),
(9, 'Product I', 50.00),
(10, 'Product J', 55.00),
(11, 'Product K', 60.00),
(12, 'Product L', 65.00),
(13, 'Product M', 70.00);

--insert into customers order detail into the table order created as above
INSERT INTO orders (order_id, customer_id, order_date) VALUES
(1, 1, '2023-05-01'),
(2, 2, '2023-05-02'),
(3, 3, '2023-05-03'),
(4, 1, '2023-05-04'),
(5, 2, '2023-05-05'),
(6, 3, '2023-05-06'),
(7, 4, '2023-05-07'),
(8, 5, '2023-05-08'),
(9, 6, '2023-05-09'),
(10, 7, '2023-05-10'),
(11, 8, '2023-05-11'),
(12, 9, '2023-05-12'),
(13, 10, '2023-05-13'),
(14, 11, '2023-05-14'),
(15, 12, '2023-05-15'),
(16, 13, '2023-05-16');

--same we continue to insert customer order_items detail to the order_items table 
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 2),
(1, 2, 1),
(2, 2, 1),
(2, 3, 3),
(3, 1, 1),
(3, 3, 2),
(4, 2, 4),
(4, 3, 1),
(5, 1, 1),
(5, 3, 2),
(6, 2, 3),
(6, 1, 1),
(7, 4, 1),
(7, 5, 2),
(8, 6, 3),
(8, 7, 1),
(9, 8, 2),
(9, 9, 1),
(10, 10, 3),
(10, 11, 2),
(11, 12, 1),
(11, 13, 3),
(12, 4, 2),
(12, 5, 1),
(13, 6, 3),
(13, 7, 2),
(14, 8, 1),
(14, 9, 2),
(15, 10, 3),
(15, 11, 1),
(16, 12, 2),
(16, 13, 3);



--let view all the table and items will have successfully create on our database 
SELECT *
FROM
	customers, 
	order_items, 
	orders, 
	products;



 -- Case Study Questions

 --1) Which product has the highest price? Only return a single row.
SELECT TOP 1 product_name, price
FROM products
ORDER BY price DESC;


--2) Which customer has made the most orders?
SELECT TOP 1 customer_id, COUNT(order_id) AS order_count
FROM orders
GROUP BY customer_id
ORDER BY order_count DESC;


--3) What’s the total revenue per product?
SELECT p.product_name, SUM(oi.quantity * p.price) AS total_revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC;

--4) Find the day with the highest revenue.
SELECT TOP 1 order_date, SUM(products.price * order_items.quantity) AS daily_revenue
FROM orders
JOIN order_items ON orders.order_id = order_items.order_id
JOIN products ON order_items.product_id = products.product_id
GROUP BY order_date
ORDER BY daily_revenue DESC;

--5) Find the first order (by date) for each customer.
SELECT customer_id, MIN(order_date) AS first_order_date
FROM orders
GROUP BY customer_id;


--6) Find the top 3 customers who have ordered the most distinct products
SELECT TOP 1 o.customer_id, COUNT(DISTINCT oi.product_id) AS distinct_product_count
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
GROUP BY o.customer_id
ORDER BY distinct_product_count DESC;


--7) Which product has been bought the least in terms of quantity?
SELECT TOP 1 product_name, SUM(quantity) AS total_quantity_sold
FROM order_items
JOIN products ON order_items.product_id = products.product_id
GROUP BY product_name
ORDER BY total_quantity_sold ASC;

--8) What is the median order total?
WITH OrderTotals AS (
    SELECT orders.order_id, SUM(products.price * order_items.quantity) AS order_total
    FROM orders
    JOIN order_items ON orders.order_id = order_items.order_id
    JOIN products ON order_items.product_id = products.product_id
    GROUP BY orders.order_id
)
SELECT percentile_cont(0.5) WITHIN GROUP (ORDER BY order_total) OVER () AS median_order_total
FROM OrderTotals;


--9) For each order, determine if it was ‘Expensive’ (total over 300), ‘Affordable’ (total over 100), or ‘Cheap’.
WITH OrderTotals AS (
    SELECT orders.order_id, SUM(products.price * order_items.quantity) AS order_total
    FROM orders
    JOIN order_items ON orders.order_id = order_items.order_id
    JOIN products ON order_items.product_id = products.product_id
    GROUP BY orders.order_id
)
SELECT order_id,
       CASE
           WHEN order_total > 300 THEN 'Expensive'
           WHEN order_total > 100 THEN 'Affordable'
           ELSE 'Cheap'
       END AS order_category
FROM OrderTotals;



--10) Find customers who have ordered the product with the highest price.
SELECT DISTINCT c.customer_id, c.first_name, c.last_name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE p.price = (SELECT MAX(price) FROM products);

