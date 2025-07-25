/**
* MYSQL :: 정형 데이터를 저장하는 데이터베이스
- SQL 문법을 사용하여 데이터를 CRUD(Create Read Update Delete) 한다.
- C(Create : 생성, insert)
- R(Read : 조회, select)
- U(Update : 수정, update)
- D(Delete : 삭제, delete)
- 개발자는 DML에 대한 CRUD 명령어를 잘 사용할 수 있어야한다.
- SQL은 대소문자 구분하지 않음, 보통 소문자로 작성
- snake 방식의 네이밍 규칙을 가짐 ex) _ 말하는거임
- SQL은 크게 DDL, DML, DCL, DTL로 구분할 수 있다.

1.DDL(Data Definition Language) : 데이터 정의어
	: 데이터를 저장하기 위한 공간을 생성하고 논리적으로 정의하는 언어
    : create, alter, truncate, drop ..

2.DML(Data Manipulation Languege) : 데이터 조작어
	: 데이터를 CRUD하는 명령어
    : insert, select, update, delete
    
3.DCL(Data Control Language) : 데이터 제어어
	: 데이터에 대한 권한과 보안을 정의하는 언어
    : grant, revoke
    
4.DTL[또는 TCL](Data Transaction Language) : 트랜잭션 제어어
	: 데이터베이스의 처리 작업 단위인 트랜잭션을 관리하는 언어
	: commit, save, rollback
*/ 

/* 반드시 기억해야 될 것 (Workbench 실행 할 때마다 실행 해줘야함) */ 
show databases; -- 모든 데이터베이스 조회
use hrdb2019; -- 사용할 데이터베이스 오픈
select database(); -- 호출할 데이터베이스 선택
show tables; -- 데이터베이스의 모든 테이블 조회

/******************************************
		DESC(DESCIBE) : 테이블 구조 확인
        형식> desc(describe) [테이블명];
******************************************/
show tables;
desc employee;
desc department;
desc unit;
desc vacation;

/******************************************
		SELECT : 테이블 내용 조회
        형식> SELECT [컬럼리스트] FROM [테이블명];
******************************************/
SELECT emp_id, emp_name FROM employee;
SELECT * FROM employee;
SELECT emp_name, gender, hire_date FROM employee;

-- 사원테이블의 사번, 사원명, 성별, 입사일, 급여를 조회
DESC employee;
SELECT emp_id, emp_name, gender, hire_date, salary FROM employee;

-- 부서테이블의 모든 정보 조회
SELECT * FROM department;

/******************************************
		AS : 컬럼명 별칭 부여
        형식> SELECT [컬럼명 AS 별칭, ...] FROM [테이블명];
******************************************/
-- 사원 테이블에 사번, 사원명, 성병, 입사일, 급여 컬럼을 조회한 한글 컬렴명으로 출력 
SELECT emp_id AS 사번, emp_name AS "사 원 명", gender AS 성별, hire_date 입사일, salary AS 급여 FROM employee;
-- 별칭에 공백이 들어가는 경우 ""로 묶어주면 사용가능
-- 별칭 부여 시 AS 생략 가능

-- 사원 테이블에 ID, NAME, GENDER, HDATE, SALARY 컬럼을 조회한 한글 컬렴명으로 출력 
SELECT emp_id ID, emp_name NAME, gender GENDER, hire_date HDATE, salary SALARY FROM employee;

-- 사원 테이블의 사번, 사원명, 부서명, 폰번호, 이메일, 급여, 보너스(급여*10%)를 조회
-- 기존의 컬럼에 연산을 수행하여 새로운 컬럼을 생성할 수 있다.
SELECT emp_id, emp_name, dept_id, phone, email, salary, salary*10 AS bonus FROM employee;

-- 현재 날짜를 조회 : CURDATE()
SELECT CURDATE() AS date FROM DUAL;

/******************************************
		SELECT : 테이블 내용 상세 조회
        형식> SELECT [컬럼리스트] FROM [테이블명] WHERE [조건절];
******************************************/
-- 정주고 사원의 정보를 상세 조회 
SELECT * FROM employee WHERE emp_name = "정주고";

-- SYS 부서에 속한 모든 사원을 조회  
SELECT * FROM employee WHERE dept_id = "SYS";

-- 사번이 S0005인 사원의 사원명, 성별, 입사일, 부서_id, 이메일, 급여를 조회
SELECT emp_name, gender, hire_date, email, salary FROM employee WHERE emp_id = "S0005";

-- SYS 부서에 속한 모든 사원들을 조회, 단 출력되는 emp_id 컬럼은 "사원번호" 별칭으로 조회
SELECT emp_id AS "사원번호", emp_name, gender, hire_date, email, salary FROM employee WHERE dept_id = "SYS";

-- emp_name "사원명" 별칭 수정
SELECT emp_id AS "사원번호", emp_name AS "사원명", gender, hire_date, email, salary FROM employee WHERE dept_id = "SYS";

-- WHERE 조건절 컬럼으로 별칭을 사용할 수 있는지?
-- 사원명이 홍길동인 사원을 별칭으로 조회 :: WHERE 조건절에서 별칭을 컬럼명으로 사용불가
SELECT emp_id AS "사원번호", emp_name AS "사원명", gender, hire_date, email, salary FROM employee WHERE 사원명 = "홍길동";

-- 전략기획 부서의 모든 사원들을 사번, 사원명, 입사일, 급여를 조회
SELECT * FROM department;
SELECT * FROM employee WHERE dept_id = (SELECT dept_id FROM department WHERE dept_name = "전략기획"); -- WHERE dept_id = "STG"와 동일 

-- 입사일이 2014년 8월 1일인 사원들을 조회
SELECT * FROM employee WHERE hire_date = "2014-08-01"; -- DATE 타입은 표현은 문자열처럼, 처리는 숫자처럼 

-- 급여가 5000인 사원들을 조회
SELECT * FROM employee WHERE salary = "5000";

-- 성별이 남자인 사원들을 조회
SELECT * FROM employee WHERE gender = "M";

-- 성별이 여자인 사원들을 조회
SELECT * FROM employee WHERE gender = "F";

SELECT * FROM employee;
-- NULL : 아직 저의되지 않은 미지수
-- 숫자에서 가장 큰수로 인식, 논리적인 의미를 포함하고 있으므로 등호(=)로는 검색 불가, IS 키워드와 함께 사용 가능

-- 급여가 NULL인 값을 가진 사원들을 조회
SELECT * FROM employee WHERE salary IS NULL;

-- 영어이름이 정해해지 않은 사원들을 조회
SELECT * FROM employee WHERE eng_name IS NULL;

-- 퇴사 하지않은 사원들의 보너스 컬럼(급여*20%)을 추가하여 조회, 컬럼명은 bonus
SELECT *, (salary*20) AS bonus FROM employee WHERE retire_date IS NULL;

-- 퇴사한 사원들의 사번, 사원명, 이메일, 폰번호, 급여를 조회
SELECT emp_id, emp_name, email, phone, salary FROM employee WHERE retire_date IS NOT NULL;

