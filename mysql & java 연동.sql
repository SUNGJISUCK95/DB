use hrdp2019;
select database();

select emp_id, emp_name, dept_id, salary
from employee;

select 
	row_number() over() AS rno,
    emp_id, emp_name, dept_id, salary FROM employee WHERE dept_id = 'SYS';
    
--
SELECT * FROM employee;
SELECT emp_id, emp_name, salary, (salary*0.2) AS "bonus" FROM employee;
DESC employee;

--
SELECT
    dept_id,
	dept_name,
	unit_id,
	start_date
From department;
DESC department;

--

INSERT INTO member(name, email)
			values("김유신", "kim@test.com");
DESC member;
SELECT * FROM member;
SELECT member_id,
	name,
    email,
    created_at
FROM member
WHERE name = "홍길동";

SELECT * FROM member;

--  private int rno;
-- 	private String mid;
-- 	private String name;
-- 	private String department;
-- 	private int kor;
-- 	private int eng;
-- 	private int math;
-- 	private String mdate;

CREATE TABLE score_member(
    mid        char(5)      PRIMARY KEY, -- "M0001" 형식의 트리거 적용
    name       varchar(10)  NOT NULL,
    department varchar(20),
    kor        decimal(6,2) DEFAULT 0.0,
    eng        decimal(6,2) DEFAULT 0.0,
    math 	   decimal(6,2) DEFAULT 0.0,
    mdate      datetime
);

SHOW TABLES;

-- 트리거 생성

/**************** TRIGGRER 시작 ******************/
DELIMITER $$

CREATE TRIGGER trh_score_member_mid
BEFORE INSERT ON score_member
FOR EACH ROW 
BEGIN
    DECLARE max_code INT;

    SELECT IFNULL(MAX(CAST(RIGHT(mid, 4) AS UNSIGNED)), 0)
    INTO max_code
    FROM score_member;

    SET NEW.mid = CONCAT('M', LPAD((max_code + 1), 4, '0'));
END$$

DELIMITER ;
/**************** TRIGGRER 끝 ******************/

SELECT count(*) FROM score_member; -- 행개수 size()에 값 전달시 사용 sql
SELECT mid, name, department, kor, eng, math, mdate
FROM score_member;

DESC score_member;
SELECT * FROM score_member;
SELECT * FROM information_schema.triggers;

