SELECT * FROM DEPT_TCL;
DELETE FROM DEPT_TCL
	WHERE DEPTNO = 50;
    
COMMIT;

UPDATE DEPT_TCL
	SET LOC = 'SEOUL'
	WHERE DEPTNO = 30;

-- 관계 데이터 모델
-- 도서 (도서번호, 도서이름, 출판사, 가격) -> BOOK
-- 주문(주문번호, 도서번호, 고객번호,판매가격,주문일자) -> ORDERS
-- 고객 (고객번호, 이름, 주소, 핸드폰) -> CUSTOMER

CREATE USER BOOK IDENTIFIED BY 1234;
GRANT CONNECT, RESOURCE TO BOOK;

CREATE TABLE BOOK(
    BOOKID NUMBER(10) PRIMARY KEY,
    BOOKNAME VARCHAR2(40),
    PUBLISHER VARCHAR2(40),
    PRICE NUMBER(10)
);
CREATE TABLE CUSTOMER(
    CUSTID NUMBER(10) PRIMARY KEY,
    NAME VARCHAR2(40),
    ADDRESS VARCHAR2(50),
    PHONE VARCHAR2(20)
);

CREATE TABLE ORDERS (
    ORDERID NUMBER(10) PRIMARY KEY,
    CUSTID NUMBER(10),
    BOOKID NUMBER(10),
    SALEPRICE NUMBER(10),
    ORDERDATE DATE,
    
    FOREIGN KEY(CUSTID) REFERENCES CUSTOMER(CUSTID),
    FOREIGN KEY(BOOKID) REFERENCES BOOK(BOOKID)
);

DESC BOOK;
DESC CUSTOMER;
DESC ORDERS;

-- BOOK 테이블에 데이터 입력
INSERT INTO Book VALUES(1, '축구의 역사', '굿스포츠', 7000);
INSERT INTO Book VALUES(2, '축구 아는 여자', '나무수', 13000);
INSERT INTO Book VALUES(3, '축구의 이해', '대한미디어', 22000);
INSERT INTO Book VALUES(4, '골프 바이블', '대한미디어', 35000);
INSERT INTO Book VALUES(5, '피겨 교본', '굿스포츠', 8000);
INSERT INTO Book VALUES(6, '배구 단계별기술', '굿스포츠', 6000);
INSERT INTO Book VALUES(7, '야구의 추억', '이상미디어', 20000);
INSERT INTO Book VALUES(8, '야구를 부탁해', '이상미디어', 13000);
INSERT INTO Book VALUES(9, '올림픽 이야기', '삼성당', 7500);
INSERT INTO Book VALUES(10, 'Olympic Champions', 'Pearson', 13000);

SELECT * FROM BOOK;

-- CUSTOMER 테이블에 데이터 입력
INSERT INTO Customer VALUES (1, '박지성', '영국 맨체스타', '000-5000-0001');
INSERT INTO Customer VALUES (2, '김연아', '대한민국 서울', '000-6000-0001'); 
INSERT INTO Customer VALUES (3, '김연경', '대한민국 경기도', '000-7000-0001');
INSERT INTO Customer VALUES (4, '추신수', '미국 클리블랜드', '000-8000-0001');
INSERT INTO Customer VALUES (5, '박세리', '대한민국 대전',  NULL);

SELECT * FROM CUSTOMER;

-- ORDERS 테이블에 데이터 입력
INSERT INTO Orders VALUES (1, 1, 1, 6000, TO_DATE('2024-07-01','YYYY-MM-DD'));
INSERT INTO Orders VALUES (2, 1, 3, 21000, TO_DATE('2024-07-03','YYYY-MM-DD'));
INSERT INTO Orders VALUES (3, 2, 5, 8000, TO_DATE('2024-07-03','YYYY-MM-DD'));
INSERT INTO Orders VALUES (4, 3, 6, 6000, TO_DATE('2024-07-04','YYYY-MM-DD'));
INSERT INTO Orders VALUES (5, 4, 7, 20000, TO_DATE('2024-07-05','YYYY-MM-DD'));
INSERT INTO Orders VALUES (6, 1, 2, 12000, TO_DATE('2024-07-07','YYYY-MM-DD'));
INSERT INTO Orders VALUES (7, 4, 8, 13000, TO_DATE( '2024-07-07','YYYY-MM-DD'));
INSERT INTO Orders VALUES (8, 3, 10, 12000, TO_DATE('2024-07-08','YYYY-MM-DD'));
INSERT INTO Orders VALUES (9, 2, 10, 7000, TO_DATE('2024-07-09','YYYY-MM-DD'));
INSERT INTO Orders VALUES (10, 3, 8, 13000, TO_DATE('2024-07-10','YYYY-MM-DD'));

