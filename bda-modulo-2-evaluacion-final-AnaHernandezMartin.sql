USE sakila;


/* EJERC. 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados. */

SELECT DISTINCT title AS NombresPreliculas  -- El `DISTINCT`evita los duplicados
	FROM film;
    
    
/* EJERC. 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13". */

SELECT title AS NombresPeliculas
	FROM film
    WHERE rating = 'PG-13';  -- con la condicion que la clasificación sea 'PG-13'
    
    
/* EJERC. 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción. */

SELECT title, `description`
	FROM film
    WHERE `description`LIKE '% Amazing%';  -- filtra los resultados que en la descripción tenda 'Amazing'
    
    
/* EJERC. 4.  Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos. */

SELECT title
	FROM film
	WHERE `length`> 120;  -- con la condición que las pelis duren más de 120 minutos
    
    
/* EJERC. 5. Recupera los nombres de todos los actores. */

SELECT first_name AS NombreActores
	FROM actor;
    
    
/* EJERC. 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido. */

SELECT first_name, last_name
	FROM actor
    WHERE last_name = 'Gibson';  -- condición que solo tengan en apellido 'Gibson'
    
    
/* EJERC. 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20. */

SELECT first_name 
	FROM actor
    WHERE actor_id BETWEEN 10 AND 20;  -- condición de que tengan un ID entre 10 y 20
    
    
/* EJERC. 8.  Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación. */

SELECT title, rating
	FROM film
	WHERE rating != 'R' AND rating != 'PG-13';   -- condición de los titulos que no tengan 'R' ni 'PG-13' en su clasificación
    
    
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
																			
SELECT category.`name`, COUNT(rental.rental_id) AS TotalPeliculasAlquiladas  -- contar las pelis alquiladas
	FROM category
    JOIN film_category ON category.category_id = film_category.category_id -- relaciona las categorias con las pelis
    JOIN film ON film_category.film_id = film.film_id -- relaciona las pelis con sus categorias
    JOIN inventory ON film.film_id = inventory.film_id -- se tiene que pasar por inventory para relacionar los alquileres 
    JOIN rental ON inventory.inventory_id = rental.inventory_id -- de esta manera los alquileres quedan relacionados
	GROUP BY category.`name`;  -- agrupación por el nombre de la categoria
    
    
/* EJERC. 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la
 clasificación junto con el promedio de duración. */

SELECT rating AS Clasificacion, AVG(`length`) AS PromedioDuracion  -- se selecciona lo que hay que buscar
	FROM film
    GROUP BY rating;  -- se agrupa por clasificación
    
    
/* EJERC. 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love". */

SELECT actor.first_name, actor.last_name, film.title
	FROM actor                                              -- con el JOIN ON porque las columnas se llaman igual
    JOIN film_actor ON actor.actor_id = film_actor.actor_id -- se unen para buscar los actores en una pelicula
    JOIN film ON film_actor.film_id = film.film_id          -- se unen para obtener el titulo de la pelicula correspondiente
    WHERE film.title = 'Indian Love';


/* EJERC. 14.  Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción. */

SELECT title AS peliculas, `description`
	FROM film 
    WHERE `description`LIKE '%dog%' OR `description`LIKE '%cat%'; -- %---% no importa su posicion en la descripcion
    
    
/* EEJERC. 15. Hay algún actor o actriz que no aparezca en ninguna película en la tabla film_actor. */

SELECT actor.actor_id, actor.first_name, actor.last_name
	FROM actor
    JOIN film_actor ON actor.actor_id = film_actor.actor_id  -- se relacionan el actor y las pelis en las que aparece
    WHERE film_actor.film_id IS NULL;  
    
    
/* EJERC. 16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010. */

SELECT title AS Pelicula
	FROM film
	WHERE release_year BETWEEN 2005 AND 2010;  -- condición de pelis lanzadas entre los años 2005 y 2010
    
    
/* EJERC. 17. Encuentra el título de todas las películas que son de la misma categoría que "Family" */

SELECT title AS TituloPeliculas
	FROM film
    JOIN film_category ON film.film_id = film_category.film_id  -- asocia a las peliculas con sus categorias
    JOIN category ON film_category.category_id = category.category_id -- se obtiene la categoria correspondiente de cada pelicula
    WHERE category.`name` = 'Family';  -- condición
    
    
