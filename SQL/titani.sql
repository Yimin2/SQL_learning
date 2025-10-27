USE temp;
SELECT * FROM titanic;

-- 1-1: 상위 5행 조회
SELECT * FROM titanic LIMIT 5;

-- 1-2: 전체 행 수 조회
SELECT count(*) FROM titanic;

-- 문제 1-3: cabin 결측치(NULL) 개수
SELECT
    SUM(CASE WHEN cabin = "" THEN 1 ELSE 0 END)
FROM TITANIC ;

-- 문제 1-4: 요금(fare) 기초 통계
SELECT round(min(fare),2), round(avg(fare),2), round(max(fare),2)
FROM titanic;

-- 문제 2-1: 1등석 승객 조회
SELECT name, ticket, fare
FROM TITANIC
WHERE pclass = 1;

-- 문제 2-2: 셰르부르(C) 항구 탑승자 조회
SELECT * FROM TITANIC WHERE EMBARKED = 'c'.

-- 문제 2-3: 30세 미만 생존자 조회
SELECT name, age, sex FROM TITANIC WHERE age < 30 AND SURVIVED = 1

-- 문제 2-4: 요금이 비싼 순서로 정렬
SELECT fare FROM titanic ORDER BY fare DESC;

-- 문제 2-5: 복합 조건 - 여성 1등석 승객
SELECT name, age, fare, sex FROM titanic WHERE sex = 'female' AND pclass = 1
ORDER BY age;

-- 문제 3-1: 전체 생존율 및 생존/사망자 수
-- 전체 생존율 (소수점 둘째 자리까지 백분율로 표시)
SELECT round((sum(survived = 1) / count(*)*100),2)
FROM TITANIC;

SELECT round(avg(survived) * 100,2)
FROM TITANIC;
-- 생존 여부별 승객 수
SELECT  survived, count(*)
FROM TITANIC
GROUP BY survived;


-- 문제 3-2: 성별 생존율
SELECT sex, count(*), sum(SURVIVED =1),
       round((sum(survived = 1) / count(*)*100),2) AS 생존율,
       avg(survived)*100
FROM TITANIC
GROUP BY sex
ORDER BY 생존율;

-- 문제 3-3: 티켓 등급별 생존율 및 평균 요금
-- 등급별 생존율
SELECT pclass, round((sum(survived = 1) / count(*)*100),2)
     , avg(SURVIVED)*100
FROM TITANIC
GROUP BY pclass;
-- 등급별 평균 요금, 최소 요금, 최대 요금
SELECT pclass, avg(fare), min(fare), max(fare)
FROM TITANIC
GROUP BY pclass;

-- 문제 3-4: 항구별, 등급별 승객 수
SELECT EMBARKED, pclass, count(*)
FROM TITANIC
WHERE EMBARKED != ''
GROUP BY EMBARKED, pclass
ORDER BY embarked, pclass;

-- 문제 3-5: 성별 및 등급별 생존율
SELECT pclass, sex, count(*), sum(survived =1 ),
       round((sum(survived = 1) / count(*)*100),2)
FROM TITANIC
GROUP BY sex, pclass
ORDER BY PCLASS , sex;

-- 문제 3-6: 가족 동반 유무에 따른 생존율
-- '혼자' vs '가족동반' 생존율 비교
SELECT sibsp OR parch, count(*), round(sum(SURVIVED = 1)/307 *100,2)
FROM TITANIC
GROUP BY sibsp OR parch

SELECT
    CASE
        when (sibsp + parch) = 0 THEN '혼자'
        ELSE '가족'
        END AS family_status,
    count(*),
    avg(survived)*100
FROM titanic
GROUP BY family_status;

-- 가족이 1명이라도 있는 승객의 평균 생존율
SELECT
    count(*),
    avg(SURVIVED )
FROM titanic
WHERE sibsp > 0 OR parch > 0 ;

-- 문제 3-7: 가족 규모별 생존율
SELECT
    (1+sibsp+parch) AS family_size,
    count(*),
    avg(survived)
FROM titanic
GROUP BY FAMILY_SIZE
ORDER BY family_size

-- 문제 4-1: 연령대별 승객 수 및 생존율
SELECT
    CASE
        WHEN age < 18 THEN 'child'
        WHEN age <= 60 THEN 'adult'
        ELSE 'senior'
        END AS age_group,
    count(*),
    avg(SURVIVED ) *100
FROM TITANIC
GROUP BY AGE_GROUP ;

-- 문제 4-2: 요금 구간(Band)별 생존율
SELECT
    CASE
        WHEN fare <10 THEN '저가'
        WHEN fare < 30 THEN '중저가'
        WHEN fare < 100 THEN '중고가'
        ELSE '고가'
        END fare_band,
    count(*),
    avg(survived)*100
FROM TITANIC
GROUP BY FARE_BAND
ORDER BY
    CASE FARE_BAND
        WHEN '저가' THEN 1
        WHEN '중저가' THEN 2
        WHEN '중고가' THEN 3
        ELSE 4
        END;
-- 문제 4-3: 평균 요금이 50달러가 넘는 등급 (HAVING)
SELECT
    PCLASS,
    COUNT(*),
    avg(fare)
FROM TITANIC
GROUP BY PCLASS
HAVING avg(fare) > 50;

-- 문제 4-4: 전체 평균 요금보다 많이 낸 승객 (서브쿼리)
SELECT avg(fare) FROM titanic;

SELECT
    name,
    pclass,
    fare
FROM titanic
WHERE fare > (SELECT avg(fare) FROM titanic)
ORDER BY fare DESC LIMIT 20;
-- 문제 4-5: 3등석 평균 나이보다 많은 1등석 승객 (서브쿼리)

SELECT avg(age) FROM TITANIC WHERE PCLASS = 3;

SELECT
    name, age, pclass, (SELECT avg(age) FROM TITANIC WHERE PCLASS = 3)
FROM titanic
WHERE pclass = 1 AND age > (SELECT avg(age) FROM TITANIC WHERE PCLASS = 3)
ORDER BY age DESC LIMIT 20;