SELECT * FROM ORDERS;

COMMIT;

-- 후보키 : 컬럼들 중에 유일한 값을 가지는 키
-- 기본키 : 선택된 유일한 값을 가지는 키
-- 대리키 : 기본키 컬럼이 없을 때 직접 기본키 컬럼을 정의
-- 대체키 : 컬럼들 중에 기본키로 사용할 수 있으나 선택되지 않은 컬럼


-- 모든 도서의 이름과 가격을 검색
SELECT BOOKNAME, PRICE FROM BOOK;

-- 도서 테이블에 모든 출판사를 검색 (중복 제외)
SELECT DISTINCT(PUBLISHER) AS PUB FROM BOOK;

-- 가격이 만원 이상, 이만원 이하인 도서 검색
SELECT * FROM BOOK WHERE PRICE BETWEEN 10000 AND 20000;

-- 도서 이름에 축구를 포함하는 도서의 출판사 검색
SELECT BOOKNAME, PUBLISHER FROM BOOK WHERE BOOKNAME LIKE '%축구%';

-- 축구에 관한 도서 중 가격이 2만원 이상인 도서 검색
SELECT * FROM BOOK WHERE BOOKNAME LIKE '%축구%' AND PRICE >= 20000;

-- 도서를 가격으로 내림차순 정렬, 같은 가격이면 출판사 오름차순 정렬
SELECT * FROM BOOK ORDER BY PRICE DESC, PUBLISHER;

-- 고객별 주문한 도서의 총수량과 총판매액 검색
SELECT CUSTID, COUNT(*) AS ORDERCOUNT, SUM(SALEPRICE) AS TOTALPRICE 
    FROM CUSTOMER JOIN ORDERS USING (CUSTID) GROUP BY CUSTID ORDER BY CUSTID;

-- 기격이 8000 이상인 도서를 2권 이상 구매한 고객에 대하여 고객별 주문 도서의 총수량을 구하시오
SELECT CUSTID, COUNT(*) FROM CUSTOMER JOIN ORDERS USING (CUSTID)
   WHERE SALEPRICE >= 8000 GROUP BY CUSTID HAVING COUNT(*) >= 2
   ORDER BY CUSTID;
   
-- 고객의 이름과 고객이 주문한 도서의 판매가격을 검색
SELECT NAME, SALEPRICE FROM CUSTOMER JOIN ORDERS USING (CUSTID) ORDER BY CUSTID;

-- 고객의 이름과 고객이 주문한 도서의 이름을 검색
SELECT NAME, BOOKNAME FROM CUSTOMER JOIN ORDERS USING (CUSTID) JOIN BOOK USING (BOOKID) ORDER BY CUSTID;

-- 가장 비산 도서의 이름
SELECT BOOKNAME FROM BOOK WHERE PRICE = ANY (SELECT MAX(PRICE) FROM BOOK);

-- 도서를 구매한 적이 없는 고객 이름
SELECT NAME FROM CUSTOMER WHERE CUSTID NOT IN (SELECT CUSTID FROM ORDERS);
SELECT NAME FROM CUSTOMER WHERE CUSTID != ALL (SELECT CUSTID FROM ORDERS);

-- 대한미디어에서 출판한 도서를 구매한 고객의 이름
SELECT NAME FROM CUSTOMER WHERE CUSTID = ANY (SELECT CUSTID FROM ORDERS JOIN BOOK USING (BOOKID) WHERE PUBLISHER LIKE '대한미디어');

-- 출판사 별로 출판사의 평균 도서 가격보다 비싼 도서 검색
SELECT PUBLISHER, BOOKNAME FROM BOOK WHERE PRICE >= ANY (SELECT AVG(PRICE) FROM BOOK GROUP BY PUBLISHER) ORDER BY PUBLISHER;

