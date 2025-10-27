USE world;

SELECT * FROM CITY
WHERE COUNTRYCODE = 'kor';

SELECT * FROM COUNTRY
WHERE code = 'kor';

-- 역정규화
SELECT ci.NAME 도시,
       co.NAME 나라,
       co.CONTINENT 대륙,
       ci.POPULATION 도시인구,
       co.POPULATION 국가인가
FROM city ci INNER JOIN COUNTRY co
                        ON ci.COUNTRYCODE = CO.CODE
WHERE co.name = 'South Korea';

SELECT
    co.name,
    count(*)
FROM
    city ci
        INNER JOIN country co
                   ON
                       ci.COUNTRYCODE = co.CODE
GROUP BY
    co.name
ORDER BY
    count(*) DESC;

SELECT
    co.CONTINENT,
    count(*),
    avg(ci.POPULATION)
FROM
    city ci
        INNER JOIN COUNTRY co
                   ON
                       ci.COUNTRYCODE = co.CODE
GROUP BY
    co.CONTINENT;

SELECT
    count(DISTINCT co.code) as '전체국가수_join',
    (
        select
            COUNT(*)
        from
            country) as '전체국가수_country'
FROM
    city ci
        INNER JOIN COUNTRY co
                   ON
                       ci.COUNTRYCODE = co.CODE

select *
from country co left join city ci
                          on co.CODE = ci.COUNTRYCODE
order by co.POPULATION;

select
    c1.name, c2.name
from city c1 inner join city c2
where c1.countrycode = 'kor'

select
    *
from  country co inner join city ci on co.code = ci.CountryCode
                 inner join countrylanguage cl on ci.CountryCode = cl.countrycode ;

USE sakila;
--

-- 영화(`film`)와 언어(`language`) 테이블을 조인하여 다음을 조회하세요:
-- - 영화 제목 (`film.title`), 언어 이름 (`language.name`)
SELECT film.title, LANGUAGE.name
FROM film INNER JOIN LANGUAGE;


-- 영화와 카테고리를 조인하여 다음을 조회하세요:
-- - 영화 제목, 카테고리 이름, 대여료
SELECT film.title,rental_rate, category.name
FROM film inner JOIN film_category
                     ON film.film_id = film_category.film_id
          INNER JOIN category
                     ON film_category.category_id = category.category_id;

-- 모든 고객(`customer`)과 그들의 대여 내역(`rental`)을 조회하세요.
-- - 고객 이름 (first_name, last_name), 대여 ID (rental_id), 대여 날짜 (rental_date)
SELECT
    customer.first_name, customer.last_name,
    rental.rental_id,
    rental.return_date
FROM rental Left JOIN customer
                      ON customer.customer_id = rental.customer_id;

-- 고객별 대여 횟수를 조회하세요. (대여 횟수 0인 고객도 포함)
-- - 고객 이름, 대여 횟수, 대여 횟수가 많은 순서
SELECT
    customer.customer_id, customer.last_name, count(*)
FROM rental LEFT JOIN customer
                      ON rental.customer_id = customer.customer_id
GROUP BY customer_id
ORDER BY count(*) DESC;


-- 같은 상영 시간(`length`)을 가진 영화 쌍을 찾으세요.
-- - 영화1 제목, 영화2 제목, 상영 시간, 상위 10개
SELECT
    f1.title, f2.title, f1.`length`
FROM film f1 INNER JOIN film f2
                        ON f1.length = f2.length
ORDER BY f1.LENGTH DESC
