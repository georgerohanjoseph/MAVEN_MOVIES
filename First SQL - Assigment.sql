use mavenmovies;

select *
from rental;

select customer_id, rental_date
from rental;

select *
from inventory;

select * from film;

select * from customer;

select * from inventory;

-- Your boss has asked you email ids of customers for marketing purpose. 

select * from customer;

select first_name, last_name, email 
from customer;

-- unique movie ratings

select distinct rating
from film;

select distinct rental_duration
from film;

-- Could you pull all payments from our first 100 customers (based on customer ID)

select *
from payment;

select customer_id, rental_id, amount, payment_date
from payment
where customer_id <=100;

-- Now I would love to see just payments over $5 for those same customers, since January 1,2006

select customer_id, rental_id, amount, payment_date
from payment
where customer_id<=100 and amount>5 and payment_date >= '2006-01-01';

select customer_id, rental_id, amount, payment_date
from payment
where amount > 5 and customer_id in [42,53,60,75];

select customer_id, rental_id, amount, payment_date
from payment
where amount > 5 and customer_id in (42,53,60,75);

select * from film;

select title, special_features
from film
where special_features like "%Behind the Scenes%";

select * 
from film;

select rating, count(film_id) as 'Number of films'
from film
group by rating;

select *
from film;

select rental_duration, count(film_id) as 'No of films'
from film
group by rental_duration;

select rating,rental_duration, count(film_id) as 'No of films'
from film
group by rating,rental_duration;

-- Rating, count_movies, length of movies and compare with rental duration

select * from film;

select rating, count(film_id) as ' Number of films ' ,min(length) as 'Shortest film', max(length) as 'Longest film', avg(length) as 'AverageLength_Film',
       avg(rental_duration) as avg_rental_duration
from film
group by rating;

select replacement_cost, count(film_id) as Number_of_Films, min(rental_rate) as cheapest_rental, max(rental_rate) as expensive_rental, avg(rental_rate) as average_rental
from film
group by replacement_cost
order by replacement_cost;

select * from customer;

select * from film;

select * from rental;  

select customer_id, count(customer_id) as 'Total rentals'
from rental
group by customer_id
having count(customer_id)<15;

select * from rental;

select * from customer;

select * from film;

select title,length, rental_rate
from film
order by length desc
limit 20;

select title,length, 
	case
       when length < 60 then 'UNDER 1 HR'
       when length between 60 and 90 then '1 to 1.5 hrs'
       when length > 90 then ' OVER 1.5 hrs'
       else 'error'
	end as length_bucket
from film;      

select distinct title,
      case 
          when rental_duration <= 4 then 'RENTAL TOO SHORT'
          WHEN RENTAL_RATE >= 3.99 THEN 'TOO EXPENSIVE'
          WHEN RATING IN ('NC-17','R') THEN 'TOO ADULT'
          WHEN LENGTH NOT BETWEEN 60 AND 90 THEN 'TOO SHORT OR TOO LONG'
          WHEN DESCRIPTION LIKE '%Shark%' THEN 'HAS SHARKS'
          ELSE 'GREAT RECOMMENDATION FOR CHILDREN'
		END AS FIT_FOR_RECOMMENDATION
	FROM FILM;
    
SELECT * FROM CUSTOMER;

SELECT STORE_ID, COUNT(ACTIVITY.STORE_ACTIVE_OR_NOT)
FROM (SELECT FIRST_NAME, LAST_NAME ,STORE_ID,
  CASE 
   WHEN ACTIVE=1 AND STORE_ID =1 THEN 'STORE 1 ACTIVE'
   WHEN ACTIVE=0 AND STORE_ID=1 THEN 'STORE 1 INACTIVE'
   WHEN ACTIVE=1 AND STORE_ID=2 THEN 'STORE 2 ACTIVE'
   WHEN ACTIVE=0 AND STORE_ID=2 THEN 'STORE 2 INACTIVE'
   END AS STORE_ACTIVE_OR_NOT
FROM CUSTOMER) AS ACTIVITY
GROUP BY ACTIVITY.STORE_ID, ACTIVITY.STORE_ACTIVE_OR_NOT;

SELECT * FROM INVENTORY;

SELECT * FROM FILM;

