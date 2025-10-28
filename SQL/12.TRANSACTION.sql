USE temp;

CREATE TABLE account
(
    id      INT PRIMARY KEY AUTO_INCREMENT,
    name    VARCHAR(10),
    balance INT
);

INSERT INTO account (name, balance)
VALUES ('kim', 100000);

INSERT INTO account (name, balance)
VALUES ('lee', 200000);

SELECT *
FROM account;

START TRANSACTION;
UPDATE account
SET balance = balance + 10000
WHERE id = 1;
UPDATE account
SET balance = balance - 10000
WHERE id = 2;
SELECT *
FROM account;
COMMIT;
ROLLBACK;

START TRANSACTION;
INSERT INTO account (name, balance)
VALUES ('hongs', 0);
SAVEPOINT sp1;
INSERT INTO account (name, balance)
VALUES ('choi', 9999999);
SAVEPOINT sp2;

ROLLBACK TO SAVEPOINT sp1;
COMMIT;

SELECT *
FROM account;

SELECT @@autocommit;

SET @@autocommit = 1;

SELECT *
FROM account;
