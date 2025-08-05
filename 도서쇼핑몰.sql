use hrdb2019;
select database();

/***************************************************************************
	book_market_books : 도서 테이블
    book_market_cart : 장바구니 테이블
    book_market_member : 회원 테이블
    
    ** cart 테이블 생성 시 어떤 회원이 어떤 도서를 장바구니에 추가했는지 fk로 정의
***************************************************************************/
-- 도서 테이블 생성 및 데이터 입력
show tables;
desc book_market_books;
-- drop table book_market_books;
create table book_market_books(
	bid		char(4)		primary key,
    title	varchar(50)	not null,
    author	varchar(10),
    price 	int,
    isbn	int,
    bdate 	datetime
);

select * from information_schema.triggers;
drop trigger trg_book_market_books_bid;
-- book_market_books 테이블의 bid 자동 생성을 위한 트리거 :: 'B0001'
/************************************************/
delimiter $$
create trigger trg_book_market_books_bid
before insert on book_market_books -- 테이블명
for each row
begin
declare max_code int;  --  'B001'

-- 현재 저장된 값 중 가장 큰 값을 가져옴
SELECT IFNULL(MAX(CAST(right(bid, 3) AS UNSIGNED)), 0)
INTO max_code
FROM book_market_books; 

-- 'M0001' 형식으로 아이디 생성, LPAD(값, 크기, 채워지는 문자형식) 
SET NEW.bid = concat('B', LPAD((max_code+1), 3, '0'));

end $$
delimiter ;
/************************************************/

desc book_market_books;
select LPAD(FLOOR(RAND() * 10000), 4, '0') as isbn from dual;

insert into book_market_books(btitle, author, price, isbn, bdate)  
	values('REACT', '양만춘', 3000, LPAD(FLOOR(RAND() * 10000), 4, '0'), now());
    
insert into book_market_books(btitle, author, price, isbn, bdate)
	values('JAVA', '홍길동', 1000, LPAD(FLOOR(RAND() * 10000), 4, '0'), now());
    
insert into book_market_books(btitle, author, price, isbn, bdate)
	values('HTML', '이순신', 2000, LPAD(FLOOR(RAND() * 10000), 4, '0'), now());
    
insert into book_market_books(btitle, author, price, isbn, bdate)    
	values('CSS', '김유신', 500, LPAD(FLOOR(RAND() * 10000), 4, '0'), now());
    
insert into book_market_books(btitle, author, price, isbn, bdate)  
	values('JS', '강감찬', 1500, LPAD(FLOOR(RAND() * 10000), 4, '0'), now());
    
select * from book_market_books;
-- set sql_safe_updates = 0;
-- delete from book_market_books where bid='B001';

-- 회원 테이블 생성
create table book_market_members(
	mid		char(4)		primary key,
    name	varchar(10)	not null,
    address	varchar(50),
    phone 	char(13),
	mdate	datetime
);

select * from information_schema.triggers;
/************************************************/
delimiter $$
create trigger trg_book_market_members_mid
before insert on book_market_members -- 테이블명
for each row
begin
declare max_code int;  --  'M001'

-- 현재 저장된 값 중 가장 큰 값을 가져옴
SELECT IFNULL(MAX(CAST(right(mid, 3) AS UNSIGNED)), 0)
INTO max_code
FROM book_market_members; 

-- 'M0001' 형식으로 아이디 생성, LPAD(값, 크기, 채워지는 문자형식) 
SET NEW.mid = concat('M', LPAD((max_code+1), 3, '0'));

end $$
delimiter ;
/************************************************/


-- 장바구니 테이블 생성 : member와 books 테이블을 참조해야함
create table book_market_carts(
	cid		char(4)		primary key,
    qty 	int 		not null,
    mid		char(4),
    bid 	char(4),
	cdate	datetime,
    constraint fk_book_market_members foreign key(mid) 
									references book_market_members(mid)
                                    on update cascade
                                    on delete cascade,
    constraint fk_book_market_books foreign key(bid) 
									references book_market_books(bid)
                                    on update cascade
                                    on delete cascade                                
);

select * from information_schema.triggers;
/************************************************/
delimiter $$
create trigger trg_book_market_carts_cid
before insert on book_market_carts -- 테이블명
for each row
begin
declare max_code int;  --  'C001'

-- 현재 저장된 값 중 가장 큰 값을 가져옴
SELECT IFNULL(MAX(CAST(right(cid, 3) AS UNSIGNED)), 0)
INTO max_code
FROM book_market_carts; 

-- 'C001' 형식으로 아이디 생성, LPAD(값, 크기, 채워지는 문자형식) 
SET NEW.cid = concat('C', LPAD((max_code+1), 3, '0'));

end $$
delimiter ;
/************************************************/

SELECT * FROM book_market_books;
SELECT * FROM book_market_members;
SELECT * FROM book_market_carts;