SELECT DISTINCT INVENTORY.INVENTORY_ID, INVENTORY.STORE_ID, FILM.TITLE, FILM.DESCRIPTION
FROM FILM INNER JOIN INVENTORY ON FILM.FILM_ID=INVENTORY.FILM_ID;

-- How many times each movie has been rented out?

select * from rental;

select * from inventory;

select * from film;

select f.title, count(r.rental_id) as 'No of rentals(Popularity)'
 from rental as r left join inventory as i 
                on r.inventory_id=i.inventory_id
                left join film as f
                on i.film_id=f.film_id
group by f.title
order by count(r.rental_id) desc ;

-- Revenue per film (Top 10 grossers)

select rental_id_transactions.title, sum(p.amount) as gross_revenue
 from  (select r.rental_id, f.film_id , f.title
         from rental as r left join inventory as i 
                on r.inventory_id=i.inventory_id
                left join film as f
                on i.film_id=f.film_id) as rental_id_transactions
                left join payment as p
                on rental_id_transactions.rental_id = p.rental_id
                group by rental_id_transactions.title
                order by gross_revenue desc
                limit 10;
                
-- Most spending customer so that we can send him/her rewards or debate points.

select * from customer;

select * from film;

select * from inventory;

select * from payment;

select  c.customer_id, c.first_name, c.last_name,sum(amount) as spending from payment p left join customer c
on p.customer_id = c.customer_id
group by p.customer_id
order by sum(amount) desc
limit 1;

-- Which store has historically brought the most revenue?

select * from store;

select * from staff;

select * from payment;

select st.store_id, sum(p.amount) as Store_Revenue
from payment as p left join staff as st
             on p.staff_id=st.staff_id
             group by st.store_id
             order by Store_Revenue desc
             limit 1;
             
             
-- How many rentals we have for each month?

select * from rental;

select * , monthname(rental_date) as month_name
from rental;

select  monthname(rental_date) as month_name, extract(year from rental_date) as year_number, count(rental_id)
from rental
group by  extract(year from rental_date),  monthname(rental_date)
order by count(rental_id) desc;

-- THIS IS A DATA ANALYSIS PROJECT FOR A MOVIES RENTAL BUSINESS
-- THE STEPS INVOLVED ARE EDA, UNDERSTANDING THE SCHEMA AND ANSWERING AD-HOC QUESTIONS
-- BUSINESS QUESTIONS LIKE EXPANDING MOVIES COLLECTION AND FETCHING EMAIL IDS FOR MARKETING ALSO INCLUDED
-- HELPING COMPANY KEEP A TRACK OF INVENTORY AND MANAGE IT

USE MAVENMOVIES;

-- EXPLORATORY DATA ANALYSIS--
-- UNDERSTANDING THE SCHEMA--

SELECT* FROM RENTAL;

SELECT CUSTOMER_ID, RENTAL_DATE
FROM RENTAL;

SELECT* FROM INVENTORY;

SELECT* FROM FILM;

SELECT* FROM CUSTOMER;

-- you need to provide the customer firstname, lastnane and email-id to the marketing team --

SELECT first_name, last_name, email
FROM CUSTOMER;

-- how many movies are with rental rate of 0.99$?--
SELECT COUNT(*) AS CHEAPEST_RENTALS
FROM FILM
WHERE RENTAL_RATE = 0.99;

-- we want to see rental rate and how many movies are in each rental rate categories --

SELECT RENTAL_RATE,COUNT(*) AS TOTAL_NO_OF_MOVIES
FROM FILM 
GROUP BY RENTAL_RATE;

-- which rating do we have most films in? --
SELECT RATING,COUNT(*) AS RATING_WISE_COUNT
FROM FILM 
GROUP BY RATING
ORDER BY RATING_WISE_COUNT DESC;

SELECT RATING,COUNT(*) 
FROM FILM 
GROUP BY RATING
ORDER BY RATING_WISE_COUNT DESC
LIMIT 1;

-- which rating is most prevalent in each store? --

SELECT I.STORE_ID,F.RATING,COUNT(F.RATING) AS TOTAL_FILMS
FROM INVENTORY AS I LEFT JOIN
     FILM AS F ON I.FILM_ID = F.FILM_ID
GROUP BY I.STORE_ID,F.RATING
ORDER BY TOTAL_FILMS DESC;

