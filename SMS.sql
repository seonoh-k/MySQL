SELECT * FROM STUDENT;
SELECT * FROM GRADE;
SELECT * FROM SCHOLARSHIP;

COMMIT;

-- 제약 조건 조회
SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME 
    FROM USER_CONSTRAINTS;
    
-- STUDENT
create table student(
student_no number(15) Not null, 
student_name varchar2(10) Not null,
student_year number(10) Not null,
student_addr varchar2(100),
student_tel varchar2(14),
student_birth date
);

ALTER TABLE student ADD CONSTRAINT STUDENT_NO_PK PRIMARY KEY (
	student_no
);

INSERT INTO STUDENT VALUES
        (20111001, '김나라', 4, '서울특별시 서초구 서초동 어디 어디....', '011-111-1111', '1992-08-09');

INSERT INTO STUDENT VALUES
        (20111002, '이예쁜', 4, '서울특별시 강남구 신사동 어디 어디....', '011-222-1111', '1992-08-09');

INSERT INTO STUDENT VALUES
        (20111003, '박예쁜', 4, '서울특별시 도봉구 쌍문동 어디 어디....', '011-222-1112', '1992-09-09');

INSERT INTO STUDENT VALUES
        (20121001, '오필주', 3, '서울특별시 노원구 상계동....', '011-212-1111', '1993-08-09');

INSERT INTO STUDENT VALUES
         (20121002, '오필승', 3, '서울특별시 마포구 합정동....', '011-212-2222', '1993-10-09');

INSERT INTO STUDENT VALUES
     (20121003, '날나리', 3, '서울특별시 노원구 중계동....', '011-212-1122', '1993-11-09');

INSERT INTO STUDENT VALUES
       (20131001, '오정숙', 2, '서울특별시 강북구 성북동....', '010-212-1122', '1994-12-09');

INSERT INTO STUDENT VALUES
       (20131002, '오판석', 2, '서울특별시 마포구 합정동....', '010-212-1120', '1994-12-09');

INSERT INTO STUDENT VALUES
         (20141001, '이미영', 1, '서울특별시 노원구 하계동....', '010-211-1120', '1995-12-09');

INSERT INTO STUDENT VALUES
         (20131003, '오판석', 2, '서울특별시 마포구 합정동....', '010-212-1120', '1994-12-09');

INSERT INTO STUDENT VALUES
        (20141002, '최진영', 1, '서울특별시 강남구 일원동 ...', '010-3642-7777', '1995-08-08');

INSERT INTO STUDENT VALUES
        (20141003, '이나팔', 1, '서울특별시 노원구 하계동 ...', '02)745-6666', '1995-10-31');

INSERT INTO STUDENT VALUES
        (20141004, '송아지', 1, '강원도 춘천시 퇴계동 ...', '011-2222-111', '1995-09-19');

INSERT INTO STUDENT VALUES
        (20141005, '이문기', 1, '서울시 관악구 봉천동 ...', '010-1234-01234','1995-03-08');

INSERT INTO STUDENT VALUES
        (20141006, '김나리', 1, '경북 경산시 하양읍 ...', '010-256-2685', '1995-06-28');

-- GRADE 
DROP TABLE Grade;

CREATE TABLE Grade (
	student_no	number(15)	NOT NULL,
	grade_kor	number(10)	NULL,
	grade_eng	number(10)	NULL,
	grade_math	number(10)	NULL
);

ALTER TABLE GRADE ADD CONSTRAINT STUDENT_NO_FK FOREIGN KEY (STUDENT_NO) 
REFERENCES STUDENT(STUDENT_NO) ON DELETE CASCADE;

INSERT INTO GRADE VALUES
        (20141001, 90, 89, 90);

INSERT INTO GRADE VALUES
        (20141002, 100, 100, 100);

INSERT INTO GRADE VALUES
        (20141003, 57, 68, 82);

INSERT INTO GRADE VALUES
        (20141004, 92, 95, 35);

INSERT INTO GRADE VALUES
        (20141005, 75, 75, 68);

INSERT INTO GRADE VALUES
        (20141006, 85, 81, 83);

INSERT INTO GRADE VALUES
        (20131001, 71, 100, 92);

INSERT INTO GRADE VALUES
        (20131002, 87, 90, 89);

INSERT INTO GRADE VALUES
        (20131003, 82, 76, 60);

INSERT INTO GRADE VALUES
        (20121001, 100, 92, 75);

INSERT INTO GRADE VALUES
        (20121002, 79, 46, 57);

INSERT INTO GRADE VALUES
        (20121003, 50, 68, 66);

INSERT INTO GRADE VALUES
        (20111001, 100, 98, 99);

INSERT INTO GRADE VALUES
        (20111002, 75, 68, 90); 

INSERT INTO GRADE VALUES
        (20111003, 74, 98, 100);
SELECT * FROM (SELECT STUDENT_NO, STUDENT_NAME, GRADE_KOR, GRADE_ENG, GRADE_MATH FROM GRADE JOIN STUDENT USING (STUDENT_NO) 
                ORDER BY (GRADE_KOR + GRADE_ENG + GRADE_MATH) DESC)
WHERE ROWNUM <= (SELECT ROUND(COUNT(*) * (40/100)) FROM GRADE);
-- SCHOLARSHIP
DROP TABLE Scholarship;

CREATE TABLE Scholarship (
	scholar_name	varchar2(15)	NOT NULL,
	scholar_percent	number(10)	NULL,
	scholar_money	number(10)	NULL
);

ALTER TABLE Scholarship ADD CONSTRAINT SCHOLARSHIP_PK PRIMARY KEY (scholar_name);

INSERT INTO scholarship VALUES ('성적장학금', 10, 1200000);

INSERT INTO scholarship VALUES ('마티아스장학금', 30, 400000);

INSERT INTO scholarship VALUES ('분도장학금', 40, 300000);
