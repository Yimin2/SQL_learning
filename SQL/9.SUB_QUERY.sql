USE world;

SELECT * FROM city;

SELECT Population FROM city WHERE name = 'seoul'

SELECT
    *
FROM city
WHERE Population > (SELECT Population FROM city WHERE name = 'seoul')


SELECT
    name, Population
FROM country
WHERE Population > (SELECT AVG(country.Population) FROM country)
ORDER BY country.Population DESC;

SELECT
    Name, CountryCode, Population
FROM city
WHERE CountryCode IN (SELECT code FROM country WHERE Continent = 'asia');

SELECT *
FROM country
WHERE code NOT IN (SELECT DISTINCT countryCode FROM city);

SELECT *
FROM (
         SELECT Continent, COUNT(*) AS co_count
         FROM country
         GROUP BY Continent
     ) AS sub
WHERE co_count > 40;

USE sakila;

-- 평균 대여료(`rental_rate`)보다 비싼 영화를 조회하세요.
-- - 영화 제목, 대여료. 대여료 내림차순 정렬
-- - 상위 10개

SELECT title, rental_rate
FROM  film
WHERE rental_rate > (SELECT AVG(rental_rate) FROM film)
ORDER BY rental_rate DESC LIMIT 10;


-- 'Action' 카테고리에 속한 영화를 조회하세요.
-- - 영화 제목
SELECT title
FROM film_category inner JOIN category
                              ON film_category.category_id = category.category_id
                   INNER JOIN film
                              ON film.film_id = film_category.film_id
WHERE film_category.category_id = 1

SELECT title
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM film_category
    WHERE category_id = (
        SELECT category_id
        FROM category
        WHERE name = 'Action'
    )
);


-- 대여 기록이 있는 고객만 조회하세요.
-- - 고객 이름 (first_name, last_name), 이메일

SELECT first_name, last_name, email
FROM customer
WHERE customer_id in (SElECT DISTINCT customer_id FROM rental);

SELECT
    first_name, email
FROM customer
WHERE
    EXISTS (SELECT * FROM rental WHERE customer.customer_id = rental.customer_id);
-- 고객별 대여 횟수를 구한 뒤, 대여 횟수가 30회 이상인 고객만 조회하세요.
-- - 고객 이름, 대여 횟수, 대여 횟수 내림차순
SELECT
    c.last_name,
    r_cnt.cu_count
FROM customer c
         JOIN (
    SELECT customer_id, COUNT(*) AS cu_count
    FROM rental
    GROUP BY customer_id
) AS r_cnt
              ON c.customer_id = r_cnt.customer_id
WHERE r_cnt.cu_count >= 30
ORDER BY r_cnt.cu_count DESC;

SELECT
    c_name, c_id, c_count
FROM
    (
        SELECT
            c.last_name AS c_name,
            c.customer_id AS c_id,
            COUNT(*) AS c_count
        FROM customer c INNER JOIN rental r
                                   ON c.customer_id = r.customer_id
        GROUP BY c.customer_id
    ) AS customer_rental
WHERE c_count >= 30;