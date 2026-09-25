SELECT * FROM sakila.actor;
SELECT * FROM sakila.film;
SELECT * FROM sakila.customer;

select title
from film;

SELECT * FROM language;

select distinct name as language
from language;

select * from store;
select count(*) as numero_tiendas
from store;

SELECT * FROM sakila.staff;
select count(*) as empleados
from staff;

select first_name
from staff;

-- Seleccione todos los actores con el nombre Scarlett.
select first_name, last_name
from actor
where first_name = "scarlett";

-- Seleccione todos los actores con el apellido Johansson.
select first_name, last_name
from actor
where last_name = "Johansson";

-- ¿Cuántas películas están disponibles para alquilar?
select count(*) as peliculas_disponibles
from film;

-- ¿Cuántas películas se han alquilado?
select count(*) as peliculas_alquiladas
from rental;

-- ¿Cuál es el período de alquiler más corto y más largo?
select 
min(rental_duration) as periodo_más_corto,
max(rental_duration) as periodo_más_largo
from film;

-- ¿Cuál es la duración más corta y más larga de una película? Nombra los valores max_durationy min_duration.
SELECT
min(length) as min_duration,
max(length) as max_duration
from film;

-- ¿Cuál es la duración media de una película?
SELECT
AVG(length) AS average_duration
FROM film;

-- ¿Cuántas películas duran más de 3 horas?
SELECT COUNT(*) AS movies_over_3_hours
FROM film
WHERE length > 180;

-- Formatee el nombre y el correo electrónico. Ejemplo: Mary SMITH - mary.smith@sakilacustomer.org .
SELECT
CONCAT (first_name,' ',last_name,' - ',email) AS customer_info
FROM customer;

-- ¿Cuál es la duración del título más largo de una película?
SELECT title, length
from film
order by length(title) DESC
LIMIT 1;