-- list of films by film name, category, language --
SELECT  F.TITLE,LANG.NAME AS LANGUAGE_NAME,C.NAME AS CATEGORY_NAME
FROM FILM AS F LEFT JOIN LANGUAGE AS LANG
ON F.LANGUAGE_ID = LANG.LANGUAGE_ID
          LEFT JOIN FILM_CATEGORY AS FC
ON F.FILM_ID = FC.FILM_ID
          LEFT JOIN CATEGORY AS C
ON FC.CATEGORY_ID = C.CATEGORY_ID;-- THIS IS A DATA ANALYSIS PROJECT FOR A MOVIES RENTAL BUSINESS
-- THE STEPS INVOLVED ARE EDA, UNDERSTANDING THE SCHEMA AND ANSWERING AD-HOC QUESTIONS
-- BUSINESS QUESTIONS LIKE EXPANDING MOVIES COLLECTION AND FETCHING EMAIL IDS FOR MARKETING ALSO INCLUDED
-- HELPING COMPANY KEEP A TRACK OF INVENTORY AND MANAGE IT

USE MAVENMOVIES;

-- EXPLORATORY DATA ANALYSIS--
-- UNDERSTANDING THE SCHEMA--

SELECT* FROM RENTAL;

SELECT CUSTOMER_ID, RENTAL_DATE
FROM RENTAL;

SELECT* FROM INVENTORY;

SELECT* FROM FILM;

SELECT* FROM CUSTOMER;

-- you need to provide the customer firstname, lastnane and email-id to the marketing team --

SELECT first_name, last_name, email
FROM CUSTOMER;

-- how many movies are with rental rate of 0.99$?--
SELECT COUNT(*) AS CHEAPEST_RENTALS
FROM FILM
WHERE RENTAL_RATE = 0.99;

-- we want to see rental rate and how many movies are in each rental rate categories --

SELECT RENTAL_RATE,COUNT(*) AS TOTAL_NO_OF_MOVIES
FROM FILM 
GROUP BY RENTAL_RATE;

-- which rating do we have most films in? --
SELECT RATING,COUNT(*) AS RATING_WISE_COUNT
FROM FILM 
GROUP BY RATING
ORDER BY RATING_WISE_COUNT DESC;

SELECT RATING,COUNT(*) 
FROM FILM 
GROUP BY RATING
ORDER BY RATING_WISE_COUNT DESC
LIMIT 1;

-- which rating is most prevalent in each store? --

SELECT I.STORE_ID,F.RATING,COUNT(F.RATING) AS TOTAL_FILMS
FROM INVENTORY AS I LEFT JOIN
     FILM AS F ON I.FILM_ID = F.FILM_ID
GROUP BY I.STORE_ID,F.RATING
ORDER BY TOTAL_FILMS DESC;

-- list of films by film name, category, language --
SELECT  F.TITLE,LANG.NAME AS LANGUAGE_NAME,C.NAME AS CATEGORY_NAME
FROM FILM AS F LEFT JOIN LANGUAGE AS LANG
ON F.LANGUAGE_ID = LANG.LANGUAGE_ID
          LEFT JOIN FILM_CATEGORY AS FC
ON F.FILM_ID = FC.FILM_ID
          LEFT JOIN CATEGORY AS C
ON FC.CATEGORY_ID = C.CATEGORY_ID;-- THIS IS A DATA ANALYSIS PROJECT FOR A MOVIES RENTAL BUSINESS
-- THE STEPS INVOLVED ARE EDA, UNDERSTANDING THE SCHEMA AND ANSWERING AD-HOC QUESTIONS
-- BUSINESS QUESTIONS LIKE EXPANDING MOVIES COLLECTION AND FETCHING EMAIL IDS FOR MARKETING ALSO INCLUDED
-- HELPING COMPANY KEEP A TRACK OF INVENTORY AND MANAGE IT

USE MAVENMOVIES;

-- EXPLORATORY DATA ANALYSIS--
-- UNDERSTANDING THE SCHEMA--

SELECT* FROM RENTAL;

SELECT CUSTOMER_ID, RENTAL_DATE
FROM RENTAL;

SELECT* FROM INVENTORY;

SELECT* FROM FILM;

SELECT* FROM CUSTOMER;

