--1
CREATE DATABASE lab8;

--2
CREATE TABLE salesman(
    salesman_id INTEGER,
    name VARCHAR(255),
    city VARCHAR(255),
    comission DOUBLE PRECISION
);

CREATE TABLE customers(
    customer_id INTEGER,
    cust_name VARCHAR(255),
    city VARCHAR(255),
    grade INTEGER,
    salesman_id INTEGER REFERENCES salesmen
);

CREATE TABLE orders(
    ord_no INTEGER,
    purch_amt DOUBLE PRECISION,
    ord_date DATE,
    customer_id INTEGER REFERENCES customers,
    salesman_id INTEGER REFERENCES salesmen
);


--3
CREATE ROLE junior_dev LOGIN;

--4
CREATE VIEW from_ny as
    SELECT * FROM salesmen WHERE city = 'New York';

--5 Create a view that shows for each order the salesman and customer by name. Grant all privileges to «junior_dev»
CREATE VIEW orders AS
    SELECT  o.ord_no, o.purch_amt, o.ord_date FROM orders o
    JOIN customers c ON c.customer_id = o.customer_id
    JOIN salesman s ON s.salesman_id = c.salesman_id;

GRANT ALL PRIVILEGES ON orders TO junior_dev;
--6 Create a view that shows all of the customers who have the highest grade. Grant only select statements to «junior_dev»
CREATE VIEW top_customer AS
    SELECT * FROM customers
    WHERE grade = (SELECT MAX(grade) FROM customers);

GRANT SELECT ON top_customer TO junior_dev;
--7 Create a view that shows the number of the salesman in each city.
CREATE VIEW numbers AS
    SELECT city, COUNT(*) AS salesmans_count FROM salesman
    GROUP BY city;
--8 Create a view that shows each salesman with more than one customers.
CREATE VIEW salesmans_more_than_one AS
    SELECT s.name, s.city, COUNT(c.customer_id) as customer_count FROM salesman s
    JOIN customers c ON s.salesman_id = c.customer_id
    GROUP BY s.name, s.city
    HAVING COUNT(customer_id) > 1;

--9 Create role «intern» and give all privileges of «junior_dev».
CREATE ROLE intern LOGIN;
GRANT junior_dev to intern;