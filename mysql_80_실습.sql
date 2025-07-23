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