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