-- you need to provide the customer firstname, lastnane and email-id to the marketing team --

SELECT first_name, last_name, email
FROM CUSTOMER;

-- how many movies are with rental rate of 0.99$?--
SELECT COUNT(*) AS CHEAPEST_RENTALS
FROM FILM
WHERE RENTAL_RATE = 0.99;

-- we want to see rental rate and how many movies are in each rental rate categories --

SELECT RENTAL_RATE,COUNT(*) AS TOTAL_NO_OF_MOVIES
FROM FILM 
GROUP BY RENTAL_RATE;

-- which rating do we have most films in? --
SELECT RATING,COUNT(*) AS RATING_WISE_COUNT
FROM FILM 
GROUP BY RATING
ORDER BY RATING_WISE_COUNT DESC;

SELECT RATING,COUNT(*) 
FROM FILM 
GROUP BY RATING
ORDER BY RATING_WISE_COUNT DESC
LIMIT 1;

-- which rating is most prevalent in each store? --

SELECT I.STORE_ID,F.RATING,COUNT(F.RATING) AS TOTAL_FILMS
FROM INVENTORY AS I LEFT JOIN
     FILM AS F ON I.FILM_ID = F.FILM_ID
GROUP BY I.STORE_ID,F.RATING
ORDER BY TOTAL_FILMS DESC;

-- list of films by film name, category, language --
SELECT  F.TITLE,LANG.NAME AS LANGUAGE_NAME,C.NAME AS CATEGORY_NAME
FROM FILM AS F LEFT JOIN LANGUAGE AS LANG
ON F.LANGUAGE_ID = LANG.LANGUAGE_ID
          LEFT JOIN FILM_CATEGORY AS FC
ON F.FILM_ID = FC.FILM_ID
          LEFT JOIN CATEGORY AS C
ON FC.CATEGORY_ID = C.CATEGORY_ID;-- THIS IS A DATA ANALYSIS PROJECT FOR A MOVIES RENTAL BUSINESS
-- THE STEPS INVOLVED ARE EDA, UNDERSTANDING THE SCHEMA AND ANSWERING AD-HOC QUESTIONS
-- BUSINESS QUESTIONS LIKE EXPANDING MOVIES COLLECTION AND FETCHING EMAIL IDS FOR MARKETING ALSO INCLUDED
-- HELPING COMPANY KEEP A TRACK OF INVENTORY AND MANAGE IT

USE MAVENMOVIES;

-- EXPLORATORY DATA ANALYSIS--
-- UNDERSTANDING THE SCHEMA--

SELECT* FROM RENTAL;

SELECT CUSTOMER_ID, RENTAL_DATE
FROM RENTAL;

SELECT* FROM INVENTORY;

SELECT* FROM FILM;

SELECT* FROM CUSTOMER;

-- you need to provide the customer firstname, lastnane and email-id to the marketing team --

SELECT first_name, last_name, email
FROM CUSTOMER;

-- how many movies are with rental rate of 0.99$?--
SELECT COUNT(*) AS CHEAPEST_RENTALS
FROM FILM
WHERE RENTAL_RATE = 0.99;

-- we want to see rental rate and how many movies are in each rental rate categories --

SELECT RENTAL_RATE,COUNT(*) AS TOTAL_NO_OF_MOVIES
FROM FILM 
GROUP BY RENTAL_RATE;

-- which rating do we have most films in? --
SELECT RATING,COUNT(*) AS RATING_WISE_COUNT
FROM FILM 
GROUP BY RATING
ORDER BY RATING_WISE_COUNT DESC;

SELECT RATING,COUNT(*) 
FROM FILM 
GROUP BY RATING
ORDER BY RATING_WISE_COUNT DESC
LIMIT 1;

-- which rating is most prevalent in each store? --

SELECT I.STORE_ID,F.RATING,COUNT(F.RATING) AS TOTAL_FILMS
FROM INVENTORY AS I LEFT JOIN
     FILM AS F ON I.FILM_ID = F.FILM_ID
GROUP BY I.STORE_ID,F.RATING
ORDER BY TOTAL_FILMS DESC;

