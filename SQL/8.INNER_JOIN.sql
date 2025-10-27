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