-- IFNULL 함수 : NULL 값을 다른 값으로 대체하는 방법
-- 형식> IFNULL(NULL포함컬럼명, 대체값)
-- STG 부서에 속한 사원들으 정보 조회, 단, 급여가 NULL인 사원은 0으로 전환
SELECT emp_id, emp_name, email, phone, IFNULL(salary, 0) AS salary FROM employee WHERE dept_id = "STG"; -- 컬럼명이 함수로 나와서 별칭 필수

-- 사원 전체 테이블의 내용을 조회, 단 영어이름이 정해지지 않은 사원들은 "smith" 이름으로 치환
SELECT emp_id, emp_name, IFNULL(eng_name, "smith") AS eng_name, email, phone, salary FROM employee;

-- MKT 부서의 사원들은 조회, 제작중인 사원들의 retire_date 컬럼은 현재 날짜로 치환
SELECT emp_id, emp_name, IFNULL(retire_date, CURDATE()) AS retire_date, email, phone, salary FROM employee WHERE dept_id = "MKT";

/******************************************
		DISTINCT : 중복된 테이블을 배제하고 조회
        형식> SELECT DISTINCT [컬럼리스트] FROM [테이블명] WHERE [조건절];
******************************************/
-- 사원테이블의 부서리스트를 중복없이 조회
SELECT DISTINCT dept_id FROM employee; 

-- 주의 사항 UNIQUE한 컬럼과 함께 조회하는 경우 DISTINCT가 적용되지 않음
SELECT DISTINCT emp_id, dept_id FROM employee;

/******************************************
		ORDER BY : 데이터 정렬
        형식> SELECT [컬럼리스트] FROM [테이블명] WHERE [조건절] ORDER BY [컬럼명, ...] ASC/DESC;
******************************************/

-- 급여를 기준으로 오름차순 정렬
SELECT * FROM employee ORDER BY salary ASC;

-- 급여를 기준으로 내름차순 정렬
SELECT * FROM employee ORDER BY salary DESC;

-- 모든 사원을 급여, 성별을 기준으로 오름차순 정렬
SELECT * FROM employee ORDER BY salary, gender ASC;

-- eng_name이 NULL인 사원들을 입사일 기준으로 내림차순 정렬
SELECT * FROM employee WHERE eng_name IS NULL ORDER BY hire_date DESC;

-- 퇴직한 사원들을 급여기준으로 내림차순 정렬
SELECT * FROM employee WHERE retire_date IS NOT NULL ORDER BY salary DESC;

-- 퇴직한 사원들을 급여기준으로 내림차순 정렬, salary 컬럼을 "급여" 별칭으로 정렬
-- "급여" 별칭으로 ORDER BY가 가능한가? :: 별칭으로 ORDER BY 가능
-- WHERE 조건절 데이터 탐색 > 컬럼리스트 > 정렬
SELECT emp_id, emp_name, email, phone, salary AS "급여" FROM employee WHERE retire_date IS NOT NULL ORDER BY "급여" DESC;

-- SYS 부서 사원들 중 입사일이 빠른 순서, 급여를 많이 받는 순서로 정렬
-- hire_date, salary 컬럼은 "입사일", "급여" 별칭으로 컬럼리스트 생성 후 정렬
SELECT emp_id, emp_name, email, phone, salary, hire_date AS "입사일", salary AS "급여" FROM employee WHERE dept_id = "SYS" ORDER BY "입사일" ASC, "급여" DESC;

/******************************************
		조건절 + 비교연산자 : 특정 범위 혹은 데이터 검색
        형식> SELECT [컬럼리스트] FROM [테이블명] WHERE [조건절] ORDER BY [컬럼명, ...] ASC/DESC;
******************************************/
-- 급여가 5000 이상인 사원들을 조회, 급여를 오름차순
SELECT * FROM employee WHERE salary >= 5000 ORDER BY salary ASC;

-- 입사일이 2017-01-01 이후 입사한 사원들을 조회
SELECT * FROM employee WHERE hire_date >= "2017-01-01";

-- 입사일이 2015-01-01 이후이고, 급여가 6000 이상인 사원들을 조회
-- ~이거나 또는 : OR - 두 개의 조건중 하나가 만족해야만 조회 가능
SELECT * FROM employee WHERE hire_date >= "2015-01-01" OR salary >= 6000;

-- 입사일이 2015-01-01 이후이고, 급여가 6000 이상인 사원들을 조회
-- ~이고 : AND - 두 개의 조건이 모두 만족해야만 조회 가능
SELECT * FROM employee WHERE hire_date >= "2015-01-01" AND salary >= 6000;

-- 특정 기간 : 2015-01-01 ~ 2017-12-31 사이에 입사한 모든 사원 조회
-- 부서기준으로 오름차순 정렬
SELECT * FROM employee WHERE hire_date >= "2015-01-01" AND hire_date <= "2017-12-31" ORDER BY dept_id ASC;

-- 급여가 6000 이상 8000 이하인 사원들을 모두 조회
SELECT * FROM employee WHERE salary >= "6000" AND salary <= "8000" ORDER BY salary ASC;

-- MKT 부서의 사원들의 사번, 사원명, 입사일, 이메일, 급여, 보너스(급여*20%) 조회
-- 급여가 NULL인 사원의 보너스는 기본 50
-- 보너스가 1000 이상인 사원 조회
-- 보너스가 높은 사원 기준으로 정렬
SELECT emp_id, emp_name, hire_date, email, salary, IFNULL((salary*0.2), 50) AS bonus 
FROM employee 
WHERE dept_id = "MKT" AND (salary*0.2) >= "1000" 
ORDER BY bonus DESC;

-- 사원명이 "일지매", "오삼식", "김삼순" 인 사원들을 조회
SELECT *
FROM employee 
WHERE emp_name = "일지매" OR emp_name = "오삼식" OR emp_name = "김삼순"
ORDER BY emp_name ASC;

/******************************************
		논리곱(AND) : BETWEEN ~ AND
        형식> SELECT [컬럼리스트]
		     FROM [테이블명] 
             WHERE [컬럼명] BETWEEN 값1 AND 값2;
             
		논리합(OR) : IN
         형식> SELECT [컬럼리스트]
		     FROM [테이블명] 
             WHERE [컬럼명] IN (값1, 값2, 값3 ...); 
******************************************/
-- BETWEEN ~ AND
-- 특정 기간 : 2015-01-01 ~ 2017-12-31 사이에 입사한 모든 사원 조회
-- 부서기준으로 오름차순 정렬
SELECT * 
FROM employee 
WHERE hire_date BETWEEN "2015-01-01" AND "2017-12-31" 
ORDER BY dept_id ASC;

-- 급여가 6000 이상 8000 이하인 사원들을 모두 조회
SELECT * 
FROM employee 
WHERE salary BETWEEN "6000" AND "8000" 
ORDER BY salary ASC;

-- IN 
-- 사원명이 "일지매", "오삼식", "김삼순" 인 사원들을 조회
SELECT *
FROM employee 
WHERE emp_name IN ("일지매", "오삼식", "김삼순")
ORDER BY emp_name ASC;

-- 부서아이디가 MKT, SYS, STG에 속한 모든 사원 조회
SELECT *
FROM employee 
WHERE dept_id IN ("MKT", "SYS", "STG")
ORDER BY dept_id ASC;