-- list of films by film name, category, language --
SELECT  F.TITLE,LANG.NAME AS LANGUAGE_NAME,C.NAME AS CATEGORY_NAME
FROM FILM AS F LEFT JOIN LANGUAGE AS LANG
ON F.LANGUAGE_ID = LANG.LANGUAGE_ID
          LEFT JOIN FILM_CATEGORY AS FC
ON F.FILM_ID = FC.FILM_ID
          LEFT JOIN CATEGORY AS C
ON FC.CATEGORY_ID = C.CATEGORY_ID;-- THIS IS A DATA ANALYSIS PROJECT FOR A MOVIES RENTAL BUSINESS
-- THE STEPS INVOLVED ARE EDA, UNDERSTANDING THE SCHEMA AND ANSWERING AD-HOC QUESTIONS
-- BUSINESS QUESTIONS LIKE EXPANDING MOVIES COLLECTION AND FETCHING EMAIL IDS FOR MARKETING ALSO INCLUDED
-- HELPING COMPANY KEEP A TRACK OF INVENTORY AND MANAGE IT

USE MAVENMOVIES;

-- EXPLORATORY DATA ANALYSIS--
-- UNDERSTANDING THE SCHEMA--

SELECT* FROM RENTAL;

SELECT CUSTOMER_ID, RENTAL_DATE
FROM RENTAL;

SELECT* FROM INVENTORY;

SELECT* FROM FILM;

SELECT* FROM CUSTOMER;

-- you need to provide the customer firstname, lastnane and email-id to the marketing team --

SELECT first_name, last_name, email
FROM CUSTOMER;

-- how many movies are with rental rate of 0.99$?--
SELECT COUNT(*) AS CHEAPEST_RENTALS
FROM FILM
WHERE RENTAL_RATE = 0.99;

-- we want to see rental rate and how many movies are in each rental rate categories --

SELECT RENTAL_RATE,COUNT(*) AS TOTAL_NO_OF_MOVIES
FROM FILM 
GROUP BY RENTAL_RATE;

-- which rating do we have most films in? --
SELECT RATING,COUNT(*) AS RATING_WISE_COUNT
FROM FILM 
GROUP BY RATING
ORDER BY RATING_WISE_COUNT DESC;

SELECT RATING,COUNT(*) 
FROM FILM 
GROUP BY RATING
ORDER BY RATING_WISE_COUNT DESC
LIMIT 1;

-- which rating is most prevalent in each store? --

SELECT I.STORE_ID,F.RATING,COUNT(F.RATING) AS TOTAL_FILMS
FROM INVENTORY AS I LEFT JOIN
     FILM AS F ON I.FILM_ID = F.FILM_ID
GROUP BY I.STORE_ID,F.RATING
ORDER BY TOTAL_FILMS DESC;

-- list of films by film name, category, language --
SELECT  F.TITLE,LANG.NAME AS LANGUAGE_NAME,C.NAME AS CATEGORY_NAME
FROM FILM AS F LEFT JOIN LANGUAGE AS LANG
ON F.LANGUAGE_ID = LANG.LANGUAGE_ID
          LEFT JOIN FILM_CATEGORY AS FC
ON F.FILM_ID = FC.FILM_ID
          LEFT JOIN CATEGORY AS C
ON FC.CATEGORY_ID = C.CATEGORY_ID;-- THIS IS A DATA ANALYSIS PROJECT FOR A MOVIES RENTAL BUSINESS
-- THE STEPS INVOLVED ARE EDA, UNDERSTANDING THE SCHEMA AND ANSWERING AD-HOC QUESTIONS
-- BUSINESS QUESTIONS LIKE EXPANDING MOVIES COLLECTION AND FETCHING EMAIL IDS FOR MARKETING ALSO INCLUDED
-- HELPING COMPANY KEEP A TRACK OF INVENTORY AND MANAGE IT

USE MAVENMOVIES;

-- EXPLORATORY DATA ANALYSIS--
-- UNDERSTANDING THE SCHEMA--

SELECT* FROM RENTAL;

SELECT CUSTOMER_ID, RENTAL_DATE
FROM RENTAL;

SELECT* FROM INVENTORY;

SELECT* FROM FILM;

SELECT* FROM CUSTOMER;

-- you need to provide the customer firstname, lastnane and email-id to the marketing team --

SELECT first_name, last_name, email
FROM CUSTOMER;

