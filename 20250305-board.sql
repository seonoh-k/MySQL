CREATE TABLE boards (
    board_id    number(15)          CONSTRAINT boards_board_id_pk PRIMARY KEY,
    user_id	    number(15)		    CONSTRAINT boards_user_id_nn NOT NULL,
    title	    VARCHAR2(20)		CONSTRAINT boards_title_nn NOT NULL,
    content	    VARCHAR2(300)	    CONSTRAINT boards_content_nn NOT NULL,
    create_at   DATE		        CONSTRAINT boards_create_at_nn NOT NULL,
    update_at   DATE	            DEFAULT null,
    delete_at   DATE	            DEFAULT null,
    view_cnt    number(15)		    CONSTRAINT boards_view_cnt_nn NOT NULL
);

CREATE TABLE comments (
    comment_id  number(15)          CONSTRAINT comments_comment_id_pk PRIMARY KEY,
    user_id	    number(15)	        CONSTRAINT comments_user_id_nn	NOT NULL,
    board_id    number(15)	        CONSTRAINT comments_board_id_nn	NOT NULL,
    content	    VARCHAR2(300)	    CONSTRAINT comments_content_nn	NOT NULL,
    create_at   DATE	            CONSTRAINT comments_create_at_nn	NOT NULL,
    update_at   DATE	            DEFAULT NULL,
    delete_at   DATE	            DEFAULT	NULL
);

CREATE TABLE board_reactions (
    reaction_id NUMBER(15)          CONSTRAINT board_reacts_react_id_pk PRIMARY KEY,
    user_id     NUMBER(15)          CONSTRAINT board_reacts_user_id_nn NOT NULL,
    board_id    NUMBER(15)          CONSTRAINT board_reacts_board_id_nn NOT NULL,
    is_like     NUMBER(1)           CONSTRAINT board_reacts_is_like_nn NOT NULL,
    is_unlike   NUMBER(1)           CONSTRAINT board_reacts_is_unlike_nn NOT NULL   
);

CREATE TABLE comment_reactions (
    reaction_id NUMBER(15)          CONSTRAINT comment_reacts_react_id_pk PRIMARY KEY,
    comment_id  NUMBER(15)          CONSTRAINT comment_reacts_comment_id_nn NOT NULL,
    user_id	    NUMBER(15)          CONSTRAINT comment_reacts_user_id_nn	NOT NULL,
    is_like	    NUMBER(1)           CONSTRAINT comment_reacts_is_like_nn NOT NULL,
    is_unlike   NUMBER(1)           CONSTRAINT comment_reacts_is_unlike_nn NOT NULL
);

CREATE TABLE users (
    user_id	    NUMBER(15)          CONSTRAINT users_user_id_pk PRIMARY KEY,
    
    user_email  VARCHAR2(30)        CONSTRAINT users_user_email_nn	NOT NULL 
                                    CONSTRAINT users_user_email_uq	UNIQUE,
                                    
    user_name   VARCHAR2(10)        CONSTRAINT users_user_name_nn	NOT NULL,
    user_pass   VARCHAR2(15)        CONSTRAINT users_user_pass_nn	NOT NULL,
    user_gender VARCHAR2(2)	        CONSTRAINT users_user_gender_nn	NOT NULL,
    user_birth  DATE	            CONSTRAINT users_user_birth_nn	NOT NULL
);

ALTER TABLE boards              ADD CONSTRAINT FK_users_TO_boards_1 
FOREIGN KEY (user_id)           REFERENCES users (user_id);

ALTER TABLE comments            ADD CONSTRAINT FK_users_TO_comments_1 
FOREIGN KEY (user_id)           REFERENCES users (user_id);

ALTER TABLE comments            ADD CONSTRAINT FK_boards_TO_comments_1 
FOREIGN KEY (board_id)          REFERENCES boards (board_id);

ALTER TABLE board_reactions     ADD CONSTRAINT FK_users_TO_board_reacts_1 
FOREIGN KEY (user_id)           REFERENCES users (user_id);

ALTER TABLE board_reactions     ADD CONSTRAINT FK_boards_TO_board_reacts_1 
FOREIGN KEY (board_id)          REFERENCES boards (board_id);

ALTER TABLE comment_reactions   ADD CONSTRAINT FK_commts_TO_cmmt_reacts_1 
FOREIGN KEY (comment_id)        REFERENCES comments (comment_id);

ALTER TABLE comment_reactions   ADD CONSTRAINT FK_users_TO_cmmt_reacts_1 
FOREIGN KEY (user_id)           REFERENCES users (user_id);

------------------------------------------ 제약조건 확인
SELECT OWNER, CONSTRAINT_NAME , CONSTRAINT_TYPE, TABLE_NAME
FROM user_constraints
WHERE TABLE_NAME LIKE '%%';
-- 참조키 제약 7개 
-- 기본키 제약 테이블당 1개 TOTAL : 5
------------------------------------------ 제약조건 확인
------------------------------------------ 테이블 조회
SELECT * FROM boards;
SELECT * FROM board_reactions;
SELECT * FROM users;
SELECT * FROM comments;
SELECT * FROM comment_reactions;
------------------------------------------ 테이블 조회