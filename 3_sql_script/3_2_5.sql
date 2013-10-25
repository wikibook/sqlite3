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

SELECT tblBookInfo.title, tblBookInfo.price, tblPublisherInfo.name
FROM tblBookInfo INNER JOIN tblPublisherInfo    -- ���� ������ ���̺�
ON tblBookInfo.publisher_id = tblPublisherInfo.publisher_id;  -- ���� ����

SELECT tblBookInfo.title, tblBookInfo.price, tblPublisherInfo.name
FROM tblBookInfo INNER JOIN tblPublisherInfo   
ON tblBookInfo.publisher_id = tblPublisherInfo.publisher_id  
WHERE tblPublisherInfo.name = 'Wikibooks';  -- ���ǻ��� �̸����� ���͸�

SELECT tblBookInfo.title, tblBookInfo.price, tblPublisherInfo.name
FROM tblBookInfo, tblPublisherInfo    -- ���� ������ ���̺�
WHERE tblBookInfo.publisher_id = tblPublisherInfo.publisher_id;  -- ���� ����

SELECT tblBookInfo.title, tblBookInfo.price, tblPublisherInfo.name
FROM tblBookInfo, tblPublisherInfo    -- ���� ������ ���̺�
WHERE tblBookInfo.publisher_id = tblPublisherInfo.publisher_id  -- ���� ����
AND tblPublisherInfo.name = 'Wikibooks';  -- ���ǻ� �̸��� ���͸�


SELECT title, price, name  -- ���̺� �̸��� ������ ���
FROM tblBookInfo, tblPublisherInfo
WHERE tblBookInfo.publisher_id = tblPublisherInfo.publisher_id
AND tblPublisherInfo.name = 'Wikibooks';

SELECT B.title, B.price, P.name
FROM tblBookInfo AS B, tblPublisherInfo AS P  -- ���̺��� ��Ī ����
WHERE B.publisher_id = P.publisher_id
AND P.name = 'Wikibooks'
ORDER BY B.title;


SELECT title, price
FROM tblBookInfo
WHERE price = ( SELECT price FROM tblBookInfo
                WHERE title = 'SQLite 3');

SELECT B1.title, B1.price
FROM tblBookInfo AS B1, tblBookInfo AS B2  -- ���� ���̺��� ��Ī���� ����
WHERE B1.price = B2.price	-- ���� ����
AND B2.title = 'SQLite 3'; 	-- ���͸� ����

SELECT B1.title, B1.price
FROM tblBookInfo AS B1, tblBookInfo AS B2
WHERE B1.price > B2.price
AND B2.title = 'SQLite 3';

SELECT *
FROM tblBookInfo NATURAL JOIN tblPublisherInfo;

SELECT *
FROM tblBookInfo, tblPublisherInfo
WHERE tblBookInfo.publisher_id = tblPublisherInfo.publisher_id;

SELECT title, publisher_id FROM tblBookInfo;

SELECT tblBookInfo.title, tblBookInfo.price, tblPublisherInfo.name
FROM tblBookInfo LEFT OUTER JOIN tblPublisherInfo  -- �ܺ� ������ ���̺��� ����
ON tblBookInfo.publisher_id = tblPublisherInfo.publisher_id;

SELECT name, (  SELECT COUNT(*) FROM tblBookInfo
                WHERE tblBookInfo.publisher_id = tblPublisherInfo.publisher_id) AS count
FROM tblPublisherInfo;

SELECT name, count(*) AS Count
FROM tblBookInfo, tblPublisherInfo  -- ������ ���̺�
WHERE tblBookInfo.publisher_id = tblPublisherInfo.publisher_id  -- ���� ����
GROUP BY tblBookInfo.publisher_id  -- �׷�ȭ
ORDER BY Count DESC;   -- ���� ����

SELECT tblPublisherInfo.name, count(*) AS Count
FROM tblBookInfo LEFT OUTER JOIN tblPublisherInfo  -- ���� �ܺ� ����
ON tblBookInfo.publisher_id = tblPublisherInfo.publisher_id
GROUP BY tblBookInfo.publisher_id
ORDER BY Count DESC;













