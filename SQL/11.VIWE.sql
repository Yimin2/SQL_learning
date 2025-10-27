USE world;

CREATE VIEW large_country AS
SELECT * FROM country
WHERE Population >= 50000000;

SELECT * FROM large_country;

DROP VIEW country_view;

DROP VIEW large_country;

CREATE VIEW country_view AS
SELECT co.name co_name, ci.name ci_name
FROM country co INNER JOIN city ci
                           ON co.code = ci.CountryCode;

SELECT * FROM country_view;

SHOW FULL TABLES;
SHOW FULL tables WHERE table_type = 'VIEW';
