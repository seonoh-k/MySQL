DROP TABLE IF EXISTS boards;

CREATE TABLE boards (
    board_id NUMBER(15) NOT NULL,
    user_id NUMBER(15) NOT NULL,
    title VARCHAR2(20) NOT NULL,
    content VARCHAR2(300) NOT NULL,
    create_at DATE NOT NULL,
    update_at DATE DEFAULT NULL,
    delete_at DATE NULL,
    view_cnt NUMBER(15) NULL
);
select * from users;
DROP TABLE IF EXISTS comments;

CREATE TABLE comments (
	comment_id	number(15)	NOT NULL,
	user_id	number(15)	NOT NULL,
	board_id	number(15)	NOT NULL,
	content	VARCHAR2(300)	NOT NULL,
	create_at	DATE	NOT NULL,
	update_at	DATE	DEFAULT null,
	delete_at	DATE	NULL
);

DROP TABLE IF EXISTS board_reactions;

CREATE TABLE board_reactions (
	reaction_id	number(15)	NOT NULL,
	user_id	number(15)	NOT NULL,
	board_id	number(15)	NOT NULL,
	is_like	number(1)	NULL,
	is_unlike	number(1)	NULL
);

DROP TABLE IF EXISTS comment_reactions;

CREATE TABLE comment_reactions (
	reaction_id	number(15)	NOT NULL,
	comment_id	number(15)	NOT NULL,
	user_id	number(15)	NOT NULL,
	is_like	number(1)	NULL,
	is_unlike	number(1)	NULL
);

DROP TABLE IF EXISTS users;

CREATE TABLE users (
	user_id	number(15)	NOT NULL,
	user_email	VARCHAR2(30)	NOT NULL,
	user_name	VARCHAR2(10)	NOT NULL,
	user_pass	VARCHAR2(15)	NOT NULL,
	user_gender	VARCHAR2(2)	NOT NULL,
	user_birth	DATE	NULL
);

ALTER TABLE boards ADD CONSTRAINT PK_BOARDS PRIMARY KEY (
	board_id
);

ALTER TABLE comments ADD CONSTRAINT PK_COMMENTS PRIMARY KEY (
	comment_id
);

ALTER TABLE board_reactions ADD CONSTRAINT PK_BOARD_REACTIONS PRIMARY KEY (
	reaction_id
);

ALTER TABLE comment_reactions ADD CONSTRAINT PK_COMMENT_REACTIONS PRIMARY KEY (
	reaction_id
);

ALTER TABLE users ADD CONSTRAINT PK_USERS PRIMARY KEY (
	user_id
);

ALTER TABLE boards ADD CONSTRAINT FK_users_TO_boards_1 FOREIGN KEY (
	user_id
)
REFERENCES users (
	user_id
);

ALTER TABLE comments ADD CONSTRAINT FK_users_TO_comments_1 FOREIGN KEY (
	user_id
)
REFERENCES users (
	user_id
);

ALTER TABLE comments ADD CONSTRAINT FK_boards_TO_comments_1 FOREIGN KEY (
	board_id
)
REFERENCES boards (
	board_id
);

ALTER TABLE board_reactions ADD CONSTRAINT FK_users_TO_board_reactions_1 FOREIGN KEY (
	user_id
)
REFERENCES users (
	user_id
);

ALTER TABLE board_reactions ADD CONSTRAINT FK_boards_TO_board_reactions_1 FOREIGN KEY (
	board_id
)
REFERENCES boards (
	board_id
);

ALTER TABLE comment_reactions ADD CONSTRAINT FK_comments_TO_comment_reactions_1 FOREIGN KEY (
	comment_id
)
REFERENCES comments (
	comment_id
);

ALTER TABLE comment_reactions ADD CONSTRAINT FK_users_TO_comment_reactions_1 FOREIGN KEY (
	user_id
)
REFERENCES users (
	user_id
);

commit;