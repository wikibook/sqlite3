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
VALUES(200000000000, '������ Ȱ���ϴ� ���̽� 3', 26000, 1);
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
    title TEXT NOT NULL,            -- ������
    before_price INTEGER,           -- ������ ����
    after_price INTEGER,    -- ������ ����
    datetime NOT NULL DEFAULT CURRENT_TIMESTAMP   -- ������ �Ͻ�
);

CREATE TRIGGER tr_BookInfo_Insert  	-- Ʈ���� �̸�
BEFORE INSERT ON tblBookInfo         	-- Ʈ���� ���� ����, ����, ��� ���̺� ����
BEGIN                                  	-- Ʈ���� ����
    INSERT INTO tblBookInfoLog(operation, title, after_price)
    VALUES('INSERT', NEW.title, NEW.price);
END;

INSERT INTO tblBookInfo(isbn, title, price, publisher_id)
VALUES(120000000000, 'Database Turning', 42000, 1);  -- �ű� ���ڵ� �Է�

SELECT * FROM tblBookInfoLog;  -- �α� ���� Ȯ��


CREATE TRIGGER tr_BookInfo_Delete
AFTER DELETE ON tblBookInfo   -- tblBookInfo ���̺� ������ ���� Ʈ���� ����
BEGIN
    INSERT INTO tblBookInfoLog(operation, title, before_price)
    VALUES('DELETE', OLD.title, OLD.price);
END;

DELETE FROM tblBookInfo  -- Database Turning ���ڵ� ����
WHERE title = 'Database Turning';

SELECT * FROM tblBookInfoLog;

CREATE TRIGGER tr_BookInfo_Update_Price
AFTER UPDATE OF price ON tblBookInfo  -- tblBookInfo�� price�� ����͸�
BEGIN
    INSERT INTO tblBookInfoLog(operation, title, before_price, after_price)
    VALUES('UPDATE', NEW.title, OLD.price, NEW.price);
END;

UPDATE tblBookInfo SET price = 32000  -- price�� �����ϴ� ���
WHERE title = 'SQLite 3';

SELECT * FROM tblBookInfoLog;

UPDATE tblBookInfo SET title = 'SQLITE 3'  -- title�� �����ϴ� ���
WHERE title = 'SQLite3';

SELECT * FROM tblBookInfoLog;


CREATE TRIGGER tr_BookInfo_Delete_Wikibooks
AFTER DELETE ON tblBookInfo     	
WHEN OLD.publisher_id = 1  -- Ʈ���Ű� ����� ����
BEGIN
    INSERT INTO tblBookInfoLog(operation, title, before_price)
    VALUES('DELETE_Wikibooks', OLD.title, OLD.price);
END;

DELETE FROM tblBookInfo
WHERE title = 'Android programming';   -- ���ǻ簡 'Wikibooks'�� å�� ����
SELECT * FROM tblBookInfoLog;

-------------------------------------------------

CREATE TRIGGER tr_vwPrettyBookInfo_Update
INSTEAD OF UPDATE ON vwPrettyBookInfo  -- UPDATE ��� Ʈ���� ����
BEGIN
    UPDATE tblBookInfo SET price = NEW.price
    WHERE price = OLD.price;
END;

UPDATE vwPrettyBookInfo SET PRICE = 15000
WHERE PRICE = 14000;


