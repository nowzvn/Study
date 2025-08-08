-- SQL 종류
-- DML : DATA CRUD
-- - C(INSERT INTO)R(SELECT FROM)U(UPDATE SET)D(DELETE FROM)
-- DDL : DATABASE, TABLE CRUD
-- - C(CREATE)R(SHOW,DESC)U(ALTER)D(DROP)

-- DML : READ
-- SELECT : columns : AS
-- FROM : table
-- WHERE : filtering condition(operator)
-- - BETWEEN AND, IN, NOT IN, IS NULL, IS NOT NULL, LIKE(%)
-- ORDER BY : sorting : ASC, DESC
-- LIMIT : limit : num1(limit) : num1(skip), num2(limit)

-- 연산자
-- 산술 : 데이터 + 데이터 = 데이터 : (+, -) < (*, /, %)
-- 비교 : 데이터 + 데이터 = 논리값 : =, !=, >, <, >=, <= : 조건 1개
-- 논리 : 논리값 + 논리값 = 논리값 : NOT, AND > OR : 조건 2개 이상
-- - AND : T AND T = T : 둘다 만족 출력
-- - OR : F OR F = F : T OR F = T : 둘중 하나 만족 출력
-- 우선순위 : 산술 > 비교 > 논리

-- 타이타닉 데이터 복원
USE world;
-- File > Open SQL Script 선택
SELECT * 
FROM titanic;

-- 문제
-- 출력컬럼 : 승객아이디, 생존여부, 나이, 요금, 승선위치 
-- 컬럼추가 : ages : 나이를 연령대로 출력 : 산술연산자(+, -, *, /, %)
-- 데이터 필터링 : 20대 승객과 40대 승객 데이터 출력
-- 데이터 정렬 : 연령대가 낮은 순으로 정렬하고 연령대가 같으면 요금이 높은 순으로 정렬
SELECT passengerid, survived, age, fare, embarked
	   , age - age % 10 AS ages
FROM titanic
-- WHERE (age >= 20) AND (age <= 29) OR (age >= 40) AND (age <= 49);
-- WHERE (age BETWEEN 20 AND 29) OR (age BETWEEN 40 AND 49);
WHERE age - age % 10 IN (20, 40)
ORDER BY ages ASC, fare DESC;

-- 쿼리 작성 순서 : SELECT > FROM > WHERE > ORDER BY > LIMIT
-- 쿼리 실행 순서 : FROM > WHERE > SELECT > ORDER BY > LIMIT

-- DDL : CREATE, READ
-- 데이터베이스, 테이블 생성
-- 데이터베이스 생성
CREATE DATABASE bda;
-- 데이터베이스 목록 확인
SHOW DATABASES;

-- 데이터베이스 선택
USE bda;
-- 테이블 스키마 출력
DESC world.city;
-- 테이블 생성시 필요한 속성 : 컬럼이름, 데이터타입, 제약조건

-- 데이터타입 : 저장공간을 효율적으로 사용하기 위해
-- - 숫자 : INT, FLOAT, DOUBLE
-- - 문자 : CHAR(고정길이), VARCHAR(가변길이), TEXT(긴길이)
-- - 날짜 : DATETIME(직접입력된시간), TIMESTAMP(현재시간)

-- 제약조건 : 데이터의 무결성(원하지 않는 데이터는 저장 X)을 지키기 위해 사용
-- - NOT NULL(결측 데이터 X), UNIQUE(중복 데이터 X)
-- - PRIMARY KEY(결측, 중복 데이터 X : ROW를 구별하는 식별자)
-- - AUTO_INCREMENT(자동으로 1씩 증가)
-- - DEFAULT(저장하려는 데이터가 없는 경우에 저장되는 데이터 설정)
-- - CURRENT_TIMESTAMP(현재시간저장)
-- - CHECK(조건에 맞는 데이터만 저장: 8.0.16 버전 이상 사용가능)