SELECT B1.BOOKNAME FROM BOOK B1 WHERE B1.PRICE > (SELECT AVG(B2.PRICE) FROM BOOK B2 WHERE B2.PUBLISHER = B1.PUBLISHER); --?

-- 대한민국에 거주하는 고객이름과 도서를 주문한 고객의 이름을 같이 검색
SELECT NAME FROM CUSTOMER WHERE NAME = ANY (SELECT NAME FROM CUSTOMER WHERE ADDRESS LIKE '대한민국%') OR
                                CUSTID = ANY (SELECT CUSTID FROM ORDERS);
                        
SELECT NAME FROM CUSTOMER WHERE CUSTID IN (SELECT CUSTID FROM ORDERS) OR 
                                NAME IN (SELECT NAME FROM CUSTOMER WHERE ADDRESS LIKE '대한민국%');
                                
---- 데이터 모델링 ----
-- 요구사항 수집 및 분석
-- 설계 - 개념적 모델링, 논리적 모델링, 물리적 모델링
-- 구현
-- 운영
-- 감시 및 개선

-- 개념적 모델링 : 개체를 추출, 개체의 관계를 정의하고 ER다이어그램을 작성

-- 논리적 모델링 : 개념적 모델링에서 설계한 ERD를 사용하고자 하는 DBMS에 맞게 사상(맵핑)하여
--                실제 데이터베이스로 구현하기 위한 모델을 만드는 과정
--                1. 상세 속성 추출
--                2. 정규화 수행 : 데이터를 중복 저장하는 문제 해결
--                3. 데이터의 표준화 : 도메인 정의

-- 물리적 모델링 : 논리적 모델링을 실제 컴퓨터 저장 장치에 저장하기 위한
--              물리적인 구조를 정의하고 구현하는 과정

-----------------------
-- 관계 타입 유형

-- 차수에 따른 유형 : 관계 집합에 참여하는 개체 타입의 수를 정의한 것
-- 1진 관계 : 테이블 하나
-- 2진 관계 : 테이블 두개
-- 3진 관계 : 테이블 세개

-- 관계 대응 수에 따른 유형
-- 1 : 1
-- 1: n
-- n : 1
-- n : m => 맵핑 테이블 작성을 통한 구조 변경 필요

-- 관계 대응 수의 최소값과 최대값

-- 모델링을 표현하는 방식
-- 피터 첸 표기 방식
-- IE 표기법

create user bookerd identified by 1234;

grant connect, resource to bookerd;

create user boardmake identified by boardmake;

grant connect, resource to boardmake;

create user boardDB identified by boardDB;

grant connect, resource to boardDB;

CREATE TABLE MEMBER (
    NAME VARCHAR2(10),
    USERID VARCHAR2(10),
    PWD VARCHAR2(10),
    EMAIL VARCHAR2(20),
    PHONE CHAR(13),
    ADMIN NUMBER(1) DEFAULT 0,
    PRIMARY KEY (USERID)
);

INSERT INTO MEMBER VALUES ('이소미', 'SOMI', '1234', 'GMD@NAVER.COM', '010-2362-5157', 0);
INSERT INTO MEMBER VALUES ('하상오', 'SANG12', '1234', 'SANG12@NAVER.COM', '010-5629-8888', 1);
INSERT INTO MEMBER VALUES ('김윤승', 'LIGHT', '1234', 'YOUN1004@NAVER.COM', '010-9999-8282', 0);

SELECT * FROM MEMBER;

COMMIT;

create table product(
    code number(5),
    name varchar2(100),
    price number(8),
    pictureurl varchar2(100),
    description varchar2(1000),
    primary key(code)
);

create sequence product_seq
start with 1;