/******************************************
		특정 문자열 검색 : 와일드 문자(%, _) + LIKE 연산자
						% : 전체, _ : 한글자
        형식> SELECT [컬럼리스트] 
			 FROM [테이블명] 
             WHERE [컬럼명] LIKE "와일드 문자 포함 검색어";
******************************************/
-- "한" 성을 가진 모든 사원 조회
SELECT *
FROM employee 
WHERE emp_name LIKE "한%";

-- 영어 이름이 "f"로 시작하는 모든 사원을 조회
SELECT *
FROM employee 
WHERE eng_name LIKE "f%";

-- 이메일 이름 중 두번째 자리에 "a"가 들어가는 모든 사원을 조회
SELECT *
FROM employee 
WHERE email LIKE "_a%";

-- 이메일 아이디가 4자인 모든 사원을 조회
SELECT *
FROM employee 
WHERE email LIKE "____@%";

/**************************************************
		내장함수 : 숫자함수, 문자함수, 날짜함수
        호출되는 위치 - [컬럼리스트], [조건절의 컬럼명]
**************************************************/
-- [숫자함수]
-- 함수 실습을 위한 테이블 : DUAL 테이블
-- (1) abs(숫자) : 절대값
SELECT abs(100), abs(-100) FROM DUAL;

-- (2) floor(숫자), truncate(숫자, 자리수) : 소수점 버리기
SELECT floor(123.456), truncate(123.456, 0) FROM DUAL; -- truncate는 소수점 몇째 자리까지 출력할지 결정가능

-- 사원테이블의 SYS 부서 사원들의 사번, 사원명, 부서아이디, 폰번호, 급여, 보너스(급여*25%) 컬럼을 추가하여 조회
-- 보너스 컬럼은 소수점 1자리로 출력
SELECT emp_id, emp_name, dept_id, phone, salary, truncate((salary*0.25), 1) AS bonus FROM employee WHERE dept_id = "SYS";

-- (3) rand() : 임의의 수를 난수로 발생시키는 함수, 0 ~ 1 사이의 난수 생성
SELECT rand() FROM DUAL;

SELECT floor(rand() * 1000) AS number FROM DUAL; -- 정수 3자리(0 ~ 999) 난수 발생

-- 정수 4자리(0 ~ 9999) 난수 발생, 소수점 2자리
SELECT truncate((rand() * 10000), 2) FROM DUAL;

-- (4) mod(숫자, 나누는수) : 나머지 함수
SELECT mod(123, 2) AS odd, mod(124,2) AS even FROM DUAL; 

-- 3자리 수를 랜덤으로 발생시켜, 2로 나누어 나머지가 홀수, 짝수로 구분
SELECT mod(floor(rand() * 1000), 2) AS result FROM DUAL;

-- [문자함수]
-- (1) concat(문자열1, 문자열2...) : 문자열 합쳐주는 함수
SELECT concat("안녕하세요", " 홍길동", " 입니다.") AS str FROM DUAL;

-- 사번, 사원명, 사원명2 컬럼을 생성하여 조회
-- S0001(홍길동) 형식으로 출력
SELECT emp_id, emp_name, concat(emp_id, "(", emp_name, ")") AS emp_name2 FROM employee;

-- 사번, 사원명 영어이름, 입사일, 폰번호, 급여를 조회
-- 영어이름의 출력형식을 "홍길동/hong" 타입으로 출력
-- 영어이름이 NULL인 경우에는 "smith"를 기본으로 조회
SELECT emp_id, emp_name, hire_date, phone, salary, concat(emp_name, "/", IFNULL(eng_name, "smith")) AS eng_name FROM employee; -- eng_name 의 값이 NULL인 튜플의 경우 concat 생성 불가

-- (2) substring(문자열, 위치, 갯수) : 문자열 추출 (공백도 한문자 처리)
SELECT substring("대한민국 홍길동", 1,4), 
       substring("대한민국 홍길동", 6,3) FROM DUAL;  -- 저장소 관련된 자리지정 외에는 1 부터 시작한다.

-- 사원 테이블의 사번, 사원명, 입사년도, 입사월, 입사일, 급여를 조회
SELECT emp_id, emp_name, substring(hire_date, 1,4) AS 입사년도, substring(hire_date, 6,2) AS 입사월, substring(hire_date, 9,2) AS 입사일, salary FROM employee;

-- 2015년도에 입사한 모든 사원 조회
SELECT * FROM employee WHERE substring(hire_date, 1,4) = "2015";

-- 2018년도에 입사한 정보시스템(SYS) 부서 사원 조회
SELECT * FROM employee WHERE substring(hire_date, 1,4) = "2018" AND dept_id = "SYS";

-- (3) left(문자열, 갯수), right(문자열, 갯수) : 왼쪽, 오른쪽 기준으로 문자열 추출
SELECT left(curdate(), 4) AS year, right("010-1234-4567", 4) AS phone FROM DUAL;

-- 2018년도에 입사한 모든 사원 조회
SELECT * FROM employee WHERE left(hire_date, 4) = "2018";

-- 2015년부터 2017년 사이에 입사한 모든 사원 조회
SELECT * FROM employee WHERE left(hire_date, 4) >= "2015" AND left(hire_date, 4) <= "2017"; -- 또는 left(hire_date, 4) BETWEEN "2015" AND "2017";

-- 사원번호, 사원명, 입사일, 폰번호, 급여를 조회
-- 폰번호는 마지막 4자리만 출력
SELECT emp_id, emp_name, hire_date, right(phone, 4), salary FROM employee;

-- (4) upper(문자열), lower(문자열) : 대문자, 소문자로 치환
SELECT upper("welcomeToMysql"), lower("welcomeToMysql") FROM DUAL;

-- 사번, 사원명, 영어이름, 부서아이디, 이메일, 급여 조회
-- 영어이름은 전체 대문자, 부서아이디는 소문자, 이메일은 대문자로 조회
SELECT emp_id, emp_name, upper(eng_name), lower(dept_id), upper(email), salary FROM employee;

-- (5) trim() : 공백 제거
SELECT trim("        대한민국") AS t1, trim("대한민국     ") AS t2, trim("대한     민국") AS t3, trim("    대한민국    ") AS t4 FROM DUAL; -- 문자열 상의 공백은 제거 불가

-- (6) format(문자열, 소수점자리) : 문자열 포멧
SELECT format(123456, 0) AS format FROM DUAL;
SELECT format("123456", 0) AS format FROM DUAL;

-- 사번, 사원명, 입사일, 폰번호, 급여, 보너스(급여의 20%)를 조회
-- 급여, 보너스는 소수점 없이 3자리 ,로 구분하여 출력
-- 급여가 NULL인 경우 기본값 0
-- 2016년부터 2017년 사이에 입사한 사원
-- 사번 기준으로 내림차순 정렬
SELECT emp_id, emp_name, hire_date, phone, format(IFNULL(salary, 0), 0) AS salary, format(IFNULL((salary*0.2), 0), 0) AS bonus -- IFNULL 먼저 실행 후 format
FROM employee
WHERE left(hire_date, 4) BETWEEN "2016" AND "2017"
ORDER BY emp_id DESC; 

-- [날짜함수]
-- curdate() : 현재 날짜(년, 월, 일)
-- sysdate(), now() : 현재 날짜(년, 월, 일, 시, 분, 초)
SELECT curdate(), sysdate(), now() FROM DUAL;

