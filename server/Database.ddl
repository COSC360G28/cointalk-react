DROP TABLE IF EXISTS postLiked;
DROP TABLE IF EXISTS commentLiked;
DROP TABLE IF EXISTS comment;
DROP TABLE IF EXISTS post;
DROP TABLE IF EXISTS account;
DROP TABLE IF EXISTS coin;
DROP TYPE IF EXISTS post_type;

CREATE TYPE post_type AS ENUM ('text', 'pic');

CREATE TABLE account (
	uid SERIAL NOT NULL,
	username VARCHAR(20),
	password VARCHAR(30),
	email VARCHAR(50),
	accountScore INT,
	accountAvatarURL VARCHAR(100),
	dateCreated TIMESTAMP,
	admin BOOLEAN,
	PRIMARY KEY (uid)
);

CREATE TABLE coin (
	abbreviation VARCHAR(10) NOT NULL,
	name VARCHAR(30),
	PRIMARY KEY (abbreviation)
);

CREATE TABLE post (
	pid SERIAL NOT NULL,
	title VARCHAR(300),
    userID INT,
	date TIMESTAMP,
	type post_type,
	text VARCHAR(1000),
	imageURL VARCHAR(100),
	score INT,
	coin VARCHAR(10),
	PRIMARY KEY (pid),
	FOREIGN KEY (userID) REFERENCES account(uid) ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY (coin) REFERENCES coin(abbreviation) ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE comment (
	cid SERIAL NOT NULL,
	content VARCHAR(1000),
    userID INT,
	score INT,
	date TIMESTAMP,
	mainPostID INT,
	parentID INT,
	PRIMARY KEY (cid),
	FOREIGN KEY (userID) REFERENCES account(uid) ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY (mainPostID) REFERENCES post(pid),
	FOREIGN KEY (parentID) REFERENCES comment(cid)
);

CREATE TABLE postLiked ( --any entries in here mean that the post was liked by the account
	accountID INT,
	postID INT,
	FOREIGN KEY (accountID) REFERENCES account(uid),
	FOREIGN KEY (postID) REFERENCES post(pid)
);

CREATE TABLE commentLiked ( -- any entries in here mean that the comment was liked by the account
	accountID INT,
	commentID INT,
	FOREIGN KEY (accountID) REFERENCES account(uid),
	FOREIGN KEY (commentID) REFERENCES comment(cid)
);

INSERT INTO coin(name, abbreviation) VALUES ('Ethereum', 'ETH');
INSERT INTO coin(name, abbreviation) VALUES ('Bitcoin', 'BTC');
INSERT INTO coin(name, abbreviation) VALUES ('Ripple', 'XRP');
INSERT INTO coin(name, abbreviation) VALUES ('Neo', 'NEO');

INSERT INTO account(username, password, email, dateCreated, admin) VALUES ('admin', 'admin', 'test@test.com', '2021-03-11 03:21:10', TRUE);
INSERT INTO account(username, password, email, dateCreated, admin) VALUES ('arnold', 'pass', 'arnold@test.com', '2021-03-12 13:13:10', FALSE);
INSERT INTO account(username, password, email, dateCreated, admin) VALUES ('james', '123', 'james@test.com', '2021-03-20 10:36:01', FALSE);
INSERT INTO account(username, password, email, dateCreated, admin) VALUES ('bobby', 'iforgot', 'bobby@test.com', '2021-03-21 19:46:47', FALSE);

INSERT INTO post(title, text, userID, date, type, score, coin) VALUES('Testing of posts BTC', 'This is a test of the posting system, hopefully it works well in Bitcoin', 1, '2021-03-15 01:58:59', 'text', 3, 'BTC');
INSERT INTO post(title, text, userID, date, type, score, coin) VALUES('Testing of posts ETH', 'This is a test of the posting system, hopefully it works well in Etherium', 1, '2021-03-15 05:32:12', 'text', 3, 'ETH');
INSERT INTO post(title, text, userID, date, type, score, coin) VALUES('Newcomer''s Beware!', 'Cryptos are not for everyone and you should be ready to lose money if you''re not careful!', 2, '2021-03-16 09:59:24', 'text', 1, 'BTC');

INSERT INTO comment(content, userID, score, date, mainPostID) VALUES ('Yeah but you can also make a lot of money :D', 3, 5, '2021-03-22 01:06:09', 3);
INSERT INTO comment(content, userID, score, date, mainPostID, parentID) VALUES ('YUP', 2, 3, '2021-03-22 04:06:32', 3, 1);
INSERT INTO comment(content, userID, score, date, mainPostID, parentID) VALUES ('Absolutely!', 1, 1, '2021-03-22 07:44:22', 3, 1);
INSERT INTO comment(content, userID, score, date, mainPostID, parentID) VALUES ('Glad you agree!', 3, 2, '2021-03-23 13:11:54', 3, 2);
INSERT INTO comment(content, userID, score, date, mainPostID) VALUES ('yeah it''s too spooky for me', 4, 0, '2021-03-24 18:33:21', 3);