-- 테이블 생성
USE bda;
DROP TABLE user;
CREATE TABLE user(
	uid INT PRIMARY KEY AUTO_INCREMENT
    , name VARCHAR(50) NOT NULL
    , email VARCHAR(50) NOT NULL UNIQUE
    , age INT DEFAULT 20 CHECK(age >= 20)
    , rdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 스키마 확인
DESC user;

-- DML : CREATE
-- INSERT INTO <table>(<columns>) VALUES (data1), (data2) ...
SELECT * FROM user;
INSERT INTO user(name, email)
VALUES ('peter', 'peter@gmail.com'), ('alice', 'alice@naver.com');

INSERT INTO user(name, email, age)
VALUES ('jin', 'jin@daum.net', 27);
SELECT * FROM user;

-- 코드 실행 
USE bda;
DROP TABLE user;
CREATE TABLE user(
	uid INT PRIMARY KEY AUTO_INCREMENT
    , name VARCHAR(50) NOT NULL
    , email VARCHAR(50) NOT NULL UNIQUE
    , age INT DEFAULT 20 CHECK(age >= 20)
    , rdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO user(name, email)
VALUES ('peter', 'peter@gmail.com'), ('alice', 'alice@naver.com');
INSERT INTO user(name, email, age)
VALUES ('jin', 'jin@daum.net', 27);
SELECT * FROM user;

-- 쿼리 실행 결과 저장
USE world;
SELECT code, name, population
FROM country
WHERE population >= 10000 * 10000;

-- 테이블 생성
CREATE TABLE country_upper(
	code CHAR(3)
    , name VARCHAR(100)
    , population INT
);
DESC country_upper;

-- 쿼리 실행 결과 저장
INSERT INTO country_upper(code, name, population)
SELECT code, name, population
FROM country
WHERE population >= 10000 * 10000;

-- 저장된 결과 확인
SELECT * 
FROM country_upper;

-- DML : C(INSERT INTO)R(SELECT FROM)UD
-- DDL : C(CREATE)R(SHOW,DESC)UD

-- DML : UPDATE
-- UPDATE <table> SET <column1> = <data1>, <column2> = <data2>
-- WHERE <condition> LIMIT <num1>
USE bda;
SELECT * FROM user;
-- uid = 1 데이터의 이름을 andy, 나이를 32세로 수정
UPDATE user
SET name = 'andy', age = 32
WHERE uid = 1
LIMIT 1;
-- 수정된 데이터 확인
SELECT * FROM user;

SHOW PROCESSLIST;
KILL 12;

-- DML : DELETE
-- DELETE FROM <table> WHERE <condition> LIMIT <num>
SELECT * FROM user;

-- 30세 이하의 고객 데이터 삭제
DELETE FROM user
WHERE age < 30
LIMIT 5;

-- 삭제 확인
SELECT * FROM user;

-- DDL : UPDATE
-- ALTER <DATABASE|TABLE> ...

-- 데이터베이스 인코딩 방식 확인
SHOW VARIABLES LIKE 'character_set_database';

-- 데이터베이스 인코딩 방식 변경 : utf8mb4 > ascii
ALTER DATABASE bda CHARACTER SET = ascii;
-- 인코딩 방식 설정 이유 : 데이터베이스 인코딩 방식에 따라서 테이블이 생성됨
ALTER DATABASE bda CHARACTER SET = utf8mb4;

-- 테이블 스키마 수정
DESC user;
-- 컬럼추가(ADD), 컬럼수정(MODIFY COLUMN), 컬럼삭제(DROP)
ALTER TABLE user ADD contents TEXT;
ALTER TABLE user MODIFY COLUMN contents VARCHAR(100) DEFAULT 'NO DATA';
ALTER TABLE user DROP contents;
SELECT * FROM user;

-- DDL : DELETE : DROP
-- 테이블 삭제
DROP TABLE user;
-- 테이블 목록 출력
SHOW TABLES;

-- 데이터베이스 삭제
DROP DATABASE bda;
SHOW DATABASES;

-- DML : DATA C(INSERT INTO)R(SELECT FROM)U(UPDATE SET)D(DELETE FROM)
-- DDL : DATABASE, TABLE C(CREATE)R(SHOW,DESC)U(ALTER)D(DROP)

-- 데이터베이스 모델링
-- 데이터베이스 테이블의 구조와 관계를 만들어 주는 방법
-- 개념적 > 논리적 > 물리적 모델링
-- EER 다이어그램 : 물리적 모델링 구현 > 데이터베이스(테이블) 생성
DROP DATABASE bda;
USE bda;
DESC purchases;

-- 외래키(FOREIGN KEY) 제약조건
-- 데이터의 무결성을 지킴, 테이블 사이의 관계를 설정

-- 데이터 베이스 생성
CREATE DATABASE fkbda;
USE fkbda;

-- 테이블 생성
CREATE TABLE user(
	ui INT PRIMARY KEY
    , un VARCHAR(10)
);
CREATE TABLE money(
	ui INT
    , am INT
);

-- 데이터 추가
INSERT INTO user(ui, un) VALUES (1, 'A'), (2, 'B');
SELECT * FROM user;
INSERT INTO money(ui, am) VALUES (1, 100), (2, 200), (1, 300);
SELECT * FROM money;

-- 외래키 설정 없이 데이터 추가
INSERT INTO money(ui, am) VALUES (3, 400);
SELECT * FROM money;
SELECT * FROM user;

-- money 테이블 외래키 설정
DROP TABLE money;
CREATE TABLE money(
	ui INT
    , am INT
    , FOREIGN KEY (ui) REFERENCES user(ui)
);
DESC money;

-- 데이터 추가
INSERT INTO money(ui, am) VALUES (1, 100), (2, 200), (1, 300);
SELECT * FROM money;
SELECT * FROM user;

-- 외래키 동작 여부 확인
-- user 테이블의 ui가 없는 데이터를 money 테이블의 ui에 추가
INSERT INTO money(ui, am) VALUES (3, 400);

-- user 테이블의 ui = 2 데이터 삭제
DELETE FROM user
WHERE ui = 2
LIMIT 1;

-- 외래키 설정
-- UPDATE, DELETE 설정시 무결성이 깨지는 경우에 동작을 정의
-- - CASCADE : 데이터 동기화
-- - SET NULL : 결측 데이터 변경
-- - SET DEFAULT : DEFAULT 값으로 변경
-- - RESTRICT : 에러발생

-- UPDATE > CASCADE, DELETE > SET NULL
DROP TABLE money;
CREATE TABLE money(
	ui INT
    , am INT
    , FOREIGN KEY (ui) REFERENCES user(ui)
    ON UPDATE CASCADE ON DELETE SET NULL
);
INSERT INTO money(ui, am) VALUES (1, 100), (2, 200), (1, 300);
SELECT * FROM money;
SELECT * FROM user;

-- UPDATE 동작 확인
-- user 테이블의 ui = 2을 ui = 3으로 변경
UPDATE user
SET ui = 3
WHERE ui = 2
LIMIT 1;

-- money 테이블의 ui = 2이 ui = 3으로 변경(동기화)
SELECT * FROM money;

-- DELETE SET NULL 동작 확인
SELECT * FROM money;
SELECT * FROM user;

-- user 테이블의 ui = 1 삭제
DELETE FROM user
WHERE ui = 1
LIMIT 1;

-- money 테이블의 ui = 1 데이터가 null 출력 확인
SELECT * FROM money;

-- 함수 : FUNCTION
-- 미리 만들어 놓은 특별한 기능을 사용하는 방법
-- 단일행 함수 : 특별한 기능을 하나의 데이터에 적용하여 출력
-- - CEIL(), ROUND(), TRUNCATE(), CONCAT(), DATE_FORMAT() ...
-- 다중행(결합,집계) 함수 : 특별한 기능을 여러개의 데이터에 적용하여 출력
-- - SUM(), AVG(), COUNT(), MIN(), MAX(), VAR(), MEDIAN() ...

-- 단일행함수

-- CEIL() : 자리수를 설정하면 에러 발생
SELECT CEIL(12.345);
-- 소수 2번째 자리에서 올림하여 소수 1번째 자리까지 출력
SELECT CEIL(12.345 * 10) / 10; -- CEIL() 자리수 설정 불가 

-- ROUDN() : 자리수를 설정해도되고 안해도 됨
SELECT ROUND(12.567);
SELECT ROUND(12.567, 0);
SELECT ROUND(12.567, 1);
SELECT ROUND(12.567, -1);

-- TRUNCATE() : 반드시 자리수를 설정해야 함
SELECT TRUNCATE(12.567, 1);

-- 문제 : 연산자를 사용하지 않고 연령대 데이터를 ages 컬럼으로 추가
USE world;
SELECT passengerid, name, age, TRUNCATE(age, -1) AS ages
FROM titanic;

-- CONCAT() : 문자열을 결합하여 결과 출력
-- name_code : 국가이름(국가코드) 포멧의 컬럼 추가
SELECT name, code, CONCAT(name, '(', code, ')') AS name_code
FROM country;

-- 선형대수용어 : 스칼라, 벡터, 매트릭스, 텐서
-- 같은 모양 : 같은 위치의 데이터끼리 연산
-- 다른 모양 : 브로드 캐스트하게 연산

-- 문제 : full_name 컬럼을 추가
USE sakila;
SELECT staff_id, first_name, last_name, CONCAT(first_name, ' ', last_name) AS full_name
FROM staff;

-- DATE_FORMAT()
-- 날짜 데이터의 포멧을 변환할때 사용
-- 매출일시를 년월 데이터로 변환
SELECT payment_id, amount, payment_date, DATE_FORMAT(payment_date, '%Y-%m') AS monthly
	   , DATE_FORMAT(payment_date, '%p %h') AS hour12
FROM payment;

-- DML : DATA CRUD
-- DDL : DATABASE, TABLE CRUD
-- 데이터타입, 제약조건
-- 데이터 모델링 : 개념적 > 논리적 > 물리적 : EER 다이어그램
-- 테이블 관계 설정 : 외래키 : 데이터 무결성을 지킴 : UPDATE, DELETE 여러가지 전략으로 설정






























