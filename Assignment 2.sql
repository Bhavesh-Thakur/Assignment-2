use mavenmovies;

-- Q1. Retrive the total number of rentals made in the sakila database.
select* from rental;
select count(rental_id) from rental;

-- Q2. Find the average rental duration(in days) of movies rented from the sakila database. 
select* from film;
select avg(rental_duration) from film;

-- String Function
-- Q3. Display the first and last name of the customer in uppercase.
select* from customer;
select upper(concat(first_name, " " ,last_name))as name from customer;

-- Q4. Extract the month from the rental date and display it alongside the rental ID.
select* from rental;
select rental_id, month(rental_date) from rental; 

-- Group By
-- Q5. Retrieve the count of rentals for each customer (display customer ID and the count of rentals). 
select * from rental;
select customer_id , count(rental_id) from rental  group by customer_id;

-- Q6 Find the total revenue generated by each store. 
select* from store;
select * from payment;
select staff_id , sum(amount) from payment group by staff_id;

-- JOINS


-- Q7. Display the title of the movies , customer's first name , and the last name who rented it.
select * from film;
select* from inventory;
select* from rental;
select * from customer;
SELECT 
    film.title, customer.first_name, customer.last_name
FROM
    film
        INNER JOIN
    inventory ON film.film_id = inventory.film_id
        INNER JOIN
    rental ON inventory.inventory_id = rental.inventory_id
        INNER JOIN
    customer ON rental.customer_id = customer.customer_id;
    
    -- Q8 retrive the name of all the actors who have appeared in the film " Gone with the Wind". 
    select * from actor;
select * from film;
SELECT 
    title, first_name, last_name
FROM
    actor
        INNER JOIN
    film ON actor.actor_id = film.film_id
WHERE
    title = 'Gone with the wind'; -- THERE IS NO FILM WITH THE NAME " GONE WITH THE WIND"
    
    
    -- GROUP BY
    
    
    -- Q1. Determine the total number of rental for each category of movies. 
     select * from film_category;
    select * from film;
     select * from rental;
SELECT 
    film_category.category_id, COUNT(film_category.category_id)as total_no_of_rental
FROM
    film_category
        INNER JOIN
    film ON film_category.film_id = film.film_id
        INNER JOIN
    rental ON film.film_id = rental.rental_id
GROUP BY film_category.category_id;

-- Q2. Find the average rental rate of movies in each language.
select* from film;
select* from language;
SELECT 
    film.language_id, AVG(rental_rate)
FROM
    film
        INNER JOIN
    language ON film.language_id = language.language_id
GROUP BY film.language_id;
    
    
    -- JOINS
    
    -- Q3. Retrive the customer names along with the total amount they've spent on rentals.
    select * from customer;
     select * from payment;
      select * from rental;
    SELECT 
    first_name, last_name, SUM(amount)
FROM
    customer
        INNER JOIN
    payment ON customer.customer_id = payment.customer_id
        INNER JOIN
    rental ON payment.customer_id = rental.customer_id
GROUP BY payment.customer_id;

-- Q4. List the titles of movies rented by each customer in a particular city (e.g, 'london'). 
select * from customer;
select * from address;
select * from city;
select * from rental;
select * from inventory;
select * from film;

SELECT 
    title, city ,count(customer.customer_id)
FROM
    customer
        INNER JOIN
    address ON customer.address_id = address.address_id
        INNER JOIN
    city ON address.city_id = city.city_id
        INNER JOIN
    rental ON city.city_id = rental.rental_id
        INNER JOIN
    inventory ON rental.inventory_id = inventory.inventory_id
        INNER JOIN
    film ON inventory.film_id = film.film_id
WHERE
    city = 'london'
    group by customer.customer_id;


-- Q5. Display the top 5 rented movies along with the number of times they've been rented.
select * from film;
select * from inventory;
select * from rental;
SELECT 
   title, COUNT(title) AS rented_movies
FROM
    film
        INNER JOIN
    inventory ON film.film_id = inventory.film_id
        INNER JOIN
    rental ON inventory.inventory_id = rental.inventory_id
GROUP BY title
LIMIT 5;

-- Q6. determine the customers who have rented movies from both stores (store id 1 and store ID 2). 
select * from rental;
select * from inventory;
select * from customer;
SELECT 
customer.store_id, count(customer.store_id) 
FROM
    customer
        INNER JOIN
    inventory ON customer.store_id = inventory.store_id
    INNER JOIN
    rental ON inventory.inventory_id = rental.inventory_id group by customer.store_id ;