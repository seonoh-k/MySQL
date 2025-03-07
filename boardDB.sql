CREATE USER BoardPr identified by BoardPr;
GRANT RESOURCE, CONNECT TO BoardPr;

SELECT * FROM BOARDS;
SELECT * FROM COMMENTS;
SELECT * FROM USERS;
DELETE USERS;
DELETE BOARDS;
DELETE COMMENTS;
DROP TABLE USERS;
DROP TABLE BOARDS;
DROP TABLE COMMENTS;
CREATE TABLE boards (
    board_no    number(5)           CONSTRAINT boards_board_no_pk PRIMARY KEY,
    user_no	    number(5)		    CONSTRAINT boards_user_no_nn NOT NULL,
    title	    VARCHAR2(20)		CONSTRAINT boards_title_nn NOT NULL,
    content	    VARCHAR2(300)	    CONSTRAINT boards_content_nn NOT NULL,
    create_at   DATE		        CONSTRAINT boards_create_at_nn NOT NULL,
    update_at   DATE	            DEFAULT null,
    delete_at   DATE	            DEFAULT null
);

CREATE TABLE comments (
    comment_no  number(5)           CONSTRAINT comments_comment_no_pk PRIMARY KEY,
    user_no	    number(5)	        CONSTRAINT comments_user_no_nn	NOT NULL,
    board_no    number(5)	        CONSTRAINT comments_board_no_nn	NOT NULL,
    content	    VARCHAR2(300)	    CONSTRAINT comments_content_nn	NOT NULL,
    create_at   DATE	            CONSTRAINT comments_create_at_nn	NOT NULL,
    update_at   DATE	            DEFAULT NULL,
    delete_at   DATE	            DEFAULT	NULL,
    ref         number(5)           DEFAULT NULL
    
);

CREATE TABLE users (
    user_no	    NUMBER(5)           CONSTRAINT users_user_no_pk PRIMARY KEY,

    user_id     VARCHAR2(15)        CONSTRAINT users_user_id_nn NOT NULL
                                    CONSTRAINT users_user_id_uq	UNIQUE,

    user_email  VARCHAR2(30)        CONSTRAINT users_user_email_nn	NOT NULL 
                                    CONSTRAINT users_user_email_uq	UNIQUE,
                                    
    user_name   VARCHAR2(10)        CONSTRAINT users_user_name_nn	NOT NULL,
    user_pass   VARCHAR2(15)        CONSTRAINT users_user_pass_nn	NOT NULL,
    user_gender VARCHAR2(2)	        CONSTRAINT users_user_gender_nn	NOT NULL,
    user_birth  DATE	            CONSTRAINT users_user_birth_nn	NOT NULL
);

ALTER TABLE boards                  ADD CONSTRAINT FK_users_TO_boards_1 
FOREIGN KEY (user_no)               REFERENCES users (user_no);
    
ALTER TABLE comments                ADD CONSTRAINT FK_users_TO_comments_1 
FOREIGN KEY (user_no)               REFERENCES users (user_no);
    
ALTER TABLE comments                ADD CONSTRAINT FK_boards_TO_comments_1 
FOREIGN KEY (board_no)              REFERENCES boards (board_no);

------------------------------------------------------------------- Users 삽입
INSERT INTO users 
VALUES(90001,'ys123','ys123@naver.com','김용식','ys123','남','1967-08-13');

INSERT INTO users 
VALUES(90002,'gr123','gr123@naver.com','김계롱','gr123','남','1957-08-13');

INSERT INTO users 
VALUES(90003,'hch123','hch123@naver.com','노힘찬','hch123','남','1958-08-13');

INSERT INTO users 
VALUES(90004,'sj123','sj123@naver.com','하소정','sj123','여','1987-08-13');

INSERT INTO users 
VALUES(90005,'gy123','gy123@naver.com','송가영','gy123','여','2000-08-13');
------------------------------------------------------------------- Users 삽입 End
------------------------------------------------------------------- Boards 삽입 
INSERT INTO boards(board_no,user_no,title,content,create_at,update_at,delete_at)
VALUES(10001,90001,'집에가자','허허cvb참',TO_DATE('2025-03-01 15:30:13', 'YYYY-MM-DD HH24:MI:SS'), null,null);

INSERT INTO boards(board_no,user_no,title,content,create_at,update_at,delete_at)
VALUES(10002,90002,'0207집에가자','허허참장해bvcb야 한다RVAL 또는  ',TO_DATE('2025-03-01 15:30:13', 'YYYY-MM-DD HH24:MI:SS'), null,null);

INSERT INTO boards(board_no,user_no,title,content,create_at,update_at,delete_at)
VALUES(10003,90003,'0207집에가자','허허xcv참장해야 한다',TO_DATE('2025-03-01 15:32:13', 'YYYY-MM-DD HH24:MI:SS'), null,null);

INSERT INTO boards(board_no,user_no,title,content,create_at,update_at,delete_at)
VALUES(10004,90004,'0207집에가자','허허참장해acv야 한다',TO_DATE('2025-03-01 15:33:13', 'YYYY-MM-DD HH24:MI:SS'), null,null);

INSERT INTO boards(board_no,user_no,title,content,create_at,update_at,delete_at)
VALUES(10005,90005,'0207집에가자','허허참장qwe해야 한다용한 날짜 연산
만약 특정 날짜에서 몇 일을 더하',TO_DATE('2025-03-0115:33:29', 'YYYY-MM-DD HH24:MI:SS'), null,TO_DATE('2025-03-06 15:30:13', 'YYYY-MM-DD HH24:MI:SS'));
------------------------------------------------------------------- Boards 삽입 End
------------------------------------------------------------------- Comment 삽입
INSERT INTO comments (comment_no,user_no,board_no,content,create_at,update_at,delete_at,ref)
VALUES(50001,90001,10001,'ㅋㅋㅋ',TO_DATE('2025-03-02 15:31:34', 'YYYY-MM-DD HH24:MI:SS'),null,null,null);

INSERT INTO comments (comment_no,user_no,board_no,content,create_at,update_at,delete_at,ref)
VALUES(50002,90002,10001,'ㅋㅋㅋ',TO_DATE('2025-03-03 15:32:34', 'YYYY-MM-DD HH24:MI:SS'),null,null,1);

INSERT INTO comments (comment_no,user_no,board_no,content,create_at,update_at,delete_at,ref)
VALUES(50003,90003,10001,'ㅋㅋㅋ',TO_DATE('2025-03-03 15:33:34', 'YYYY-MM-DD HH24:MI:SS'),null,null,1);

INSERT INTO comments (comment_no,user_no,board_no,content,create_at,update_at,delete_at,ref)
VALUES(50004,90003,10003,'ㅋㅋㅋ',TO_DATE('2025-03-06 15:34:34', 'YYYY-MM-DD HH24:MI:SS'),null,null,null);

INSERT INTO comments (comment_no,user_no,board_no,content,create_at,update_at,delete_at,ref)
VALUES(50005,90003,10003,'ㅋㅋㅋ',TO_DATE('2025-03-07 15:35:34', 'YYYY-MM-DD HH24:MI:SS'),null,null,null);

INSERT INTO comments (comment_no,user_no,board_no,content,create_at,update_at,delete_at,ref)
VALUES(50006,90003,10003,'ㅋㅋㅋㅋㅋ',TO_DATE('2025-03-07 15:36:34', 'YYYY-MM-DD HH24:MI:SS'),null,TO_DATE('2025-03-07 15:37:34', 'YYYY-MM-DD HH24:MI:SS'),5);
------------------------------------------------------------------- Comments 삽입 End