insert into product values(product_seq.nextval, '개념을 콕콕 잡아주는 데이터베이스', 27000, 'db.jpg', '데이터베이스에 관한 모든 것을 쉽고 재미있게 정리한 교재...');
insert into product values(product_seq.nextval, '웹표준을 위한 HTML5', 25000, 'html5.jpg', 'HTML5 가이드북. 홈페이지 제작을 위한 필수 선택 HTML 기본 문법...');
insert into product values(product_seq.nextval, 'Dynamic Programming book 시리즈-01 오라클 11g + PL/SQL', 25000, 'oracle.jpg','Dynamic 실무 코칭 프로그래밍 Book의 첫번째 책으로, 오라클 11g의 새로운 ...');
insert into product values(product_seq.nextval, 'Visual C++ MFC 윈도우 프로그래밍', 26000, 'mfc.jpg', 'Visual C++를 처음 시작하는 독자의 눈높이에 맞춘 Visual C++...');
insert into product values(product_seq.nextval, 'jQuery and jQuery Mobile : 이해하기 쉽게 풀어쓴', 25000, 'jquery.jpg', '소스 하나로 데스크탑과 모바일까지 HTML5와 함께 사용한다. 초보자들도 ...');
commit;
select * from product;

create table board(
    num number(5) primary key,
    pass varchar2(30),
    name varchar2(30),
    email varchar2(30),
    title varchar2(50),
    content varchar2(1000),
    readcount number(4) default 0,
    writedate date default sysdate
); 

create sequence board_seq
start with 1
increment by 1;

insert into board (num,pass,name,email,title,content)
values(board_seq.nextval,'1234','성윤정','pinksung@nate.com','첫방문','반갑습니다');
insert into board (num,pass,name,email,title,content)
values(board_seq.nextval,'1234','성윤정','pinksung@nate.com','김밥','맛있어요.');
insert into board (num,pass,name,email,title,content)
values(board_seq.nextval,'3333','전수빈','raccon@nate.com','고등애','일식입니다.');
insert into board (num,pass,name,email,title,content)
values(board_seq.nextval,'1111','전원지','one@nate.com','갯골마을','돼지삼겹살이 맛있습니다.');

select * from board order by num desc;
commit;

create user nonage identified by tiger;
grant connect, resource to nonage;

desc address;

create user book_ex identified by book_ex;
grant connect, resource to book_ex;

create table tbl_board (
  bno number(10,0),
  title varchar2(200) not null,
  content varchar2(2000) not null,
  writer varchar2(50) not null,
  regdate date default sysdate, 
  updatedate date default sysdate
);

alter table tbl_board add constraint pk_board 
primary key (bno);

create sequence seq_board;

insert into tbl_board (bno,title,content,writer)
values (seq_board.nextval,'테스트 제목','테스트 내용','user00');

commit;

select * from tbl_board;

select /*+ index_desc(tbl_board pk_board) */ * from tbl_board where bno > 0;

select /*+ index_desc(tbl_board pk_board) */ rownum rn, bno, title, content from tbl_board;

select bno,title,content from 
(select /*+ index_desc(tbl_board pk_board) */ rownum rn,bno,title,content from tbl_board where rownum <= 10) 
where rn > 0;

select count(*) from tbl_board where bno > 0;

create table tbl_reply (
  rno number(10,0), 
  bno number(10,0) not null,
  reply varchar2(1000) not null,
  replyer varchar2(50) not null, 
  replyDate date default sysdate, 
  updateDate date default sysdate
);

create sequence seq_reply;

alter table tbl_reply add constraint pk_reply primary key (rno);

alter table tbl_reply  add constraint fk_reply_board  
foreign key (bno)  references  tbl_board (bno); 

select * from tbl_reply;
delete tbl_reply;

select rno, reply, replyer, replydate, updatedate from
            (select /*+ index_desc(tbl_reply pk_reply) */ rownum rn, rno, reply, replyer, replydate, updatedate
                from tbl_reply where bno = 120 and rownum <= 10)
            where rn > 0;
        
select /*+ index_desc(tbl_reply pk_reply) */ rownum rn, rno, reply, regdate, updatedate
                from tbl_board where bno = 120;

create table tbl_sample1 (col1 varchar2(500));
create table tbl_sample2 (col1 varchar2(50));

select * from tbl_sample1;
select * from tbl_sample2;
delete tbl_sample1;

commit;

create table tbl_attach ( 
  uuid varchar2(100) not null,
  uploadPath varchar2(200) not null,
  fileName varchar2(100) not null, 
  filetype char(1) default 'I',
  bno number(10,0)
);

alter table tbl_attach add constraint pk_attach primary key (uuid); 

alter table tbl_attach add constraint fk_board_attach foreign key (bno) references tbl_board(bno);