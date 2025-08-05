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


/********************도서 관리 시스템***********************/

-- private String id;
-- private String name;
-- private String author;
-- private int price;

-- 교육기관

CREATE TABLE book_tj(
	bid    char(4)     PRIMARY KEY,
    btitle varchar(50) NOT NULL,
    author varchar(10) ,
    price  int,
    isbn   int,
    bdate  datetime
);

/**************** TRIGGRER 시작 ******************/
DELIMITER $$

CREATE TRIGGER trh_book_tj_bid
BEFORE INSERT ON book_tj
FOR EACH ROW 
BEGIN
    DECLARE max_code INT;

    SELECT IFNULL(MAX(CAST(right(bid,3) AS UNSIGNED)), 0)
    INTO max_code
    FROM book_tj;

    SET NEW.bid = CONCAT('B', LPAD((max_code + 1), 3, '0'));
END$$

DELIMITER ;
/**************** TRIGGRER 끝 ******************/

DESC book_tj;
SELECT * FROM book_tj;
SELECT * FROM information_schema.triggers;

-- 교육기관 끝

-- 예스24

CREATE TABLE book_yes24(
	bid    char(4)     PRIMARY KEY,
    btitle varchar(50) NOT NULL,
    author varchar(10),
    price  int,
    isbn   int,
    bdate  datetime
);

/**************** TRIGGRER 시작 ******************/
DELIMITER $$

CREATE TRIGGER trh_book_yes24_bid
BEFORE INSERT ON book_yes24
FOR EACH ROW 
BEGIN
    DECLARE max_code INT;

    SELECT IFNULL(MAX(CAST(right(bid, 3) AS UNSIGNED)), 0)
    INTO max_code
    FROM book_yes24;

    SET NEW.bid = CONCAT('B', LPAD((max_code + 1), 3, '0'));
END$$

DELIMITER ;
/**************** TRIGGRER 끝 ******************/

DESC book_yes24;
SELECT * FROM book_yes24;
SELECT * FROM information_schema.triggers;

-- 예스24 끝

-- 알라딘

CREATE TABLE book_aladin(
	bid    char(4)     PRIMARY KEY,
    btitle varchar(50) NOT NULL,
    author varchar(10),
    price  int,
    isbn   int,
    bdate  datetime
);

/**************** TRIGGRER 시작 ******************/
DELIMITER $$

CREATE TRIGGER trh_book_aladin_bid
BEFORE INSERT ON book_aladin
FOR EACH ROW 
BEGIN
    DECLARE max_code INT;

    SELECT IFNULL(MAX(CAST(right(bid, 3) AS UNSIGNED)), 0)
    INTO max_code
    FROM book_aladin;

    SET NEW.bid = CONCAT('B', LPAD((max_code + 1), 3, '0'));
END$$

DELIMITER ;
/**************** TRIGGRER 끝 ******************/

DESC book_aladin;
SELECT * FROM book_aladin;
SELECT * FROM information_schema.triggers;

-- 알라딘 끝

-- DROP TRIGGER IF EXISTS trh_book_tj_bid;
-- DROP TRIGGER IF EXISTS trh_book_yes24_bid;
-- DROP TRIGGER IF EXISTS trh_book_aladin_bid;

-- DROP TABLE book_tj;
-- DROP TABLE book_yes24;
-- DROP TABLE book_aladin;

INSERT INTO book_tj(btitle, author, price, isbn, bdate) 
				             values ('연금술사', '파울로 코엘료', '1000', '1234', now());

SELECT	bid, btitle, author, price, isbn, bdate 
				 FROM book_tj
				 WHERE bid = "b001";

DESC book_tj;
SELECT count(*) AS count FROM book_yes24;


-- Connection 확인
SHOW STATUS LIKE "Threads_connected";  -- 접속 커넥션 수
SHOW PROCESSLIST;					   -- 활성중인 커넥션 (workbench도 하나의 커넥션이다.) (이클립스에서 main메소드 하나 실행할 때마다 커넥션 증가)
SHOW VARIABLES LIKE "max_connections"; -- 최대 접속 가능 커넥션 수 (동시접속 가능한 수)


