--Solution 1
SELECT substr(actor.last_name,1,1) as "letter", count(*) as count
	FROM ACTOR
	Group by "letter"	
	Order by "letter" ASC;
--Solution 2
SELECT
	TO_CHAR(rental_date, 'Month') AS "Month",
	COUNT(*) AS "Count"
FROM
	rental
WHERE
	EXTRACT(YEAR FROM rental_date) = '2005'
GROUP BY
	"Month"
ORDER BY
	"Month" ASC
;
--Solution 3
SELECT
	film.film_id, title, rental_date
FROM
	film
INNER JOIN inventory ON
	film.film_id = inventory.film_id
INNER JOIN rental ON
	inventory.inventory_id = rental.inventory_id
INNER JOIN customer ON
	rental.customer_id = customer.customer_id
WHERE
	first_name = 'Carl'
ORDER BY
	title ASC
;
--Solution 4
SELECT
	MIN(amount) AS "Minimum Price", 
	MAX(amount) AS "Maximum Price", 
	ROUND(AVG(amount), 2) AS "Average Price"
FROM
	payment
;
--Solution 5
SELECT
	address, city, country
FROM
	address
INNER JOIN city ON
	address.city_id = city.city_id
INNER JOIN country ON
	city.country_id = country.country_id
ORDER BY
	country ASC
;

--Solution 6
SELECT category_id,COUNT(*)
FROM film_category
GROUP BY film_category.category_id;

--Solution 7
SELECT DISTINCT SUBSTR(postal_code,1,3) as "District"

FROM 
	address
ORDER BY
"District" ASC
;


--Solution 8 
SELECT
	store.store_id, SUM(amount) AS "Total Revenue"
FROM 
	payment
INNER JOIN rental ON
	payment.rental_id = rental.rental_id
INNER JOIN store ON
	rental.staff_id = store.store_id
GROUP BY
	store.store_id
;

--Solution 9
SELECT
	rental.customer_id, first_name, last_name
FROM  
	rental
INNER JOIN customer ON
	rental.customer_id = customer.customer_id
GROUP BY
	rental.customer_id, first_name, last_name
HAVING
	COUNT(rental.customer_id) > 40
ORDER BY
	first_name ASC
;

--Solution 10
SELECT
	title, first_name,last_name
FROM
	film
INNER JOIN inventory ON
	film.film_id = inventory.film_id
INNER JOIN rental ON
	inventory.inventory_id = rental.inventory_id
INNER JOIN customer ON
	rental.customer_id = customer.customer_id
WHERE
	first_name = 'Duane' AND
	last_name = 'Tubbs'
ORDER BY
	title ASC
;