USE world;

SHOW INDEX FROM city;

DESCRIBE city;

CREATE INDEX idx_city_name ON city(name);

EXPLAIN SELECT * FROM city WHERE name = 'seoul';

SHOW INDEX FROM city;

DROP INDEX idx_city_name ON city;

