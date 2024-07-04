-- Create Views Queries:
--  View to display all orders with customer details
CREATE VIEW
    Customer_orders AS
SELECT
    C.*,
    O.order_id,
    product_id
from
    customers C
    join orders O ON C.customer_id = O.customer_id
    join order_details D on D.order_id = O.order_id
    --  Create a materialized view to store total sales per customer
    CREATE MATERIALIZED VIEW total_sales_per_customer AS
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(o.total_amount) AS total_sales
FROM
    customers c
    INNER JOIN orders o ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name;

-- Exe 2: 
create schema a
-- Create orders table
CREATE TABLE
    a.orders (order_id SERIAL PRIMARY KEY, order_date DATE NOT NULL, customer_id INT NOT NULL, total_amount NUMERIC(10, 2) NOT NULL);

-- Create order_items table
CREATE TABLE
    a.order_items (item_id SERIAL PRIMARY KEY, order_id INT NOT NULL, product_name VARCHAR(100) NOT NULL, quantity INT NOT NULL, unit_price NUMERIC(8, 2) NOT NULL, CONSTRAINT fk_order_id FOREIGN KEY (order_id) REFERENCES orders (order_id));

--     Scenario: Calculate Total Sales Amount for Each Customer
-- Problem: Calculate the total sales amount for each customer based on their orders and order items.
SELECT
    SUM(quantity * unit_price) AS total_sales,
    customer_id
from
    a.order_items I
    join a.orders O on O.order_id = I.order_id
group by
    customer_id