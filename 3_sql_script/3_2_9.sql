.header on
.mode column
.nullvalue NULL

PRAGMA foreign_keys = 1;


CREATE TABLE tblBookInfo(
	isbn INTEGER PRIMARY KEY,
	title TEXT,
	price INTEGER,
	publisher_id INTEGER,
	CONSTRAINT ctPublisherID_fk FOREIGN KEY(publisher_id)
    REFERENCES tblPublisherInfo(publisher_id)
);

CREATE TABLE tblPublisherInfo(
	publisher_id INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT
);

INSERT INTO tblPublisherInfo VALUES(1, 'Wikibooks');
INSERT INTO tblPublisherInfo VALUES(2, 'Apple Press');
INSERT INTO tblPublisherInfo VALUES(3, 'Apress');
INSERT INTO tblPublisherInfo VALUES(4, 'IT Press');

INSERT INTO tblBookInfo 
VALUES(100000000000, 'SQLite 3', 30000, 1);
INSERT INTO tblBookInfo 
VALUES(200000000000, '빠르게 활용하는 파이썬 3', 26000, 1);
INSERT INTO tblBookInfo
VALUES(300000000000, 'C++ Standard Library', 30000, NULL);
INSERT INTO tblBookInfo 
VALUES(400000000000, "Steve Jobs' Presentation", 13000, 2);
INSERT INTO tblBookInfo 
VALUES(500000000000, 'Computer Programming', 25000, 3);
INSERT INTO tblBookInfo 
VALUES(600000000000, 'iPhone programming', 26000, 1);
INSERT INTO tblBookInfo 
VALUES(700000000000, 'Android programming', 36000, 1);
INSERT INTO tblBookInfo 
VALUES(800000000000, 'Hacking Guide', 14000, 3);
INSERT INTO tblBookInfo 
VALUES(900000000000, 'How to play the iPhone', 7000, 2);
INSERT INTO tblBookInfo 
VALUES(110000000000, 'Computer Programming', 7000, 4);

CREATE VIEW vwPrettyBookInfo
AS
    SELECT tblBookInfo.title || ' (' || tblPublisherInfo.name || ')' AS NAME, 
    price AS PRICE
    FROM tblBookInfo, tblPublisherInfo
    WHERE tblBookInfo.publisher_id = tblPublisherInfo.publisher_id;

CREATE TABLE tblBookInfoLog(
    operation TEXT NOT NULL
        CHECK(operation IN ('INSERT', 'DELETE','UPDATE', 'DELETE_Wikibooks')),
    title TEXT NOT NULL,            -- 도서명
    before_price INTEGER,           -- 수정전 가격
    after_price INTEGER,    -- 수정후 가격
    datetime NOT NULL DEFAULT CURRENT_TIMESTAMP   -- 수정한 일시
);

CREATE TRIGGER tr_BookInfo_Insert  	-- 트리거 이름
BEFORE INSERT ON tblBookInfo         	-- 트리거 동작 시점, 동작, 대상 테이블 지정
BEGIN                                  	-- 트리거 동작
    INSERT INTO tblBookInfoLog(operation, title, after_price)
    VALUES('INSERT', NEW.title, NEW.price);
END;

INSERT INTO tblBookInfo(isbn, title, price, publisher_id)
VALUES(120000000000, 'Database Turning', 42000, 1);  -- 신규 레코드 입력

SELECT * FROM tblBookInfoLog;  -- 로그 정보 확인


CREATE TRIGGER tr_BookInfo_Delete
AFTER DELETE ON tblBookInfo   -- tblBookInfo 테이블에 삭제된 직후 트리거 수행
BEGIN
    INSERT INTO tblBookInfoLog(operation, title, before_price)
    VALUES('DELETE', OLD.title, OLD.price);
END;

DELETE FROM tblBookInfo  -- Database Turning 레코드 삭제
WHERE title = 'Database Turning';

SELECT * FROM tblBookInfoLog;

CREATE TRIGGER tr_BookInfo_Update_Price
AFTER UPDATE OF price ON tblBookInfo  -- tblBookInfo의 price만 모니터링
BEGIN
    INSERT INTO tblBookInfoLog(operation, title, before_price, after_price)
    VALUES('UPDATE', NEW.title, OLD.price, NEW.price);
END;

UPDATE tblBookInfo SET price = 32000  -- price를 변경하는 경우
WHERE title = 'SQLite 3';

SELECT * FROM tblBookInfoLog;

UPDATE tblBookInfo SET title = 'SQLITE 3'  -- title을 변경하는 경우
WHERE title = 'SQLite3';

SELECT * FROM tblBookInfoLog;


CREATE TRIGGER tr_BookInfo_Delete_Wikibooks
AFTER DELETE ON tblBookInfo     	
WHEN OLD.publisher_id = 1  -- 트리거가 수행될 조건
BEGIN
    INSERT INTO tblBookInfoLog(operation, title, before_price)
    VALUES('DELETE_Wikibooks', OLD.title, OLD.price);
END;

DELETE FROM tblBookInfo
WHERE title = 'Android programming';   -- 출판사가 'Wikibooks'인 책을 삭제
SELECT * FROM tblBookInfoLog;

-------------------------------------------------

CREATE TRIGGER tr_vwPrettyBookInfo_Update
INSTEAD OF UPDATE ON vwPrettyBookInfo  -- UPDATE 대신 트리거 수행
BEGIN
    UPDATE tblBookInfo SET price = NEW.price
    WHERE price = OLD.price;
END;

UPDATE vwPrettyBookInfo SET PRICE = 15000
WHERE PRICE = 14000;


