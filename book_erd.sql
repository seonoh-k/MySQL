DROP TABLE NEWBOOK;

CREATE TABLE NEWBOOK (
	BOOKID	NUMBER(15)		NOT NULL,
	BOOKNAME	VARCHAR2(40)		NULL,
    PUBLISHER	VARCHAR2(40)		NOT NULL,
	PRICE	NUMBER(10)		NULL
);

DROP TABLE NEWPUBLISHER;

CREATE TABLE NEWPUBLISHER (
	PUBLISHER	VARCHAR2(40)		NOT NULL,
	EMP_NAME	VARCHAR2(40)		NULL,
	TLNO	VARCHAR2(20)		NULL
);

DROP TABLE NEWORDERS;

CREATE TABLE NEWORDERS (
	ORDERID	NUMBER(15)		NOT NULL,
    CUSTID	NUMBER(15)		NOT NULL,
	BOOKID	NUMBER(15)		NOT NULL,
	SALEPRICE	NUMBER(10)		NULL,
	ODERDATE	DATE		NULL
);

DROP TABLE NEWCUSTOMER;

CREATE TABLE NEWCUSTOMER (
	CUSTID	NUMBER(15)		NOT NULL,
	NAME	VARCHAR2(40)		NULL,
	ADDRESS	VARCHAR2(50)		NULL,
	PHONE	VARCHAR2(20)		NULL
);

ALTER TABLE NEWBOOK ADD CONSTRAINT PK_NEWBOOK PRIMARY KEY (
	BOOKID
	
);

ALTER TABLE NEWPUBLISHER ADD CONSTRAINT PK_NEWPUBLISHER PRIMARY KEY (
	PUBLISHER
);

ALTER TABLE NEWORDERS ADD CONSTRAINT PK_NEWORDERS PRIMARY KEY (
	ORDERID
	
);

ALTER TABLE NEWCUSTOMER ADD CONSTRAINT PK_NEWCUSTOMER PRIMARY KEY (
	CUSTID
);

ALTER TABLE NEWBOOK ADD CONSTRAINT FK_NEWPUBLISHER_TO_NEWBOOK_1 FOREIGN KEY (
	PUBLISHER
)
REFERENCES NEWPUBLISHER (
	PUBLISHER
);

ALTER TABLE NEWORDERS ADD CONSTRAINT FK_NEWBOOK_TO_NEWORDERS_1 FOREIGN KEY (
	BOOKID
)
REFERENCES NEWBOOK (
	BOOKID
);

ALTER TABLE NEWORDERS ADD CONSTRAINT FK_NEWCUSTOMER_TO_NEWORDERS_1 FOREIGN KEY (
	CUSTID
)
REFERENCES NEWCUSTOMER (
	CUSTID
);

-- NEWPUBLISHER 테이블에 데이터 입력
INSERT INTO NEWPUBLISHER VALUES ('굿스포츠', '이상화', '010-4923-2234');
INSERT INTO NEWPUBLISHER VALUES ('나무수', '구자철', '010-2983-3946');
INSERT INTO NEWPUBLISHER VALUES ('대한미디어', '안정환', '010-2387-4816');
INSERT INTO NEWPUBLISHER VALUES ('이상미디어', '제임스', '010-1830-4926');
INSERT INTO NEWPUBLISHER VALUES ('삼성당', '커비', '010-5916-3845');
INSERT INTO NEWPUBLISHER VALUES ('Pearson', 'Leberon', '010-3948-1392');

SELECT * FROM NEWPUBLISHER;

-- NEWBOOK 테이블에 데이터 입력
INSERT INTO NEWBOOK VALUES(1, '축구의 역사', '굿스포츠', 7000);
INSERT INTO NEWBOOk VALUES(2, '축구 아는 여자', '나무수', 13000);
INSERT INTO NEWBOOk VALUES(3, '축구의 이해', '대한미디어', 22000);
INSERT INTO NEWBOOk VALUES(4, '골프 바이블', '대한미디어', 35000);
INSERT INTO NEWBOOk VALUES(5, '피겨 교본', '굿스포츠', 8000);
INSERT INTO NEWBOOk VALUES(6, '배구 단계별기술', '굿스포츠', 6000);
INSERT INTO NEWBOOk VALUES(7, '야구의 추억', '이상미디어', 20000);
INSERT INTO NEWBOOk VALUES(8, '야구를 부탁해', '이상미디어', 13000);
INSERT INTO NEWBOOk VALUES(9, '올림픽 이야기', '삼성당', 7500);
INSERT INTO NEWBOOk VALUES(10, 'Olympic Champions', 'Pearson', 13000);

SELECT * FROM NEWBOOK;

-- NEWCUSTOMER 테이블에 데이터 입력
INSERT INTO NEWCustomer VALUES (1, '박지성', '영국 맨체스타', '000-5000-0001');
INSERT INTO NEWCustomer VALUES (2, '김연아', '대한민국 서울', '000-6000-0001'); 
INSERT INTO NEWCustomer VALUES (3, '김연경', '대한민국 경기도', '000-7000-0001');
INSERT INTO NEWCustomer VALUES (4, '추신수', '미국 클리블랜드', '000-8000-0001');
INSERT INTO NEWCustomer VALUES (5, '박세리', '대한민국 대전',  NULL);

SELECT * FROM NEWCUSTOMER;

-- NEWORDERS 테이블에 데이터 입력
INSERT INTO NEWOrders VALUES (1, 1, 1, 6000, TO_DATE('2024-07-01','YYYY-MM-DD'));
INSERT INTO NEWOrders VALUES (2, 1, 3, 21000, TO_DATE('2024-07-03','YYYY-MM-DD'));
INSERT INTO NEWOrders VALUES (3, 2, 5, 8000, TO_DATE('2024-07-03','YYYY-MM-DD'));
INSERT INTO NEWOrders VALUES (4, 3, 6, 6000, TO_DATE('2024-07-04','YYYY-MM-DD'));
INSERT INTO NEWOrders VALUES (5, 4, 7, 20000, TO_DATE('2024-07-05','YYYY-MM-DD'));
INSERT INTO NEWOrders VALUES (6, 1, 2, 12000, TO_DATE('2024-07-07','YYYY-MM-DD'));
INSERT INTO NEWOrders VALUES (7, 4, 8, 13000, TO_DATE( '2024-07-07','YYYY-MM-DD'));
INSERT INTO NEWOrders VALUES (8, 3, 10, 12000, TO_DATE('2024-07-08','YYYY-MM-DD'));
INSERT INTO NEWOrders VALUES (9, 2, 10, 7000, TO_DATE('2024-07-09','YYYY-MM-DD'));
INSERT INTO NEWOrders VALUES (10, 3, 8, 13000, TO_DATE('2024-07-10','YYYY-MM-DD'));

SELECT * FROM NEWORDERS;

commit;

SELECT * FROM NEWBOOK WHERE BOOKNAME LIKE '%축구%' AND PRICE >= 20000;

SELECT CUSTID, COUNT(*) FROM NEWCUSTOMER JOIN NEWORDERS USING (CUSTID)
   WHERE SALEPRICE >= 8000 GROUP BY CUSTID HAVING COUNT(*) >= 2
   ORDER BY CUSTID;
   
   
DROP USER javaDB CASCADE;

CREATE USER javaDB IDENTIFIED BY javaDB;

GRANT CONNECT, RESOURCE TO javaDB;