/* EJERC. 18.  Muestra el nombre y apellido de los actores que aparecen en más de 10 películas. */

SELECT first_name AS Nombre, last_name AS Apellido
	FROM actor
    JOIN film_actor ON actor.actor_id = film_actor.actor_id -- asociar a los actores con las pelis en las que han salido
    GROUP BY actor.actor_id
		HAVING COUNT(film_actor.film_id) > 10; -- la condicion del `GROUP BY`
        
        
/* EJERC. 19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film. */
    
SELECT title AS Peliculas
	FROM film
    WHERE rating = 'R' AND `length` > 120;  -- condición
    
    
/* EJERC. 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el
 nombre de la categoría junto con el promedio de duración. */

SELECT category.`name`AS categoria, AVG(film.`length`) AS DuracionPromedio -- calcular el promedio
	FROM category
    JOIN film_category ON category.category_id = film_category.category_id -- relacion de las categorias con las pelis
    JOIN film ON film_category.film_id = film.film_id   -- se obtiene la duracion de las pelis
	GROUP BY category.`name` -- se agrupa por el nombre de las categorias
		HAVING DuracionPromedio > 120; -- condicion del `GROUP BY` mayor a 120 minutos
        
        
/* EJERC. 21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la
 cantidad de películas en las que han actuado. */
 
SELECT first_name, last_name, COUNT(film_actor.film_id) AS CantidadPeliculas
	FROM actor
    JOIN film_actor ON actor.actor_id = film_actor.actor_id -- relacion entre actores y pelis donde hayan actuado
    GROUP BY actor.actor_id             -- resultados agrupados por el id del actor y cuenta las pelis que ha hecho cada uno
		HAVING CantidadPeliculas >= 5;  -- condicion del `GROUP BY` que las pelis sean mas de 5
        
        
/* EJERC. 22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una subconsulta para
 encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes. */ 
 
 SELECT title AS Peliculas   -- seleccionamos titulo
	FROM film
    WHERE film.film_id IN (   -- empieza la subconsulta para obtener las pelis que cumplan la condicion 
		SELECT rental_id
			FROM rental
            WHERE DATEDIFF(rental.return_date, rental.rental_date) > 5);   -- calcula la diferencia 
            
            
/* EJERC. 23.  Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror".
 Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego
 exclúyelos de la lista de actores. */
 
SELECT first_name AS Nombre, last_name AS Apellido
	FROM actor
    WHERE actor.actor_id NOT IN (  -- inicio de la subconsulta para obtener los actores que no están 
		SELECT actor_id
			FROM film_actor
            JOIN film ON film_actor.film_id = film.film_id   -- se obtiene info sobre las pelis
			JOIN film_category ON film.film_id = film_category.film_id  -- asocia a las peliculas con sus categorias
			JOIN category ON film_category.category_id = category.category_id -- se obtiene la categoria correspondiente de cada pelicula
			WHERE category.`name` = 'Horror');  
            

-- BONUS
            
/* EJERC. 24. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la
 tabla film. */
 
SELECT title AS PeliculasComedia
	FROM film
    JOIN film_category ON film.film_id = film_category.film_id   -- asocia a las peliculas con sus categorias
    JOIN category ON film_category.category_id = category.category_id   -- se obtiene la categoria correspondiente de cada pelicula
    WHERE category.`name` = 'Comedy' AND  film.`length` > 180;
    
    
/* EJERC. 25.  Encuentra todos los actores que han actuado juntos en al menos una película. La consulta debe
 mostrar el nombre y apellido de los actores y el número de películas en las que han actuado juntos. */
 
 SELECT actor.first_name AS Nombre, actor.last_name AS Apellido, COUNT(film_actor.film_id) AS NumeroPelisJuntXs
	FROM actor
    JOIN film_actor ON film.film_id = film_actor.film_id  -- se relacionan las peliculad con los actores que ha  actuado en ellas
    JOIN actor ON film_actor.actor_id = actor.actor_id  -- se obtiene información de los actores
    WHERE actor.actor_id != actor.actor_id
    GROUP BY actor_id
		HAVING NumeroPelisJuntXs >= 1;    
        

        







    