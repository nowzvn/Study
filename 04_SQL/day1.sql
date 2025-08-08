-- SQL 코드 작성 및 실행
-- 코드 실행 단축키 : 코드블럭설정 > ctrl(cmd) + shift + enter
SELECT * FROM world.country;

-- comment : 주석
-- 사용이유 : 코드에 대한 설명 작성, 실행되지 않는 코드를 설정

-- ctrl(cmd) + tab
-- 데이터베이스 선택
-- ; : SQL 쿼리의 마지막을 의미
USE world;
-- 선택된 데이터베이스 확인
SELECT DATABASE();

-- 코드 작성 방법
-- 코딩 문법 : 틀리면 에러 O > 코드 실행 X
-- 코딩 컨벤션 : 틀려도 에러 X > 코드 실행 O : 파이썬(PEP8)
-- 컨벤션 가이드 : https://www.sqlstyle.guide
-- - 의미를 갖는 특정한 문자열(SELECT,DATABASE) : 대문자 사용
-- - 데이터를 구별해주는 식별자 : 소문자 사용 
-- - 컨벤션을 지켜서 가독성이 좋은 코드를 작성 > 코드의 유지보수가 좋아짐

-- SQL 쿼리 종류
-- DML : 데이터 조작어 : DATA CRUD
-- - C(INSERT INTO)R(SELECT FROM)U(UPDATE SET)D(DELETE FROM)
-- DDL : 데이터 정의어 : DATABASE, TABLE CRUD
-- - C(CREATE)R(SHOW,DESC)U(ALTER)D(DROP)
-- DCL : 데이터 제어어 : SYSTEM : 계정생성, 권한설정 ...
-- TCL : Transaction 제어어, DQL : DML(READ:SELECT FROM)
-- SQLD 자격증 : DML, DDL, DCL, TCL 구분

-- DML : READ
-- SELECT <columns> FROM <table>
-- * 의미 : 모든 이라는 뜻을 의미
SELECT * 
FROM country;

-- 국가코드, 국가이름, 대륙이름, 인구수 출력
-- AS : alias : 컬럼이름을 변경하여 출력
SELECT code AS countrycode, name, continent, population
FROM country;

-- sakila 데이터베이스에서 film 테이블이 있는 영화제목, 영화설명, 상영시간, 등급 데이터 출력
-- 영화제목은 film_title로 컬럼이름을 변경하여 출력
-- 알고리즘(문제해결을 위한 절차) > 코딩(컴퓨터언어로 변환) = 프로그래밍
-- 1. sakila 데이터 베이스 선택
USE sakila;
-- 2. film 테이블 모든 데이터 확인
SELECT * FROM film;
-- 3. 필요한 컬럼들만 필터링하여 출력 
SELECT title, description, length, rating
FROM film;
-- 4. 영화제목은 film_title 컬럼이름으로 출력
SELECT title AS film_title, description, length, rating
FROM film;

-- 데이터분석
-- 데이터베이스(데이터) : 알고리즘 구현이 어려움
-- 파이썬(패키지) : 이미 구현된 알고리즘 사용이 쉬움
-- 데이터베이스의 데이터를 파이썬으로 가져와서 데이터분석 수행
-- 데이터베이스에 있는 데이터를 파이썬으로 꺼내오는 방법 : csv 파일
-- csv : 압축 X > 입출력 빠름 : 파일이 큼
-- excel : 압축 O > 입출력 느림 : 파일이 작음
-- workbench 메뉴 : Query > Export Results 선택

-- 데이터 필터링 방법
-- WHERE condition(operator)

-- 연산자
-- 산술 : 데이터 + 데이터 = 데이터 : +, -, *, /, %
-- 비교 : 데이터 + 데이터 = 논리값 : =, !=, >, <, >=, <= : 조건 1개
-- 논리 : 논리값(조건1) + 논리값(조건2) = 논리값 : NOT, AND, OR : 조건 2개 이상
-- AND : T AND T = T : 두개의 조건 모두 만족 출력
-- OR : F OR F = F : T OR F = T : 둘중 하나의 조건만 만족 출력
-- 우선순위 : 산술 > 비교 > 논리

-- 산술연산자
USE world;

-- 컬럼추가 : 인구밀도(인구수/면적) : pps
SELECT code, name, surfacearea, population
	   , population / surfacearea AS pps
FROM country;

-- 컬럼추가 : 1인당 gnp 출력 : gpp
-- gnp는 100만 단위를 가짐 > 원래 단위로 gpp를 출력
SELECT code, name, gnp, population
	   , gnp / population * 100 * 10000 AS gpp
FROM country;

-- 선형대수 : 행렬연산
-- scala(5), vector([1, 2]), matrix([[1, 2], [3, 4]]:2D), tensor(>=3D)
-- 연산수행방법
-- 같은모양 : 같은 위치의 데이터끼리 연산
-- 다른모양 : 벡터 + 스칼라 : 브로드 캐스트 연산 수행

-- 비교연산자 
-- 논리값(true(1), false(0))
-- 조건 1 : is_asia : 아시아 대륙의 국가이면 1(true), 아니면 0(false) 출력
-- 조건 2 : upper_1000 : 인구수가 1000만명 이상이면 1, 아니면 0 출력
SELECT code, name, continent, population
	   , continent = 'Asia' AS is_asia
       , population >= 1000 * 10000 AS upper_1000
