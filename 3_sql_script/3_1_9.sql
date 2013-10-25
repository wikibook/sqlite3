.header on
.mode column
.nullvalue NULL

CREATE TABLE tblBookInfo 
(
    title TEXT,
    publisher TEXT,
    price INTEGER
);

INSERT INTO tblBookInfo
VALUES('SQLite 3','Wikibooks', 30000);
INSERT INTO tblBookInfo 
VALUES('������ Ȱ���ϴ� ���̽� 3','Wikibooks', 26000);
INSERT INTO tblBookInfo 
VALUES('C++ Standard Library','Addison Wesley', 30000);
INSERT INTO tblBookInfo 
VALUES('Steve Jobs'' Presentation','Apple Press', 13000);
INSERT INTO tblBookInfo 
VALUES('Computer Programming','Apress','Derick',25000);
INSERT INTO tblBookInfo 
VALUES('iPhone programming','Wikibooks',26000);
INSERT INTO tblBookInfo 
VALUES('Android programming', 'Wikibooks', 36000);
INSERT INTO tblBookInfo 
VALUES('Hacking Guide', 'Wikibooks', 14000);
INSERT INTO tblBookInfo 
VALUES('How to play the iPhone', 'Apple Press', 7000);
INSERT INTO tblBookInfo 
VALUES('Computer Programming', 'IT Press', 7000);

SELECT publisher, count(*) FROM tblBookPrice
WHERE publisher = 'Wikibooks';

SELECT publisher, count(*)	-- �� ���ǻ纰�� �Ⱓ�� å�� �� �� ��ȸ
FROM tblBookPrice
GROUP BY publisher;   	-- publisher �÷��� �������� �׷�ȭ

SELECT publisher, count(*)
FROM tblBookPrice
GROUP BY 1;  -- SELECT ���� ù �÷����� �׷�ȭ

SELECT publisher AS PUB, count(*) AS Count
FROM tblBookPrice
GROUP BY PUB;

SELECT publisher, price, count(*)
FROM tblBookPrice
GROUP BY publisher, price;  -- publisher, price ������ �׷�ȭ

SELECT publisher, count(*)
FROM tblBookPrice
WHERE publisher IN ('Wikibooks', 'Apress' )
GROUP BY publisher;

SELECT publisher, count(*)
FROM tblBookPrice
GROUP BY publisher
HAVING count(*)>=2;  -- �ش� �׷��� ������ 2�� �̻��� ���ո� ��ȸ

SELECT publisher, count(*) FROM tblBookPrice
WHERE publisher IN ('Wikibooks', 'IT Press')  
GROUP BY publisher
HAVING count(*)>=2;

SELECT publisher, count(*) AS Count
FROM tblBookPrice
GROUP BY publisher
ORDER BY Count DESC;

