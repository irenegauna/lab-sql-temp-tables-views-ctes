-- 1. Create a View
-- First, create a view that summarizes rental information for each customer. 
-- The view should include the customer's ID, name, email address, and total number 
-- of rentals (rental_count).

CREATE VIEW section1 AS
SELECT c.customer_id, c.first_name, c.email, count(*)
FROM customer as c
LEFT JOIN rental as r ON c.customer_id=r.customer_id 
group by c.customer_id;

select *
from section1;

-- 2. Create a Temporary Table
-- Next, create a Temporary Table that calculates the total amount paid by each 
-- customer (total_paid). The Temporary Table should use the rental summary view 
-- created in Step 1 to join with the payment table and calculate the total amount
-- paid by each customer.

CREATE temporary table l
select s.customer_id,s.first_name, sum(p.amount)
from section1 as s
left join payment as p on s.customer_id=p.customer_id
group by s.customer_id;

select *
from l;

-- 3. Create a CTE and the Customer Summary Report
-- Create a CTE that joins the rental summary View with the customer payment 
-- summary Temporary Table created in Step 2. The CTE should include the 
-- customer's name, email address, rental count, and total amount paid.
WITH cte_customer as(
select s.customer_id,s.first_name, count(*), sum(p.amount)
from section1 as s
left join payment as p on s.customer_id=p.customer_id
group by s.customer_id)
select * from cte_customer;