FROM country;

-- 논리연산자
-- 조건 1 : is_asia : 아시아 대륙의 국가이면 1(true), 아니면 0(false) 출력
-- 조건 2 : upper_1000 : 인구수가 1000만명 이상이면 1, 아니면 0 출력
-- 논리연산 : asia_1000 : AND
-- - 아시아대륙의 국가이면서, 인구수가 1000만명 이상이면 1, 아니면 0 출력
SELECT code, name, continent, population
	   , continent = 'Asia' AS is_asia
       , population >= 1000 * 10000 AS upper_1000
       , (continent = 'Asia') AND (population >= 1000 * 10000) AS asia_1000
FROM country;

-- WHERE : condition(operator)
SELECT code, name, continent, population
FROM country
WHERE (continent = 'Asia') AND (population >= 1000 * 10000);

-- WHERE 구문 명령어
-- 문제 : 인구수가 4천만이상, 5천만이하의 국가목록 출력
-- 조건 1. 인구수 4천만이상 : population >= 4000 * 10000
-- 조건 2. 인구수 5천만이하 : population <= 5000 * 10000
-- 논리연산 : AND
SELECT code, name, continent, population
FROM country
WHERE (population >= 4000 * 10000) AND (population <= 5000 * 10000);
-- 범위 데이터 필터링 : BETWEEN AND
SELECT code, name, continent, population
FROM country
WHERE population BETWEEN 4000 * 10000 AND 5000 * 10000;

-- 문제 : 아시아와 아프리카 대륙의 국가 목록 출력
-- 조건 1. 아시아 대륙 : continent = 'Asia'
-- 조건 2. 아프리카 대륙 : continent = 'Africa'
-- 논리연산 : OR
-- 추가조건 : 아시아, 아프리카 대륙중에 인구수 1000만명 이상의 국가 출력
SELECT code, name, continent, population
FROM country
WHERE ((continent = 'Asia') OR (continent = 'Africa'))
	  AND (population >= 1000 * 10000);
-- 논리연산자 우선순위 : AND > OR

-- IN, NOT IN
SELECT code, name, continent, population
FROM country
-- WHERE (continent = 'Asia') OR (continent = 'Africa');
WHERE continent NOT IN ('Asia', 'Africa');

-- 결측(비어있는) 데이터 필터링
-- 결측 데이터를 제외하고 데이터 출력
-- 결측 데이터는 모든 연산에 대해서 false(0)를 출력
-- IS NULL, IS NOT NULL
SELECT code, name, indepyear
FROM country
WHERE indepyear IS NOT NULL;

-- LIKE : 특정 문자열 포함여부에 따라서 데이터 출력
-- 대륙별 동쪽에 위치한 국가 목록 출력
-- % 의미 : 아무문자 0개 이상
SELECT code, name, continent, region
FROM country
WHERE region LIKE '%east%';

-- WHERE 구문 명령어
-- BETWEEN AND, IN, NOT IN, IS NULL, IS NOT NULL, LIKE

-- 데이터 정렬
-- 문자열은 ABC순, 숫자는 숫자가 작은순 정렬
-- ORDER BY : ASC, DESC
-- 인구수가 많은 도시순으로 정렬하여 출력
-- 국가코드 오름차순으로 정렬
-- 국가코드 오름차순으로 정렬하고 국가코드의 우선순위가 동일하면 인구수가 많은 순으로 정렬
SELECT countrycode, name, population
FROM city
ORDER BY countrycode ASC, population DESC;

-- 데이터 제한
-- LIMIT : num1(limit) : num1(skip), num2(limit)
-- 인구수가 많은 도시 1위 ~ 10위 출력
-- 인구수가 많은 도시 6위 ~ 8위 출력
SELECT countrycode, name, population
FROM city
ORDER BY population DESC
LIMIT 5, 3;

-- DML : READ
-- SELECT : columns
-- FROM : table
-- WHERE : condition(operator)
-- - BETWEEN AND, IN, NOT IN, IS NULL, IS NOT NULL, LIKE
-- ORDER BY : sorting : ASC, DESC
-- LIMIT : num1(limit) : num1(skip), num2(limit)

-- 연산자
-- 산술 : 데이터 + 데이터 = 데이터 : (+, -) < (*, /, %)
-- 비교 : 데이터 + 데이터 = 논리값 : =, !=, >, <. <=, <= : 조건 1개
-- 논리 : 논리값 + 논리값 = 논리값 : NOT, AND > OR : 조건 2개 이상
-- - AND : T AND T = T : 둘다 만족 출력
-- - OR : F OR F = F : T OR F = T : 둘중 하나 만족 출력
-- 우선순위 : 산술 > 비교 > 논리

-- 문제 : sakila 데이터베이스의 film 테이블에서
-- 영화설명에 robot이 들어가고, 영화상영시간은 60 ~ 120인, 영화등급이 G, PG를 제외한 데이터 출력
-- 상영시간이 긴 데이터 5개 출력
-- 출력컬럼 : 영화제목, 영화설명, 상영시간, 영화등급
USE sakila;
SELECT title, description, length, rating
FROM film
WHERE description LIKE '%robot%'
	  AND length BETWEEN 60 AND 120
      AND rating NOT IN ('G', 'PG')
ORDER BY length DESC
LIMIT 5;








