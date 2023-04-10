--Solution 1
SELECT rating, COUNT(*)

	FROM film

	GROUP BY rating
	HAVING COUNT(*) > 200

ORDER BY rating ASC
;
-- Solution 2
SELECT c.first_name, c.last_name
	FROM customer c

INNER JOIN payment p ON p.customer_id = c.customer_id

	GROUP BY p.amount,c.customer_id
	HAVING p.amount > 9 and COUNT(*) > 3

--Solution 3
SELECT 
    r.customer_id,first_name, last_name
	FROM 
    	customer c INNER JOIN Rental r on r.customer_id=c.customer_id
EXCEPT 
(
    SELECT 
        customer_id, first_name, last_name 
    FROM 
        customer
)
ORDER BY
    first_name, last_name
;

--Solution 4
SELECT COUNT(title), name, rating

	FROM category c 

INNER JOIN film_category fc ON fc.category_id = c.category_id

INNER JOIN film f ON f.film_id = fc.film_id

GROUP BY
    GROUPING SETS(
    (name,rating),
    (name),
    (rating),
    ()
    )
    ORDER BY Name,Rating
    ;

--Solution 5
SELECT 
	customer_id, first_name, last_name
	FROM 
		customer
WHERE
	EXISTS 
	(
		SELECT 
			customer_id
			FROM 
				rental
	)
ORDER BY
	first_name, last_name
;

--Solution 6
SELECT 
	title
	FROM 
		film f, film_category fc
WHERE 
	f.film_id = fc.film_id AND rental_rate = 	
	(
		SELECT 
			MAX(rental_rate)
		FROM 
			film f, film_category fc
		WHERE 
			f.film_id = fc.film_id AND category_id = fc.category_id
	)
ORDER BY
	title
;

--Solution 7
WITH cte_length AS
(
	SELECT
		name, ROUND(AVG(length)) AS "Average Length"
		FROM
			film f
	INNER JOIN film_category fc ON	f.film_id = fc.film_id

	INNER JOIN category c ON c.category_id = fc.category_id
	GROUP BY
		name
)
SELECT 
	title, length
	FROM 
		film f
	INNER JOIN film_category fc ON f.film_id = fc.film_id

	INNER JOIN category c ON c.category_id = fc.category_id

	INNER JOIN cte_length ct ON ct.name = c.name
WHERE
	length = "Average Length"
ORDER BY
	title
;

--Solution 8
CREATE VIEW view_movie_language AS
(
    SELECT
		title, length, name
    	FROM
			film f
	INNER JOIN language l ON f.language_id = l.language_id

    ORDER BY
		title
)
;

--Solution 9
CREATE MATERIALIZED VIEW view_last_rental AS 
(
	SELECT
		first_name, last_name, MAX(rental_date) AS "Last Rental"
		FROM 
			customer c
	INNER JOIN rental r ON c.customer_id = r.customer_id

	GROUP BY
		first_name, last_name
	ORDER BY
		first_name, last_name
)
;	