-- how many movies are with rental rate of 0.99$?--
SELECT COUNT(*) AS CHEAPEST_RENTALS
FROM FILM
WHERE RENTAL_RATE = 0.99;

-- we want to see rental rate and how many movies are in each rental rate categories --

SELECT RENTAL_RATE,COUNT(*) AS TOTAL_NO_OF_MOVIES
FROM FILM 
GROUP BY RENTAL_RATE;

-- which rating do we have most films in? --
SELECT RATING,COUNT(*) AS RATING_WISE_COUNT
FROM FILM 
GROUP BY RATING
ORDER BY RATING_WISE_COUNT DESC;

SELECT RATING,COUNT(*) 
FROM FILM 
GROUP BY RATING
ORDER BY RATING_WISE_COUNT DESC
LIMIT 1;

-- which rating is most prevalent in each store? --

SELECT I.STORE_ID,F.RATING,COUNT(F.RATING) AS TOTAL_FILMS
FROM INVENTORY AS I LEFT JOIN
     FILM AS F ON I.FILM_ID = F.FILM_ID
GROUP BY I.STORE_ID,F.RATING
ORDER BY TOTAL_FILMS DESC;

-- list of films by film name, category, language --
SELECT  F.TITLE,LANG.NAME AS LANGUAGE_NAME,C.NAME AS CATEGORY_NAME
FROM FILM AS F LEFT JOIN LANGUAGE AS LANG
ON F.LANGUAGE_ID = LANG.LANGUAGE_ID
          LEFT JOIN FILM_CATEGORY AS FC
ON F.FILM_ID = FC.FILM_ID
          LEFT JOIN CATEGORY AS C
ON FC.CATEGORY_ID = C.CATEGORY_ID;-- THIS IS A DATA ANALYSIS PROJECT FOR A MOVIES RENTAL BUSINESS
-- THE STEPS INVOLVED ARE EDA, UNDERSTANDING THE SCHEMA AND ANSWERING AD-HOC QUESTIONS
-- BUSINESS QUESTIONS LIKE EXPANDING MOVIES COLLECTION AND FETCHING EMAIL IDS FOR MARKETING ALSO INCLUDED
-- HELPING COMPANY KEEP A TRACK OF INVENTORY AND MANAGE IT

USE MAVENMOVIES;

-- EXPLORATORY DATA ANALYSIS--
-- UNDERSTANDING THE SCHEMA--

SELECT* FROM RENTAL;

SELECT CUSTOMER_ID, RENTAL_DATE
FROM RENTAL;

SELECT* FROM INVENTORY;

SELECT* FROM FILM;

SELECT* FROM CUSTOMER;

-- you need to provide the customer firstname, lastnane and email-id to the marketing team --

SELECT first_name, last_name, email
FROM CUSTOMER;

-- how many movies are with rental rate of 0.99$?--
SELECT COUNT(*) AS CHEAPEST_RENTALS
FROM FILM
WHERE RENTAL_RATE = 0.99;

-- we want to see rental rate and how many movies are in each rental rate categories --

SELECT RENTAL_RATE,COUNT(*) AS TOTAL_NO_OF_MOVIES
FROM FILM 
GROUP BY RENTAL_RATE;

-- which rating do we have most films in? --
SELECT RATING,COUNT(*) AS RATING_WISE_COUNT
FROM FILM 
GROUP BY RATING
ORDER BY RATING_WISE_COUNT DESC;

SELECT RATING,COUNT(*) 
FROM FILM 
GROUP BY RATING
ORDER BY RATING_WISE_COUNT DESC
LIMIT 1;

-- which rating is most prevalent in each store? --

SELECT I.STORE_ID,F.RATING,COUNT(F.RATING) AS TOTAL_FILMS
FROM INVENTORY AS I LEFT JOIN
     FILM AS F ON I.FILM_ID = F.FILM_ID
GROUP BY I.STORE_ID,F.RATING
ORDER BY TOTAL_FILMS DESC;

-- list of films by film name, category, language --
SELECT  F.TITLE,LANG.NAME AS LANGUAGE_NAME,C.NAME AS CATEGORY_NAME
FROM FILM AS F LEFT JOIN LANGUAGE AS LANG
ON F.LANGUAGE_ID = LANG.LANGUAGE_ID
          LEFT JOIN FILM_CATEGORY AS FC
