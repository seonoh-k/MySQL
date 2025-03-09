CREATE TABLE boards (
    board_no    number(5)               CONSTRAINT boards_board_no_pk PRIMARY KEY,
    user_no	    number(5)		            CONSTRAINT boards_user_no_nn NOT NULL,
    title	    VARCHAR2(20)		            CONSTRAINT boards_title_nn NOT NULL,
    content	    VARCHAR2(300)	    CONSTRAINT boards_content_nn NOT NULL,
    create_at   TIMESTAMP		                        CONSTRAINT boards_create_at_nn NOT NULL,
    update_at   TIMESTAMP	                        DEFAULT null,
    delete_at  TIMESTAMP                            DEFAULT null
);

CREATE TABLE comments (
    comment_no  number(5)          CONSTRAINT comments_comment_no_pk PRIMARY KEY,
    user_no	    number(5)	                    CONSTRAINT comments_user_no_nn	NOT NULL,
    board_no    number(5)	                CONSTRAINT comments_board_no_nn	NOT NULL,
    content	    VARCHAR2(300)	         CONSTRAINT comments_content_nn	NOT NULL,
    create_at   TIMESTAMP	            CONSTRAINT comments_create_at_nn	NOT NULL,
    update_at  TIMESTAMP	            DEFAULT NULL,
    delete_at   TIMESTAMP            DEFAULT	NULL,
    ref         number(5)           DEFAULT NULL
    
);


CREATE TABLE users (
    user_no	    NUMBER(5)          CONSTRAINT users_user_no_pk PRIMARY KEY,

    user_id     VARCHAR2(15)        CONSTRAINT users_user_id_nn NOT NULL
                                    CONSTRAINT users_user_id_uq	UNIQUE,

    user_pass   VARCHAR2(15)        CONSTRAINT users_user_pass_nn	NOT NULL,
    
    user_email  VARCHAR2(30)        CONSTRAINT users_user_email_nn	NOT NULL 
                                    CONSTRAINT users_user_email_uq	UNIQUE,
                                    
    user_name   VARCHAR2(10)        CONSTRAINT users_user_name_nn	NOT NULL,
    user_gender VARCHAR2(2)	        CONSTRAINT users_user_gender_nn	NOT NULL,
    user_birth  DATE	            CONSTRAINT users_user_birth_nn	NOT NULL
);

ALTER TABLE boards              ADD CONSTRAINT FK_users_TO_boards_1 
FOREIGN KEY (user_no)           REFERENCES users (user_no);

ALTER TABLE comments            ADD CONSTRAINT FK_users_TO_comments_1 
FOREIGN KEY (user_no)           REFERENCES users (user_no);

ALTER TABLE comments            ADD CONSTRAINT FK_boards_TO_comments_1 
FOREIGN KEY (board_no)          REFERENCES boards (board_no);
alter table comments constraint FK_boards_TO_comments_1;
delete boards;
delete users;
delete comments;
------------------------------------------------------------------- Users 삽입
INSERT INTO users (user_no,user_id,user_email,user_name,user_pass,user_gender,user_birth)
VALUES(90001,'ys123','ys123@naver.com','김용식','ys123','남','1967-08-13');

INSERT INTO users (user_no,user_id,user_email,user_name,user_pass,user_gender,user_birth)
VALUES(90002,'gr123','gr123@naver.com','김계롱','gr123','남','1957-08-13');

INSERT INTO users (user_no,user_id,user_email,user_name,user_pass,user_gender,user_birth)
VALUES(90003,'hch123','hch123@naver.com','노힘찬','hch123','남','1958-08-13');

INSERT INTO users (user_no,user_id,user_email,user_name,user_pass,user_gender,user_birth)
VALUES(90004,'sj123','sj123@naver.com','하소정','sj123','여','1987-08-13');

INSERT INTO users (user_no,user_id,user_email,user_name,user_pass,user_gender,user_birth)
VALUES(90005,'gy123','gy123@naver.com','송가영','gy123','여','2000-08-13');
------------------------------------------------------------------- Users 삽입 End
------------------------------------------------------------------- Boards 삽입 
INSERT INTO boards(board_no,user_no,title,content,create_at,update_at,delete_at)
VALUES(10001,90001,'집에가자','허허cvb참',TO_TIMESTAMP('2025-03-01 15:30:13', 'YYYY-MM-DD HH24:MI:SS'), null,null);

INSERT INTO boards(board_no,user_no,title,content,create_at,update_at,delete_at)
VALUES(10002,90002,'0207집에가자','허허참장해bvcb야 한다RVAL 또는  ',TO_TIMESTAMP('2025-03-01 15:30:13', 'YYYY-MM-DD HH24:MI:SS'), null,null);

INSERT INTO boards(board_no,user_no,title,content,create_at,update_at,delete_at)
VALUES(10003,90003,'0207집에가자','허허xcv참장해야 한다',TO_TIMESTAMP('2025-03-01 15:32:13', 'YYYY-MM-DD HH24:MI:SS'), null,null);

INSERT INTO boards(board_no,user_no,title,content,create_at,update_at,delete_at)
VALUES(10004,90004,'0207집에가자','허허참장해acv야 한다',TO_TIMESTAMP('2025-03-01 15:33:13', 'YYYY-MM-DD HH24:MI:SS'), null,null);

