.header on
.mode column
.nullvalue NULL

CREATE TABLE tblBookInfo(
    isbn INTEGER PRIMARY KEY, -- 기본키로 설정
    title TEXT,
    price INTEGER,
    publisher_id INTEGER
);

INSERT INTO tblBookInfo
VALUES(100000000000, 'SQLite 3', 30000, 1);

INSERT INTO tblBookInfo
VALUES(200000000000, '빠르게 활용하는 파이썬 3', 26000, 1);

SELECT ROWID, isbn, title
FROM tblBookInfo;

INSERT INTO tblBookInfo(title, price, publisher_id)
VALUES('C++ Standard Library', 30000, NULL);

SELECT ROWID, isbn, title FROM tblBookInfo;

----------------------------------------------------

CREATE TABLE tblEmployee(
    name TEXT,
    job TEXT,
    PRIMARY KEY(name, job));

INSERT INTO tblEmployee VALUES('Kim', 'manager');
INSERT INTO tblEmployee VALUES('Kim', 'CEO');

SELECT * FROM tblEmployee;

SELECT ROWID, name, job FROM tblEmployee;

----------------------------------------------------

CREATE TABLE tblPublisherInfo(
    publisher_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT
);

INSERT INTO tblPublisherInfo
VALUES(1, 'Wikibooks'); 	-- 기본키를 명시적으로 입력
INSERT INTO tblPublisherInfo(name)
VALUES('Apple Press');  	-- 기본키를 생략
INSERT INTO tblPublisherInfo
VALUES(100, 'Apress');  	-- 기본키를 비순차적으로 입력
INSERT INTO tblPublisherInfo(name)
VALUES('IT Press');		-- 기본키를 생략, 101이 입력됨

SELECT * FROM tblPublisherInfo; 

SELECT * FROM sqlite_sequence;

INSERT INTO tblPublisherInfo
VALUES(9223372036854775807, 'Max Sequence Number');
INSERT INTO tblPublisherInfo(name)
VALUES('이것은 입력 실패');

----------------------------------------------------