ON F.FILM_ID = FC.FILM_ID
          LEFT JOIN CATEGORY AS C
ON FC.CATEGORY_ID = C.CATEGORY_ID;-- THIS IS A DATA ANALYSIS PROJECT FOR A MOVIES RENTAL BUSINESS
-- THE STEPS INVOLVED ARE EDA, UNDERSTANDING THE SCHEMA AND ANSWERING AD-HOC QUESTIONS
-- BUSINESS QUESTIONS LIKE EXPANDING MOVIES COLLECTION AND FETCHING EMAIL IDS FOR MARKETING ALSO INCLUDED
-- HELPING COMPANY KEEP A TRACK OF INVENTORY AND MANAGE IT

USE MAVENMOVIES;

-- EXPLORATORY DATA ANALYSIS--
-- UNDERSTANDING THE SCHEMA--

SELECT* FROM RENTAL;

SELECT CUSTOMER_ID, RENTAL_DATE
FROM RENTAL;

SELECT* FROM INVENTORY;

SELECT* FROM FILM;

SELECT* FROM CUSTOMER;

-- you need to provide the customer firstname, lastnane and email-id to the marketing team --

SELECT first_name, last_name, email
FROM CUSTOMER;

-- how many movies are with rental rate of 0.99$?--
SELECT COUNT(*) AS CHEAPEST_RENTALS
FROM FILM
WHERE RENTAL_RATE = 0.99;

-- we want to see rental rate and how many movies are in each rental rate categories --

SELECT RENTAL_RATE,COUNT(*) AS TOTAL_NO_OF_MOVIES
FROM FILM 
GROUP BY RENTAL_RATE;

-- which rating do we have most films in? --
SELECT RATING,COUNT(*) AS RATING_WISE_COUNT
FROM FILM 
GROUP BY RATING
ORDER BY RATING_WISE_COUNT DESC;

SELECT RATING,COUNT(*) 
FROM FILM 
GROUP BY RATING
ORDER BY RATING_WISE_COUNT DESC
LIMIT 1;

-- which rating is most prevalent in each store? --

SELECT I.STORE_ID,F.RATING,COUNT(F.RATING) AS TOTAL_FILMS
FROM INVENTORY AS I LEFT JOIN
     FILM AS F ON I.FILM_ID = F.FILM_ID
GROUP BY I.STORE_ID,F.RATING
ORDER BY TOTAL_FILMS DESC;

-- list of films by film name, category, language --
SELECT  F.TITLE,LANG.NAME AS LANGUAGE_NAME,C.NAME AS CATEGORY_NAME
FROM FILM AS F LEFT JOIN LANGUAGE AS LANG
ON F.LANGUAGE_ID = LANG.LANGUAGE_ID
          LEFT JOIN FILM_CATEGORY AS FC
ON F.FILM_ID = FC.FILM_ID
          LEFT JOIN CATEGORY AS C
ON FC.CATEGORY_ID = C.CATEGORY_ID;



-- Reward users who have rented at least 30 times

use mavenmovies;

select *
from rental;

select * from customer;

select customer_id,count(rental_id) as Rentals
from rental
group by customer_id
having Rentals>=30;

-- Reward users who have rented at least 30 times (with details of customers)

select * from customer;

select c.customer_id, c.first_name, c.last_name, c.email
from customer c join (select customer_id,count(rental_id) as Rentals
from rental
group by customer_id
having Rentals>=30) as LoyalCustomers
where c.customer_id = LoyalCustomers.customer_id;


select c.customer_id, c.first_name, c.last_name, c.email
from customer c join (select customer_id,count(rental_id) as Rentals
from rental
group by customer_id
having Rentals>=30) as LoyalCustomers
where c.customer_id = LoyalCustomers.customer_id;

SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    c.email, 
    a.phone
FROM 
    customer c
JOIN 
    (SELECT 
         customer_id, 
         COUNT(rental_id) AS Rentals
     FROM 
         rental
     GROUP BY 
         customer_id
     HAVING 
         COUNT(rental_id) >= 30) AS LoyalCustomers
ON 
    c.customer_id = LoyalCustomers.customer_id
JOIN 
    address a
ON 
    c.address_id = a.address_id;









