-- [형변환 함수]
-- cast(변환하고자하는 값 AS 데이터 타입)
-- convert(변환하고자하는 값 AS 데이터 타입) : MySQL에서 지원하는 OLD
SELECT 1234 AS number, cast(1234 AS char) AS string FROM DUAL;
SELECT "1234" AS string, cast("1234" AS signed integer) AS number FROM DUAL; -- signed interger라고 해야 int타입으로 바뀜
SELECT "20250723" AS string, cast("20250723" AS date) AS date FROM DUAL;
SELECT now() AS date, 
	cast(cast(now() AS char) AS date)  AS date, 
    cast(cast(now() AS char) AS datetime) AS datetime, 
    cast(curdate() as datetime) AS datetime -- curdate() 시, 분, 초는 가져오지 않는다.
FROM DUAL;

SELECT "12345" AS string,
	cast("12345" AS signed integer) AS cast_int, -- 별칭으로 int는 실제 타입언어이므로 사용 불가
    cast("12345" AS unsigned integer) AS cast_int,
    cast("12345" AS decimal(10,2)) AS cast_decimal
FROM DUAL;

-- [문자 치환 함수]
-- replace(문자열, old, new)
SELECT "홍-길-동" AS old, replace("홍-길-동", "-", ",") FROM DUAL; -- "-"을 ","로 변경 (단, 문자열만 사용가능)

-- 사원테이블의 사번, 사원명, 입사일, 퇴사일, 부서아이디, 폰번호, 급여 조회
-- 입사일, 퇴사일 출력은 "-"을 "/"로 치환하여 출력
-- 재직중인 사원은 현재날짜를 출력
-- 급여 출력시 3자리 ,로 구분
SELECT emp_id,
	emp_name, 
	replace(cast(hire_date AS char), "-", "/") AS hire_date, 
    replace(IFNULL(retire_date, curdate()), "-", "/") AS retire_date, 
    dept_id, 
    phone, 
    format(salary, 0) AS salary 
FROM employee;

-- "20150101" 입력된 날짜를 기준으로 해당 날짜 이후에 입사한 사원들을 모두 조회
-- 모든 mysql 데이터베이스에서 적용 가능한 형태로 작성
SELECT *
FROM employee
WHERE hire_date >= cast("20150101" AS date);

-- "20150101 ~ 20171231" 사이에 입사한 사원들을 모두 조회
-- 모든 mysql 데이터베이스에서 적용 가능한 형태로 작성
SELECT *
FROM employee
WHERE hire_date >= cast("20150101" AS date) AND hire_date <= cast("20171231" AS date); -- 또는 hire_date BETWEEN cast("20150101" AS date) AND cast("20171231" AS date);

/**************************************************
		그룹(집계) 함수 : sum(), avg(), min(), max(), count()...
        group by - 그룹함수를 정용하기 위한 그룹핑 컬럼 정의
        having - 그룹함수에서 사용하는 조건절
        ** 그룹함수는 그룹핑이 가능한 반복된 데이터를 가진 컬러과 사용 권장
**************************************************/
-- (1) sum(숫자) : 전체 총합을 구하는 함수
-- 사원들 전체의 급여 총액을 조회, 3자리 구분, 마지막 "만원" 표시
SELECT concat(format(sum(salary), 0), "만원") AS "총급여" FROM employee;

SELECT emp_id, sum(salary) FROM employee; -- sum은 salary 튜플값의 그룹핑이므로 유니크한 emp_id의 튜플들을 호출할 수 없다.

-- (2) avg(숫자) : 전체 평귱을 구하는 함수
-- 사원들 전체의 급여 평균을 조회, 3자리 구분, 앞에 "$" 표시
SELECT concat("$", format(avg(salary), 0)) AS 급여평균 FROM employee;

-- 정보시스템(SYS) 부서 전체의 급여 총액과 평균을 조회
-- 3자리 구분, 마지막 "만원" 표시
SELECT concat(format(sum(salary), 0), "만원") AS "급여총액", 
	concat(format(avg(salary), 0), "만원") AS "급여평균" 
FROM employee 
WHERE dept_id = "SYS";

-- (3) max(숫자) : 최대값 구하는 함수
-- 가장 높은 급여를 받는 사원의 급여를 조회
SELECT max(salary) FROM employee;

-- (4) min(숫자) : 최소값 구하는 함수
-- 가장 낮은 급여를 받는 사원의 급여를 조회
SELECT min(salary) FROM employee;

-- 사원들의 총급여, 평균급여, 최대급여, 최소급여를 조회
SELECT 
	format(sum(salary), 0) AS "총급여", 
	format(avg(salary), 0) AS "평균급여", 
	format(max(salary), 0) AS "최대급여", 
    format(min(salary), 0) AS "최소급여" 
FROM employee;

-- (5) count(컬럼) : 조건에 맞는 데이터의 row 수를 조회, NULL은 카운트하지 않는다
-- 전체 row count
SELECT count(*) FROM employee; -- 20
-- 급여 컬럼의 row count
SELECT count(salary) FROM employee; -- 19

-- 재직중인 사원과 퇴사한 사원의 row count
SELECT count(*) - count(retire_date) AS 재직사원, count(retire_date) AS 퇴사사원 FROM employee;

-- "2015"년도에 입사한 입사자 수
SELECT count(*) FROM employee WHERE left(hire_date, 4) = "2015"; 

-- 정보시스템(SYS) 부서의 사원수
SELECT count(*) FROM employee WHERE dept_id = "SYS"; 

-- 가장 빠른 입사자, 가장 늦은 입사자를 조회 : max(), min() 함수를 이용
SELECT min(hire_date), max(hire_date) FROM employee;

-- 가장 빨리 입사한 사람의 정보를 조회 : 서브쿼리로 그룹함수 사용
SELECT * FROM employee WHERE hire_date = (SELECT min(hire_date) FROM employee);

-- [grounp by] : 그룹함수와 일반컬럼을 함께 사용할 수 있도록 함
-- ~별 그룹핑이 가능한 컬럼으로 쿼리를 실행
SELECT dept_id, sum(salary), avg(salary), count(*) -- 부서별 총급여, 부서별 급여평균, 부서별 인원수 등으로 group by한 컬럼을 기준으로 출력 
FROM employee
GROUP BY dept_id; -- group by로 유니크 컬럼을 묶어주면 sum() 그룹함수 사용 가능

-- 연도별, 총급여, 평균급여, 사원수, 최대급여, 최소급여 조회
-- 소수점 x, 3자리 구분
SELECT 
	left(hire_date, 4) AS "연도", 
	format(sum(salary), 0) AS "총급여", 
    format(avg(salary), 0) AS "평균급여", 
    count(*) AS "사원수", 
    format(max(salary), 0) AS "최대급여", 
    format(min(salary), 0) AS "최소급여" 
FROM employee 
GROUP BY left(hire_date, 4);

-- [having 조건절] : 그룹함수를 적용한 결과에 조건을 추가
-- 부서별 총급여, 평균급여를 조회
-- 부서의 총급여가 30000 이상인 부서만 출력
-- 급여 컬럼의 NULL은 제외
SELECT dept_id, sum(salary), avg(salary) FROM employee WHERE salary IS NOT NULL GROUP BY dept_id HAVING sum(salary) >= "30000";