--

USE hrdb2019;
SELECT DATABASE();

/*****************************************************
	book_market_books : 도서 테이블
    book_market_member : 회원 테이블
    book_market_cart : 장바구니 테이블    
******************************************************/

CREATE TABLE book_market_books (
	bid    char(4)     PRIMARY KEY,
    btitle varchar(50) NOT NULL,
    author varchar(10),
    price  int,
    isbn   int,
    bdate  datetime
);

CREATE TABLE book_market_member (
	uid          varchar(20)     PRIMARY KEY,
    password     varchar(20) NOT NULL,
    create_date  datetime
);

CREATE TABLE book_market_cart (
	order_id    int           AUTO_INCREMENT PRIMARY KEY,
    uid         varchar(20),
	bid         char(4),
    btitle      varchar(50)   NOT NULL,
    author      varchar(10),
    price       int,
    isbn        int,
    order_date  datetime,
    CONSTRAINT fk_uid FOREIGN KEY(uid)
							REFERENCES book_market_member(uid),
	CONSTRAINT fk_bid FOREIGN KEY(bid)
							REFERENCES book_market_books(bid)
);

/**************** TRIGGRER 시작 ******************/
DELIMITER $$

CREATE TRIGGER trh_book_market_books_bid
BEFORE INSERT ON book_market_books
FOR EACH ROW 
BEGIN
    DECLARE max_code INT;

    SELECT IFNULL(MAX(CAST(right(bid, 3) AS UNSIGNED)), 0)
    INTO max_code
    FROM book_market_books;

    SET NEW.bid = CONCAT('B', LPAD((max_code + 1), 3, '0'));
END$$

DELIMITER ;
/**************** TRIGGRER 끝 ******************/

-- 	   bid    char(4)     PRIMARY KEY,
--     btitle varchar(50) NOT NULL,
--     author varchar(10),
--     price  int,
--     isbn   int,
--     bdate  datetime
INSERT INTO book_market_books(btitle, author, price, isbn, bdate) 
				             values ('연금술사', '파울로 코엘료', '1000', FLOOR(RAND() * 9000) + 1000, now());
INSERT INTO book_market_books(btitle, author, price, isbn, bdate) 
				             values ('빅피처', '더글라스 케네디', '2000', FLOOR(RAND() * 9000) + 1000, now());
INSERT INTO book_market_books(btitle, author, price, isbn, bdate) 
				             values ('나미야 잡화점', '히가시노 게이고', '3000', FLOOR(RAND() * 9000) + 1000, now());

INSERT INTO book_market_cart(bid, btitle, author, price, isbn, order_date)
							SELECT bid, btitle, btitle, price, isbn, now()
                            FROM book_market_books
                            WHERE bid = 'B001';

INSERT INTO book_market_member(uid, password, create_date) 
				             values ('hong', '1234', now());

SELECT * FROM book_market_member WHERE uid = 'hong' AND password = '1234';

DELETE FROM book_market_cart WHERE uid = 'hong';

UPDATE book_market_cart SET complete = '1', payment_date = now() WHERE order_id = 25;

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE book_market_cart;
SET FOREIGN_KEY_CHECKS = 1;

ALTER TABLE book_market_cart
ADD COLUMN payment_date datetime;

ALTER TABLE book_market_member
ADD COLUMN name varchar(10) NOT NULL;
ALTER TABLE book_market_member
ADD COLUMN age int(4);
ALTER TABLE book_market_member
ADD COLUMN gender char(1);
ALTER TABLE book_market_member
ADD COLUMN address varchar(50);
ALTER TABLE book_market_member
ADD COLUMN phone varchar(20);

ALTER TABLE book_market_cart
ADD COLUMN pay int;
ALTER TABLE book_market_cart
ADD COLUMN `change` int;

DESC book_market_books;
SELECT * FROM book_market_books;
DESC book_market_member;
SELECT * FROM book_market_member;
DESC book_market_cart;
SELECT * FROM book_market_cart;

SELECT * FROM information_schema.triggers;