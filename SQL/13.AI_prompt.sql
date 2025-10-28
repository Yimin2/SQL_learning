use sakila;

SELECT *

FROM rental
WHERE rental_date BETWEEN '2005-06-01' AND '2005-06-30';


SELECT
r.rental_id,
r.rental_date,
c.customer_id,
CONCAT(c.first_name, ' ', c.last_name) AS customer_name
FROM rental r
JOIN customer c
ON r.customer_id = c.customer_id
WHERE r.rental_date BETWEEN '2005-06-01' AND '2005-06-30'
ORDER BY r.rental_date;

SELECT
c.customer_id,
CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
COUNT(r.rental_id) AS rental_count
FROM rental r
JOIN customer c
ON r.customer_id = c.customer_id
WHERE r.rental_date BETWEEN '2005-06-01' AND '2005-06-30'
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY rental_count DESC;

SELECT
c.customer_id,
CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
COUNT(r.rental_id) AS rental_count
FROM rental r
JOIN customer c
ON r.customer_id = c.customer_id
WHERE r.rental_date BETWEEN '2005-06-01' AND '2005-06-30'
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(r.rental_id) >= 10
ORDER BY rental_count DESC;


SELECT
c.customer_id,
CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
COUNT(r.rental_id) AS rental_count,
SUM(p.amount) AS total_spent
FROM rental r
JOIN customer c
ON r.customer_id = c.customer_id
JOIN payment p
ON r.rental_id = p.rental_id
WHERE r.rental_date BETWEEN '2005-06-01' AND '2005-06-30'
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(r.rental_id) >= 10
ORDER BY total_spent DESC;

SELECT
f.film_id,
f.title AS film_title,
c.category_id,
c.name AS category_name
FROM film f
JOIN film_category fc
ON f.film_id = fc.film_id
JOIN category c
ON fc.category_id = c.category_id
ORDER BY c.name, f.title;


SELECT
f.film_id,
f.title AS film_title,
c.category_id,
c.name AS category_name,
f.rental_rate
FROM film f
JOIN film_category fc
ON f.film_id = fc.film_id
JOIN category c
ON fc.category_id = c.category_id
ORDER BY c.name, f.title;

SELECT
c.category_id,
c.name AS category_name,
ROUND(AVG(f.rental_rate), 2) AS avg_rental_rate
FROM film f
JOIN film_category fc
ON f.film_id = fc.film_id
JOIN category c
ON fc.category_id = c.category_id
GROUP BY c.category_id, c.name
ORDER BY avg_rental_rate DESC;

SELECT
c.category_id,
c.name AS category_name,
ROUND(AVG(f.rental_rate), 2) AS avg_rental_rate
FROM film f
JOIN film_category fc
ON f.film_id = fc.film_id
JOIN category c
ON fc.category_id = c.category_id
GROUP BY c.category_id, c.name
ORDER BY avg_rental_rate DESC
LIMIT 3;

(
SELECT
c.category_id,
c.name AS category_name,
ROUND(AVG(f.rental_rate), 2) AS avg_rental_rate,
'TOP 3 (Highest)' AS rank_group
FROM film f
JOIN film_category fc
ON f.film_id = fc.film_id
JOIN category c
ON fc.category_id = c.category_id
GROUP BY c.category_id, c.name
ORDER BY avg_rental_rate DESC
LIMIT 3
)
UNION ALL
(
SELECT
c.category_id,
c.name AS category_name,
ROUND(AVG(f.rental_rate), 2) AS avg_rental_rate,
'BOTTOM 3 (Lowest)' AS rank_group
FROM film f
JOIN film_category fc
ON f.film_id = fc.film_id
JOIN category c
ON fc.category_id = c.category_id
GROUP BY c.category_id, c.name
ORDER BY avg_rental_rate ASC
LIMIT 3
)
ORDER BY avg_rental_rate DESC;


WITH category_avg AS (
SELECT
c.category_id,
c.name AS category_name,
ROUND(AVG(f.rental_rate), 2) AS avg_rental_rate
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.category_id, c.name
)
(
SELECT *, 'TOP 3 (Highest)' AS rank_group
FROM category_avg
ORDER BY avg_rental_rate DESC
LIMIT 3
)
UNION ALL
(
SELECT *, 'BOTTOM 3 (Lowest)' AS rank_group
FROM category_avg
ORDER BY avg_rental_rate ASC
LIMIT 3
)
ORDER BY avg_rental_rate DESC;