-- 연도별, 총급여, 평균급여, 사원수, 최대급여, 최소급여 조회
-- 소수점 x, 3자리 구분
-- 총급여가 30000 이상인 부서
-- 급여 협상이 안된 사원은 제외
SELECT 
	left(hire_date, 4) AS "연도", 
	format(sum(salary), 0) AS "총급여", 
    format(avg(salary), 0) AS "평균급여", 
    count(*) AS "사원수", 
    format(max(salary), 0) AS "최대급여", 
    format(min(salary), 0) AS "최소급여" 
FROM employee 
WHERE salary IS NOT NULL
GROUP BY left(hire_date, 4)
HAVING sum(salary) >= 30000;

-- ROLLUP 함수 : 리포팅을 위한 함수 (전체 통계도 보여주는거임 ex) 20명의 총급여, 평균급여)
-- 부서별 사원수, 총급여, 평균급여 조회
SELECT dept_id, count(*), sum(IFNULL(salary, 0)), avg(IFNULL(salary, 0)) FROM employee GROUP BY dept_id WITH ROLLUP;

-- ROLLUP한 결과의 부서아이디를 정의
SELECT if(grouping(dept_id) , "총합계", IFNULL(dept_id, "-")) AS dept_id, count(*), sum(IFNULL(salary, 0)), avg(IFNULL(salary, 0)) FROM employee GROUP BY dept_id WITH ROLLUP;
-- grouping(left(hire_date, 4)) 이런식으로 grouping안에 함수를 넣으면 실행되지 않는다.

-- limit 함수 : 출력갯수 제한 함수
SELECT * FROM employee
limit 3; -- 출력기준 3개만 출력

-- 급여 기준 5순위 출력
SELECT * FROM employee
ORDER BY salary DESC
limit 5;

/*****************************************************
	조인(JOIN) : 두개 이상의 테이블을 묶어서 SQL을 진행
    ERD(Entity Relationship Diagrem) : 데이터베이스 구조도(설계도)
    - 데이터 모델링 : 정규화 과정
    
    ** ANSI SQL : 모든 데이터베이스 시스템들의 표준 SQL
    조인(JOIN) 종류
    (1) CROSS JOIN(오라클에서는 CATEISIAN JOIN이라고 부름) - 합집합 : 테이블들의 데이터 전체를 JOIN - 테이블A(10개 데이터) * 테이블B(10개 데이터) = (100개 데이터)
    (2) INNER JOIN(NATURAL JOIN) - 교집합 : 두 개 이상의 테이블을 JOIN 연결고리를 통해 JOIN 실행
    (3) OUTER JOIN - 차집합 : INNER JOIN + 선택한 테입블의 JOIN 제외 ROW 포함
    (4) SELF JOIN : 한 테이블을 두 개 테이블처럼 JOIN 실행
    
*****************************************************/
USE hrbd2019;
SELECT database();
SELECT * FROM employee;
SELECT * FROM department;

-- CROSS JOIN
SELECT *
FROM employee, department; -- ,로 JOIN 가능 (전통 방식)

SELECT *
FROM employee CROSS JOIN department; -- C++에서는 이런식으로 선언해줘야 JOIN 가능 (ansi 타입 방식)
-- ※ 개인적으로 선언해주는게 안전하다고 봄

--
SELECT * FROM vacation; -- 102

-- 사원, 부서, 휴가 테이블 CROSS JOIN : 20 * 7 * 102
SELECT count(*) 
FROM 
	employee 
    CROSS JOIN department 
    CROSS JOIN vacation;
 
 -- INNER JOIN
 SELECT *
 FROM
	employee
    INNER JOIN department
WHERE employee.dept_id = department.dept_id
ORDER BY emp_id;

-- 사원테이블, 부서테이블, 본부테이블 INNER JOIN 
SELECT *
FROM 
	employee AS e
    INNER JOIN department AS d
    INNER JOIN unit AS u 
WHERE -- 또는 ON 
	e.dept_id = d.dept_id 
	AND d.unit_id = u.unit_id
ORDER BY e.emp_id;

-- 사원테이블, 부서테이블, 본부테이블, 휴가테이블 INNER JOIN 
SELECT *
FROM 
	employee AS e
    INNER JOIN department AS d
    INNER JOIN unit AS u 
    INNER JOIN vacation AS v 
WHERE -- 또는 ON 	
	e.dept_id = d.dept_id 
	AND d.unit_id = u.unit_id    
    AND e.emp_id = v.emp_id
ORDER BY e.emp_id;

-- 모든 사원들의 사번, 사원명, 부서아이디, 부서명, 입사일, 급여를 조회
SELECT 
	e.emp_id, 
    e.emp_name, 
    e.dept_id, 
    d.dept_name, 
    e.hire_date, 
    e.salary
FROM 
	employee AS e 
	INNER JOIN department AS d
WHERE e.dept_id = d.dept_id;

-- 영업부에 속한 사원들의 사번, 사원명, 입사일, 퇴사일, 폰번호, 급여, 부서아이디, 부서명 조회
SELECT 
	e.emp_id, 
    e.emp_name, 
    e.hire_date,
    e.retire_date,
    e.phone,
    e.salary,
	e.dept_id,
	d.dept_name
FROM 
	employee AS e 
	INNER JOIN department AS d
WHERE 
	e.dept_id = d.dept_id
	AND d.dept_name = "영업"
ORDER BY e.emp_id;

-- 인사과에 속한 사원들 중에 휴가를 사용한 사원들의 내역을 조회
SELECT *
FROM 
	employee AS e 
	INNER JOIN department AS d
    INNER JOIN vacation AS v
WHERE 
	e.dept_id = d.dept_id
    AND e.emp_id = v.emp_id
	AND d.dept_name = "인사"
ORDER BY e.emp_id;

-- 영업부서 사원의 사원명, 폰번호, 부서명, 휴가사용 이유 조회
-- 휴가 사용 이유가 "두통"인 사원, 소속본부 조회
SELECT 
	e.emp_name,
    e.phone,
    d.dept_name,
    v.reason,
    u.unit_name
FROM
	employee AS e
	INNER JOIN department AS d
    INNER JOIN vacation AS v
    INNER JOIN unit AS u
WHERE
	e.emp_id = v.emp_id
	AND e.dept_id = d.dept_id
    AND u.unit_id = d.unit_id
	AND v.reason = "두통"
ORDER BY e.emp_id;

-- 2014년부터 2016년까지 입사한 사원들 중에서 퇴사하지 않은 사원들의
-- 사원 아이디, 사원명, 부서명, 입사일, 소속본부를 조회
-- 소속본부 기준으로 오름차순 정렬
SELECT 
	e.emp_id,
    e.emp_name,
    d.dept_name,
    e.hire_date,
    u.unit_name
FROM
	employee AS e
    INNER JOIN department AS d
    INNER JOIN unit AS u
WHERE
	e.dept_id = d.dept_id
    AND u.unit_id = d.unit_id
	AND left((e.hire_date), 4) >= "2014" AND left((e.hire_date), 4) <= "2016" -- 또는 left((e.hire_date), 4) BETWEEN "2014" AND "2016"
    AND e.retire_date IS NULL
ORDER BY u.unit_name ASC;

