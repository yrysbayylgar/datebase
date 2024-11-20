create table customers(
    customer_id int primary key,
    cust_name varchar(255),
    city varchar(255),
    grade int,
    salesman_id int
);
create table orders(
    ord_no int primary key,
    purch_amt float,
    ord_date date,
    customer_id int,
    salesman_id int
);
create table salesman(
    salesman_id int primary key,
    name varchar(255),
    city varchar(255),
    commission float
);
insert into customers (customer_id,cust_name,city,grade,salesman_id) values
(3002,'Nick Rimando','New York',100,5001 ),
(3005,'Graham Zusi','California',200,5002),
(3001,'Brad Guzan','London',100,5005),
(3004,'Fabian Johns','Paris',300,5006),
(3007,'Brad Davis','New York',200,5001),
(3009,'Geoff Camero','Berlin',100,5003),
(3008,'Julian Green','London',300,5002);

insert into orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) values
(70001, 150.50, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.50, '2012-08-17', 3009, 5003),
(70007, 948.50, '2012-09-10', 3005, 5002),
(70005, 2400.60, '2012-07-27', 3007, 5001),
(70008, 5760.00, '2012-09-10', 3002, 5001);
insert into salesman (salesman_id, name, city, commission) values
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5003, 'Lauson Hen', 'London', 0.12),
(5007, 'Paul Adam', 'Rome', 0.13);

create role junior_dev login;

create view ny_salesmen as select * from salesman where city = 'new york';

create view order_details as
select orders.ord_no, orders.ord_date, orders.purch_amt,salesman.name as salesman_name, customers.cust_name
as customer_name from orders
join salesman on orders.salesman_id = salesman.salesman_id
join customers on orders.customer_id = customers.customer_id;
grant all privileges on order_details to junior_dev;

create view top_customers as
select * from customers
where grade = (select max(grade) from customers);
grant select on top_customers to junior_dev;

create view salesman_count as
select city, count(*) as num_salesmen
from salesman
group by city;

create view multiple_customers as
select salesman.salesman_id, salesman.name, count(customers.customer_id) as num_customers from salesman
join customers on customers.city = salesman.city
group by salesman.salesman_id, salesman.name
having count(customers.customer_id) > 1;

create role intern;
grant junior_dev to intern;