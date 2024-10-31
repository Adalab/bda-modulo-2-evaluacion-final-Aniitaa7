USE sakila;


-- EJERC. 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.

SELECT DISTINCT title AS NombresPreliculas
	FROM film;
    
    
-- EJERC. 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13"

SELECT title AS NombresPeliculas
	FROM film
    WHERE rating = 'PG-13';
    
    
-- EJERC. 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.

SELECT title, `description`
	FROM film
    WHERE `description`LIKE '% Amazing%';
    
    
-- EJERC. 4.  Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.

SELECT title
	FROM film
	WHERE `length`> 120;
    
    
-- EJERC. 5. Recupera los nombres de todos los actores

SELECT first_name AS NombreActores
	FROM actor;
    
    
-- EJERC. 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.

SELECT first_name, last_name
	FROM actor
    WHERE last_name = 'Gibson';
    
    
-- EJERC. 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.

SELECT first_name 
	FROM actor
    WHERE actor_id BETWEEN 10 AND 20;
    
    
-- EJERC. 8.  Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación.

SELECT title, rating
	FROM film
	WHERE rating != 'R' AND rating != 'PG-13';
    
    
/* EJERC. 9.  Encuentra la cantidad total de películas en cada clasificación de la tabla film y 
muestra la clasificación junto con el recuento. */

SELECT rating, COUNT(*) AS total_peliculas     /* La suma total de las peliculas por categoría 
	FROM film									es igual a 1000*/
	GROUP BY rating;
    
    
/* EJERC. 10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y
 apellido junto con la cantidad de películas alquiladas.*/
    
SELECT customer.customer_id, customer.first_name, customer.last_name, COUNT(rental.rental_id) AS TotalPeliculasAlquiladas
	FROM customer 
	LEFT JOIN rental  ON customer.customer_id = rental.customer_id    
	GROUP BY customer.customer_id, customer.first_name, customer.last_name        
    ORDER BY customer_id ASC;                               /* LEFT JOIN --> Union a la izq con la tabla de `rental`
																en función del `customer_id`*/ 
                                                                
                                                                
/* EJERC. 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el
 recuento de alquileres. */
																			
SELECT category.`name`, COUNT(rental.rental_id) AS TotalPeliculasAlquiladas
	FROM category
    LEFT JOIN film_category ON category.category_id = film_category.category_id
     GROUP BY category.`name`;




    