-- 부서별 총급여, 평균급여, 총휴가사용일수를 조회
-- 부서명, 부서아이디, 총급여, 평균급여, 휴가사용일수
SELECT 
	d.dept_name,
    d.dept_id,
	sum(e.salary),
    avg(e.salary),
    sum(v.duration)
FROM
	employee AS e
    INNER JOIN department AS d
    INNER JOIN vacation AS v
WHERE
	e.emp_id = v.emp_id
    AND d.dept_id = e.dept_id
GROUP BY 
	d.dept_id, 
    d.dept_name;

-- 본부별 부서의 휴가사용 일수
SELECT 
	u.unit_name,
	d.dept_name,
    d.dept_id,
    sum(v.duration)
FROM
	employee AS e
    INNER JOIN department AS d
    INNER JOIN vacation AS v
    INNER JOIN unit AS u
WHERE
	e.emp_id = v.emp_id
    AND d.dept_id = e.dept_id
    AND u.unit_id = d.unit_id
GROUP BY 
	d.dept_id, 
    d.dept_name,
    u.unit_name;
    
-- OUTER JOIN : INNER JOIN + 조인에서 제외된 ROW(테이블)
-- 오라클 형식의 OUTER JOIN은 사용불가, ANSI SQL 형식 사용 가능
-- SELECT [컬럼리스트] 
-- FROM [테이블1 테이블별칭] LEFT/RIGHT OUTER JOIN 테이블명2 [테이블별칭], ...]
-- ON [테이블명1.조인컬럼 = 테이블명2.조인컬럼]

-- ** 오라클 형식 OUTER JOIN (MYSQL에서는 사용불가)
-- SELECT * FROM table1 t1, table t2
-- WHERE t1.col(+) = t2.col; 

-- 모든 부서의 부서아이디, 부서명, 본부명을 조회
SELECT d.dept_id, d.dept_name, ifnull(u.unit_name, "협의중") AS unit_name 
FROM 
	department AS d
    LEFT OUTER JOIN unit AS u
	ON d.unit_id = u.unit_id -- WHERE 사용 불가
ORDER BY u.unit_name;

-- 본부별, 부서의 휴가사용 일수 조회
-- 부서의 누락없이 모두 출력
SELECT DISTINCT
    u.unit_name,
    d.dept_name,
    count(v.duration)    
FROM
	employee AS e
	LEFT OUTER JOIN vacation AS v
    ON e.emp_id = v.emp_id -- AND가 아니고 ON 사용해야함 -- JOIN 선언 후 ON 작성방식 지켜야 출력가능
	RIGHT OUTER JOIN department AS d 
    ON d.dept_id = e.dept_id 
    LEFT OUTER JOIN unit AS u
	ON u.unit_id = d.unit_id   
GROUP BY u.unit_name, d.dept_name    
ORDER BY u.unit_name DESC;

-- 2017년부터 2018년도까지 입사한 사원들의 사원명, 입사명, 연봉, 부서명 조회해주세요.
-- 단, 퇴사한 사원들 제외
-- 소속본부를 모두 조회
SELECT 
	e.emp_name,
    e.hire_date,
	e.salary,
    d.dept_name,
    u.unit_name
FROM 
	employee AS e
    INNER JOIN department AS d
    ON e.dept_id = d.dept_id
    LEFT OUTER JOIN unit AS u
    ON d.unit_id = u.unit_id
WHERE 
	left(e.hire_date, 4) BETWEEN "2017" AND "2018"
    AND e.retire_date IS NULL;

-- SELF JOIN : 자기 자신의 테이블을 JOIN
-- SELF JOIN은 서브쿼리 형태로 실행하는 경우가 많다.
-- SELECT [컬럼리스트] FROM [테이블1], [테이블2] WHERE [테이블1.컬럼명] = [테이블2.컬럼명]
-- 사원테이블을 SELF JOIN
SELECT 
	e.emp_id, 
    e.emp_name,
    m.emp_id, 
    m.emp_name
FROM 
	employee AS e, 
    employee AS m
WHERE e.emp_id = m.emp_id;

-- 서브쿼리 형태
SELECT 
	emp_id, 
    emp_name
FROM 
	employee 
WHERE emp_id = (SELECT emp_id FROM employee WHERE emp_name = "홍길동");

/************************************************************
	서브쿼리(SubQuery) : 메인 쿼리에 다른 쿼리를 추가하여 실행하는 방식
    형식 :  SELECT [컬럼리스트 : (스칼라 서브쿼리)] //사용 권장 X 사용 빈도 ↓
		   FROM [테이블명 : (인라인뷰)] 
           WHERE [조건절 : (서브쿼리)]
************************************************************/
USE hrdb2019;
SELECT database();
SHOW TABLES;

-- [서브쿼리]
-- 정보시스템 부서명의 사원들을 모두 조회
-- 사번, 사원명, 부서아이디, 폰번호, 급여
SELECT 
	emp_id, 
    emp_name, 
    dept_id, 
    phone, 
    salary
FROM employee
WHERE dept_id = (SELECT dept_id 
				 FROM department 
                 WHERE dept_name = "정보시스템");

-- [스칼라 서브쿼리]
-- 정보시스템 부서명의 사원들을 모두 조회
-- 사번, 사원명, 부서아이디, 부서명(부서테이블), 폰번호, 급여
SELECT 
	emp_id, 
    emp_name, 
	dept_id, 
    (SELECT dept_name FROM department WHERE dept_name = "정보시스템") AS dept_name,
    phone, 
	salary
FROM 
	employee 
WHERE dept_id = (SELECT dept_id 
				 FROM department 
                 WHERE dept_name = "정보시스템");

-- 홍길동 사원이 속한 부서명을 조회
SELECT dept_name
FROM department
WHERE dept_id = (SELECT dept_id -- 조건에 맞는 컬럼명 필수
				 FROM employee 
                 WHERE emp_name = "홍길동");
				
-- 홍길동 사원의 휴가사용 내역을 조회
SELECT *
FROM vacation
WHERE emp_id = (SELECT emp_id 
				FROM employee 
                WHERE emp_name = "홍길동");
                
-- 제3본부에 속한 모든 부서를 조회
SELECT *
FROM department
WHERE 
	unit_id = (SELECT unit_id FROM unit WHERE unit_name = "제3본부");
    
-- 급여가 가장 높은 사원의 정보를 조회
SELECT *
FROM employee
WHERE salary = (SELECT max(salary)
				FROM employee);

-- 급여가 가장 낮은 사원의 정보를 조회
SELECT *
FROM employee
WHERE salary = (SELECT min(salary)
				FROM employee);
                
-- 가장 빨리 입사한 사원의 정보 조회
SELECT *
FROM employee
WHERE hire_date = (SELECT min(hire_date)
					FROM employee);

-- 가장 늦게 입사한 사원의 정보 조회
SELECT *
FROM employee
WHERE hire_date = (SELECT max(hire_date)
					FROM employee);

-- [서브쿼리 : 다중행 - IN]                    
-- 제3본부에 속한 모든 사원 정보 조회
SELECT *
FROM employee
WHERE dept_id IN (SELECT dept_id
				  FROM department
				  WHERE unit_id = (SELECT unit_id 
								  FROM unit 
								  WHERE unit_name = "제3본부"));

