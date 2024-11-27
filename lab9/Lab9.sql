CREATE DATABASE lab9;

CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    salary NUMERIC(10, 2) NOT NULL
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    category TEXT NOT NULL,
    price NUMERIC(10, 2) NOT NULL
);

-- Insert data into Employees
INSERT INTO employees (name, salary) VALUES
('John Doe', 5000.00),
('Jane Smith', 7000.50),
('Alice Brown', 6000.25),
('Bob White', 4500.75);

-- Insert data into Products
INSERT INTO products (name, category, price) VALUES
('Laptop', 'Electronics', 1000.00),
('Headphones', 'Electronics', 150.00),
('Desk Chair', 'Furniture', 200.00),
('Table Lamp', 'Furniture', 50.00),
('Mouse', 'Electronics', 25.00);

-- 1.
CREATE OR REPLACE FUNCTION add_ten(val INTEGER) RETURNS INTEGER AS $$
BEGIN
    RETURN val + 10;
END;
$$ LANGUAGE plpgsql;

--1.
SELECT add_ten(10);

-- 2.
CREATE OR REPLACE FUNCTION compare_two_numbers(a INTEGER, b INTEGER) RETURNS TEXT AS $$
BEGIN
    IF a > b THEN
        RETURN 'A is greater';
    ELSIF a < b THEN
        RETURN 'A is lesser';
    ELSE
        RETURN 'Equal';
    END IF;
END;
$$ LANGUAGE plpgsql;

SELECT compare_two_numbers(5, 10);

-- 3.
CREATE OR REPLACE FUNCTION number_series(n INTEGER)
RETURNS SETOF INTEGER AS $$
DECLARE
    i INTEGER;
BEGIN
    FOR i IN 1..n LOOP
        RETURN NEXT i;
    END LOOP;
    RETURN;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM number_series(5);

-- 4.
CREATE OR REPLACE FUNCTION find_employee(emp_name TEXT)
RETURNS TABLE(emp_id INT, emp_name TEXT, emp_salary NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, salary
    FROM employees
    WHERE employees.name ILIKE emp_name;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM find_employee('John%');

-- 5. Fetch Products Function
CREATE OR REPLACE FUNCTION fetch_products(category_name TEXT)
RETURNS TABLE(product_id INT, product_name TEXT, product_price NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT id, name, price
    FROM products
    WHERE category = category_name;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM fetch_products('Electronics');

-- 6. Calculate Bonus and Update Employee Salary
CREATE OR REPLACE FUNCTION calc_bonus(emp_id INT) RETURNS NUMERIC AS $$
DECLARE
    bonus NUMERIC;
BEGIN
    SELECT salary * 0.1 INTO bonus
    FROM employees
    WHERE id = emp_id;
    RETURN bonus;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_employee_salary(emp_id INT) RETURNS VOID AS $$
DECLARE
    bonus NUMERIC;
BEGIN
    bonus := calc_bonus(emp_id);
    UPDATE employees SET salary = salary + bonus WHERE id = emp_id;
END;
$$ LANGUAGE plpgsql;

-- Test Calculate Bonus
SELECT calc_bonus(1);

-- Update Employee Salary
SELECT update_employee_salary(1);

-- 7. Combined Calculation Function
CREATE OR REPLACE FUNCTION combined_calc(num INT, str TEXT) RETURNS TEXT AS $$
DECLARE
    num_result INT;
    str_result TEXT;
BEGIN
    BEGIN
        num_result := (num * 2) + 5;
    END;

    BEGIN
        str_result := 'Processed: ' || upper(str);
    END;

    RETURN 'Numeric: ' || num_result || ', String: ' || str_result;
END;
$$ LANGUAGE plpgsql;

-- Test Combined Calculation
SELECT combined_calc(3, 'hello');