INSERT INTO boards(board_no,user_no,title,content,create_at,update_at,delete_at)
VALUES(10005,90005,'0207집에가자','허허참장qwe해야 한다용한 날짜 연산
만약 특정 날짜에서 몇 일을 더하',TO_TIMESTAMP('2025-03-0115:33:29', 'YYYY-MM-DD HH24:MI:SS'), null,TO_TIMESTAMP('2025-03-06 15:30:13', 'YYYY-MM-DD HH24:MI:SS'));
------------------------------------------------------------------- Boards 삽입 End
------------------------------------------------------------------- Comment 삽입
INSERT INTO comments (comment_no,user_no,board_no,content,create_at,update_at,delete_at,ref)
VALUES(50001,90001,10001,'ㅋㅋㅋ',TO_TIMESTAMP('2025-03-02 15:31:34', 'YYYY-MM-DD HH24:MI:SS'),null,null,null);

INSERT INTO comments (comment_no,user_no,board_no,content,create_at,update_at,delete_at,ref)
VALUES(50002,90002,10001,'ㅋㅋㅋ',TO_TIMESTAMP('2025-03-03 15:32:34', 'YYYY-MM-DD HH24:MI:SS'),null,null,50001);

INSERT INTO comments (comment_no,user_no,board_no,content,create_at,update_at,delete_at,ref)
VALUES(50003,90003,10001,'ㅋㅋㅋ',TO_TIMESTAMP('2025-03-03 15:33:34', 'YYYY-MM-DD HH24:MI:SS'),null,null,50001);

INSERT INTO comments (comment_no,user_no,board_no,content,create_at,update_at,delete_at,ref)
VALUES(50004,90003,10003,'ㅋㅋㅋ',TO_TIMESTAMP('2025-03-06 15:34:34', 'YYYY-MM-DD HH24:MI:SS'),null,null,null);

INSERT INTO comments (comment_no,user_no,board_no,content,create_at,update_at,delete_at,ref)
VALUES(50005,90003,10003,'ㅋㅋㅋ',TO_TIMESTAMP('2025-03-07 15:35:34', 'YYYY-MM-DD HH24:MI:SS'),null,null,null);

INSERT INTO comments (comment_no,user_no,board_no,content,create_at,update_at,delete_at,ref)
VALUES(50006,90003,10005,'ㅋㅋㅋㅋㅋ',TO_TIMESTAMP('2025-03-07 15:36:34', 'YYYY-MM-DD HH24:MI:SS'),null,TO_TIMESTAMP('2025-03-07 15:37:34', 'YYYY-MM-DD HH24:MI:SS'),50005);
------------------------------------------------------------------- Comments 삽입 End


SELECT OWNER, CONSTRAINT_NAME , CONSTRAINT_TYPE, TABLE_NAME
FROM user_constraints
WHERE TABLE_NAME LIKE '%%';
----------------------------------------------------- 테이블 조회
SELECT * FROM users;
SELECT * FROM boards;
SELECT * FROM comments;
----------------------------------------------------- 테이블 조회
delete users where user_no = 90006;
create sequence user_seq start with 90006 increment by 1;
create sequence board_seq start with 10006 increment by 1;
create sequence comment_seq start with 50006 increment by 1;
commit;
rollback;

SELECT 
    c.COMMENT_NO, b.BOARD_NO, u.user_id, title
    B.CONTENT as b_content, C.CONTENT as c_content, 
    B.CREATE_AT as b_create_at, B.UPDATE_AT as b_update_at, 
    C.CREATE_AT as c_create_at, C.UPDATE_AT as c_update_at, REF FROM BOARDS b JOIN COMMENTS c on b.BOARD_NO = c.board_no
    join users u on c.user_no = u.user_no WHERE b.BOARD_NO = 10001;

SELECT 
C.COMMENT_NO, B.BOARD_NO, U.USER_ID, TITLE, 
B.CONTENT AS B_CONTENT, C.CONTENT AS C_CONTENT,
B.CREATE_AT AS B_CREATE_AT, B.UPDATE_AT AS B_UPDATE_AT,
C.CREATE_AT AS C_CREATE_AT, C.UPDATE_AT AS C_UPDATE_AT, REF
FROM BOARDS B JOIN COMMENTS C ON B.BOARD_NO = C.BOARD_NO
JOIN USERS U ON C.USER_no = U.USER_no WHERE BOARD_NO = 10001;

SELECT 
    B.BOARD_NO,
    U2.USER_ID AS BOARD_USER_ID,  -- 게시글 작성자
    U1.USER_ID AS COMMENT_USER_ID,  -- 댓글 작성자
    B.TITLE,
    B.CONTENT AS B_CONTENT, 
    C.CONTENT AS C_CONTENT,
    B.CREATE_AT AS B_CREATE_AT, 
    B.UPDATE_AT AS B_UPDATE_AT,
    C.CREATE_AT AS C_CREATE_AT, 
    C.UPDATE_AT AS C_UPDATE_AT, 
    C.DELETE_AT AS C_DELETE_AT,
    C.REF
FROM BOARDS B 
LEFT JOIN COMMENTS C ON B.BOARD_NO = C.BOARD_NO
LEFT JOIN USERS U1 ON C.USER_NO = U1.USER_NO  -- 댓글 작성자
LEFT JOIN USERS U2 ON B.USER_NO = U2.USER_NO  -- 게시글 작성자
WHERE B.BOARD_NO = 10001;