-- "제3본부" 속한 모든 사원들의 휴가 사용 내역 조회
SELECT *
FROM vacation
WHERE emp_id IN (SELECT emp_id
				FROM employee
				WHERE dept_id IN (SELECT dept_id
								  FROM department
								  WHERE unit_id = (SELECT unit_id 
												  FROM unit 
												  WHERE unit_name = "제3본부")));
                                                  
-- [인라인뷰 : 메인쿼리의 테이블 자리에 들어가는 서브쿼리 형식]

-- [휴가를 사용한 사원정보만] 사원별 휴가사용 일수를 그룹핑하여, 사원아이디, 사원명,
-- 입사일, 연봉, 휴가사용일수를 조회

SELECT e.emp_id, e.emp_name, e.hire_date, e.salary, v.duration AS duration
FROM employee AS e
	 INNER JOIN (SELECT 
					emp_id,
					sum(duration) AS duration
				 FROM vacation
				 GROUP BY emp_id) v
ON e.emp_id = v.emp_id;

-- [휴사를 사용한 사원정보 + 사용하지 않은 사원 포함]
-- 사원별 휴가사용 일수를 그룹핑하여, 사원아이디, 사원명, 입사일, 연봉, 휴가사용일수 조회
-- 휴가를 사용하지 않은 사원은 기본값 0
-- 사용일수 기준 내림차순
-- LEFT OUTER JOIN
SELECT 
	e.emp_id, 
    e.emp_name, 
    e.hire_date, 
    e.salary, 
    ifnull(v.duration, 0) AS duration
FROM 
	employee AS e 
	LEFT OUTER JOIN	(SELECT 
					emp_id,
					sum(duration) AS duration
					FROM vacation
					GROUP BY emp_id) v
	ON e.emp_id = v.emp_id
ORDER BY duration DESC;

-- [2016 ~ 2017년도 입사한 사원들의 정보 조회]
-- 1번의 실행 결과와 vacation 테이블을 조인하여 휴가사용 내역 출력
SELECT *
FROM vacation AS v
	INNER JOIN (SELECT *
				FROM employee
				WHERE left(hire_date, 4) BETWEEN "2016" AND "2017") AS e
	ON e.emp_id = v.emp_id;
    
-- 부서별 총급여, 평균급여를 구하여 30000 이상인 부서 조회
-- 1번의 실행 결과와 employee 테이블을 조인하여 사원아이디, 사원명, 급여, 부서아이디, 부서명 / 부서별 총급여, 평균급여 출력
SELECT 
	e.emp_id, 
	e.emp_name, 
    e.salary, 
    e.dept_id, 
    d.dept_name, 
    t.sum, 
    t.avg
FROM employee AS e
	INNER JOIN department AS d
    ON e.dept_id = d.dept_id 
    INNER JOIN (SELECT 
					dept_id,	
					sum(salary) AS sum,
					avg(salary) AS avg
				FROM employee 
				GROUP BY dept_id
				HAVING sum(salary) >= 30000) AS t
	ON d.dept_id = t.dept_id;

/**************************************************
	테이블 결과 합치기 : union, union all
    형식> 쿼리1 실행 결과 union 쿼리2 실행 결과
		 쿼리1 실행 결과 union all 쿼리2 실행 결과
	** 실행결과 컬럼이 동일(컬럼명, 데이터타입)
**************************************************/
-- 영업부, 정보시스템 부서의 사원아이디, 사원명, 급여, 부서아이디 조회
-- union : 영업 부서 사원들이 한번만 출력
-- union all : 영업 부서 사원들이 중복되어 출력
-- union은 컬럼의 개수 데이터 타입 모두 같아야 사용가능
-- union은 join, 서브쿼리 등을 먼저 해보고 해결이 안되거나, union에 비해 실행속도가 너무 느리면 그때 사용한다.
SELECT emp_id, emp_name, salary, dept_id
FROM employee
WHERE dept_id = (SELECT dept_id FROM department WHERE dept_name = "영업")
UNION ALL -- 중복되는 ROW도 전부 출력
SELECT emp_id, emp_name, salary, dept_id
FROM employee
WHERE dept_id = (SELECT dept_id FROM department WHERE dept_name = "영업") -- ;
UNION -- 중복되는 ROW는 삭제해서 출력
SELECT emp_id, emp_name, salary, dept_id
FROM employee
WHERE dept_id = (SELECT dept_id FROM department WHERE dept_name = "정보시스템");

/*************************************************************
	논리적인 테이블 : VIEW(뷰), SQL을 실행하여 생성된 결과를 가상테이블로 정의
    뷰 생성 : CREATE VIEW [뷰명]
			AS [SQL 정의];
	뷰 삭제 : DROP VIEW [VIEW 이름]
	** 뷰 생성시 권한을 할당을 받아야 함 - MYSQL, MARIA 제외
    -- 하지만 뷰는 가상 테이블로 메모리를 많이 잡아먹기 때문에 사용권장 X
    -- 뷰를 아예 생성못하게 막아놓는 회사도 있음
**************************************************************/
SELECT *
FROM information_schema.views
WHERE table_schema = "hedb2019";

-- 부서 총급여가 30000 이상인 테이블
CREATE VIEW view_salary_sum
AS
SELECT 
	e.emp_id, 
	e.emp_name, 
    e.salary, 
    e.dept_id, 
    d.dept_name, 
    t.sum, 
    t.avg
FROM employee AS e
	INNER JOIN department AS d
    ON e.dept_id = d.dept_id 
    INNER JOIN (SELECT 
					dept_id,	
					sum(salary) AS sum,
					avg(salary) AS avg
				FROM employee 
				GROUP BY dept_id
				HAVING sum(salary) >= 30000) AS t
	ON d.dept_id = t.dept_id;
    
-- view_salary_sum 실행
SELECT *
FROM view_salary_sum;

-- view_salary_sum 삭제
DROP VIEW view_salary_sum;
SELECT * FROM information_schema.views
where table_schema = "hrdb2019";

/*****************************************
	DDL(Data Definition Language) : 생성, 수정, 삭제 - 테이블 기준
    DML : C(insert), R(select), U(update), D(delete) 
*****************************************/
-- 모든 테이블 목록
SHOW TABLES;

-- [테이블 생성]
-- 형식> CREATE TABLE [테이블명] (
-- 			컬럼명	데이터타입(크기),
-- 			....
-- 		);
-- 데이터 타입 : 정수형(int, long..), 실수형(float, double), 문자형(char, varcher, longtext...)
-- 			  이진데이터(longblob)..
-- char(고정형 문자형) : 크기가 메모리에 고정되는 형식 ex) char(10) -> 3자리 입력 : 7자리 낭비
-- varchar(가변형 문자형) : 실제 저장되는 데이터 크기에 따라 메모리가 변경되는 형식
-- 						varchar(10) -> 3자리 입력 : 메모리 실제 3자리 공간만 생성
-- longtext : 문장형태로 다수의 문자열을 저장
-- longblob : 이진데이터 타입의 이미지, 동영상 등 데이터 저장
-- date : 년, 월, 일 -> curdate()
-- datetime : 년, 월, 일, 시, 분, 초 -> sysdate(), now()

DESC employee; -- 데이터 타입 보는 명령어
SELECT * FROM employee;

