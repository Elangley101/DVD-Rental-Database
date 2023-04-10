--Solution 1
SELECT *
FROM CUSTOMER;

--Solution 2
SELECT (last_name, first_name) as Name
    FROM actor;
--Solution 3
SELECT *
    FROM film
	WHERE title LIKE '%Love%';
--Solution 4
SELECT title,
CASE
WHEN LENGTH > 180 THEN 'EXTENDED CUT'
WHEN LENGTH < 50 THEN 'SHORT FILM'
ELSE 'STANDARD'
END AS LENGTH
FROM film;

--Solution 5
SELECT first_name, last_name
FROM customer
WHERE first_name LIKE 'Anna' OR first_name LIKE 'Carl'
;

--Solution 6
SELECT rental_id, (return_date - rental_date) as Duration
FROM rental
;

--Solution 7

SELECT rental_date, return_date
FROM rental
WHERE return_date > rental_date;

--Solution 8
SELECT *
FROM country
WHERE country LIKE '%ta%';

--Solution 9
SELECT rental_date
FROM rental
WHERE rental_date BETWEEN '2005-05-01' and '2005-08-03';

--Solution 10
SELECT title,description, LENGTH(DESCRIPTION)-LENGTH(REPLACE(DESCRIPTION, ' ', '')) as "Word Count"
FROM Film
WHERE (LENGTH(description) - LENGTH(replace(description, ' ', ''))) > 17


--Assistance received via stackoverflow and postgrel documentation with #4 and #10