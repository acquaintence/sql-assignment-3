-- 1. List all customers who live in Texas (use JOINS)
select first_name, last_name, district
from customer 
full join address 
on customer.address_id = address.address_id 
left join city 
on address.city_id = city.city_id
where district = 'Texas'

-- 2. Get all payments above $6.99 with the customer's full name 
select first_name, last_name, amount
from customer 
right join payment
on customer.customer_id  = payment.customer_id 
where amount > 6.99
order by amount desc

-- 3. Show all customer's names who have made payments over $175 (use subqueries)
select first_name, last_name
from customer 
where customer_id in (
	select customer_id 
	from payment 
	group by customer_id 
	having sum(amount)>175
	order by sum(amount)desc)
	
-- 4. List all customers that live in Nepal (use the city table) 
select first_name, last_name
from customer 
where address_id in (
	select address_id 
	from address 
		where city_id in (
			select city_id
			from city
				where country_id in ( 
					select country_id
					from country 
					where country = 'Nepal')))

-- 5. Which staff member has the most transactions?
select COUNT(payment.staff_id), first_name, last_name
from payment
left join staff 
on payment.staff_id  = staff.staff_id 
group by first_name, last_name, payment.staff_id
order by count(payment.staff_id)desc
limit 1

-- 6. How many movies of each rating are there?
select rating, count(rating)
from film
group by rating


-- 7 Show all customers who have made a single payment above $6.99 (Use Subqueries)
select first_name, last_name
from customer
where customer_id in ( 
	select customer_id 
	from payment 
	where amount > 6.99)
	
-- 8. How many free rentals did the stores give away? 
select count(amount)
from payment where amount = 0 and rental_id is not null;
	
select * from payment 
where amount >= 0 
order by amount asc
-- none of the payments are equal to 0 aka free

select * from film 
order by rental_rate asc
--none of the rental rates for any movie is free 