-- emp 테이블 생성
-- emp_id : (char, 4), ename : (varchar, 10), gender : (char, 1), hire_date : (datetime), salary : (int)
SHOW TABLES;
CREATE TABLE emp(
	emp_id    char(4),
    ename     varchar(10),
    gender    char(1),
    hire_date datetime,
    salary    int
);

SELECT * FROM information_schema.TABLES
WHERE table_schema = "hrdb2019";

DESC emp;

-- [테이블 삭제]
-- 형식 : DROP TABLE [테이블명]
SHOW TABLES;
DROP TABLE emp;

-- [테이블 복제]
-- 형식 : CREATE TABLE [테이블명]
-- 		 AS [SQL 정의]

-- employee 테이블을 복제하여 emp 테이블 생성
CREATE TABLE emp
AS 
SELECT *
FROM employee;

SHOW TABLES;
DESC employee; 
DESC emp; -- employee를 복제하였지만 제약사항은 복제되지 않는다.

-- 2016년도에 입사한 사원의 정보를 복제 : employee_2016
CREATE TABLE employee_2016
AS
SELECT *
FROM employee
WHERE left(hire_date, 4) = "2016";

SHOW TABLES;
SELECT *
FROM employee_2016;

/*+++++++++++++++++++++++++++++++++++++++++++
	데이터 생성(insert : C)
	형식> insert into [테이블명] {컬럼리스트...} 
		 values(데이터1, 데이터2 ...)
++++++++++++++++++++++++++++++++++++++++++++*/
SHOW TABLES;
CREATE TABLE emp(
	emp_id    char(4),
    ename     varchar(10),
    gender    char(1),
    hire_date datetime,
    salary    int
);

SELECT * FROM information_schema.TABLES
WHERE table_schema = "hrdb2019";
DROP TABLE emp;
DESC emp;

SELECT * 
FROM employee;

INSERT INTO emp(emp_id, ename, gender, hire_date, salary)
VALUES("s001", "홍길동", "m", now(), "3000");

INSERT INTO emp(ename, emp_id, gender, salary, hire_date) -- 컬럼의 순서가 달라도 타입과 입력수가 같은면 상관없으나, 타입과 입력수가 다르면 에러
VALUES("s001", "홍길동", "m", "1000", NULL); -- CREATE시 NULL값 허용 여부에 따라 생성가능

INSERT INTO emp(emp_id)
VALUES("s002");

SELECT * 
FROM emp;

-- [테이블 절삭 : 테이블으 데이터만 영구삭제]
-- 형식> TRUNCATE TABLE [테이블명];
TRUNCATE TABLE emp;
SELECT * FROM emp;
DROP TABLE emp;
SHOW TABLES;

CREATE TABLE emp(
	emp_id    char(4)     NOT NULL,
    ename     varchar(10) NOT NULL,
    gender    char(1)     NOT NULL,
    hire_date datetime,
    salary    int         
);
DESC emp;

INSERT INTO emp(emp_id, ename, gender, hire_date, salary)
VALUES("s001", "홍길동", "m", now(), "1000");

INSERT INTO emp
VALUES("s002", "이순신", "m", sysdate(), "2000");

INSERT INTO emp
VALUES("s003", "김유신", "m", curdate(), "3000"); -- curdate()는 날짜만 나오므로 시, 분, 초는 00으로 출력

SELECT *
FROM emp;

-- [자동 행번호 생성 : auto_increment]
-- 정수형으로 번호를 생성하여 저장함, PK, UNIQUE 제약으로 설정된 컬럼에 주로 사용
CREATE TABLE emp2(
	emp_id 	  INT         AUTO_INCREMENT PRIMARY KEY, -- PRIMARY KEY : UNIQUE + NOT NULL
    ename     VARCHAR(10) NOT NULL,
    gender    CHAR(1)     NOT NULL,
    hire_date DATE,
    salary    INT
);

DESC emp2;
SHOW TABLES;

INSERT INTO emp2(ename, gender, hire_date, salary) -- KEY는 지정안해줘도 자동 생성
VALUES("홍길동", "m", now(), "2000"); 

SELECT *
FROM emp2;

/********************************************
	테이블 변경 : alter table
    형식> alter table [테이블명]
			add column [새로추가하는 컬럼명, 데이터타입] -- NULL 허용
            modify column [변경하는 컬럼명, 데이터타입] -- 크기 고려
            drop column [삭제하는 컬럼명]
*********************************************/
SHOW TABLES;
SELECT * FROM emp;

-- phone(char, 13) 컬럼 추가, NULL 허용
ALTER TABLE emp
	ADD COLUMN phone CHAR(13); 

INSERT INTO emp
	VALUES("s004", "홍홍", "f", now(), 4000, "010-1234-1234");
  
-- phone 컬럼의 크기 변경 : CHAR(13) -> CHAR(10)
ALTER TABLE emp
	MODIFY COLUMN phone CHAR(10) NULL; -- 저장된 데이터보다 크기가 작으면 에러 발생; 데이터 유실 위험 발생

-- phone 컬럼 삭제
ALTER TABLE emp
	DROP COLUMN phone;

DESC emp;
SELECT * FROM emp;

/*******************************************
	데이터 수정(update : U)
    형식> update set [테이블명]
			set [컬럼리스트...]
			where [조건절 ~]
	** set sql_safe_updates = 1 or 0; // default값이 1이다.
	   -- 1 : 업데이트 불가, 0 : 업데이트 가능 
********************************************/

SET sql_safe_updates = 0; -- 업데이트 모드 해제

-- 홍길동의 급여를 6000으로 수정
UPDATE emp
	SET salary = 6000
    WHERE emp_id = "s001";

-- 김유신의 입사날짜를 "20210725"로 수정
update emp
	SET hire_date = cast("20210725" AS datetime)
    WHERE emp_id = "s003";

DESC emp;  
  
SELECT *
FROM emp;

-- emp2 테이블에 retire_date 컬럼 추가 : DATE
-- 기존 데이터는 현재 날짜로 업데이트
-- 업데이트 완료 후 retire_date "NOT NULL"로 설정 변경
ALTER TABLE emp2
	ADD COLUMN retire_date DATE NULL;

UPDATE emp2
	SET retire_date = curdate()
	WHERE retire_date IS NULL;

ALTER TABLE emp2
	MODIFY COLUMN retire_date DATE NOT NULL; -- NULL 값이 없는 상태여야 NOT NULL 선언 가능

DESC emp2;  
  
SELECT *
FROM emp2;

/****************************************
	데이터 삭제(DELETE : D)
    형식> DELETE FROM [테이블명]
			WHERE [조건절 ~]
	** set sql_safe_updates = 1 or 0; // default값이 1이다.
	   -- 1 : 업데이트 불가, 0 : 업데이트 가능 
*****************************************/

-- 이순신 사원 삭제
DELETE FROM emp
	WHERE emp_id = "s002"; -- DELETE는 복원이 가능하다 (TRUNCATE는 데이터 전부삭제 복원 불가능)

-- s004 사원 삭제
DELETE FROM emp
	WHERE emp_id = "s004"; 

SELECT @@autocommit; -- 이 명령어로 autocommit설정 가능
SET autocommit = 0;

ROLLBACK;

SELECT * 
FROM emp;