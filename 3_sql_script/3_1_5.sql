.header on
.mode column
.nullvalue NULL
.width 28 15 22 8

CREATE TABLE IF NOT EXISTS tblBookInfo  -- ���̺��� ���� ��쿡�� ����
(
    title TEXT,
    publisher TEXT,
    author TEXT,
    price INTEGER
);

INSERT INTO tblBookInfo 
VALUES('SQLite 3', 'Wikibooks', 'Derick, DSP', 30000);
INSERT INTO tblBookInfo 
VALUES('������ Ȱ���ϴ� ���̽� 3', 'Wikibooks', '��ȣö, �����, �ֵ���', 26000);
INSERT INTO tblBookInfo 
VALUES('C++ Standard Library', 'Addison Wesley', 'Nicolai Josuttis', 30000);
INSERT INTO tblBookInfo 
VALUES('Advanced Programming', 'Addison Wesley', 'Stevens Rago', 48000);
INSERT INTO tblBookInfo 
VALUES("Steve Jobs' Presentation", 'Apple Press', 'Steve Jobs', 13000);
INSERT INTO tblBookInfo 
VALUES("Computer Programming", 'Apress', 'Derick', 25000);
INSERT INTO tblBookInfo 
VALUES("iPhone programming", 'Wikibooks', 'Amy, Derick, �ֵ���', 25000);
INSERT INTO tblBookInfo 
VALUES("JSP guide", 'Apress', NULL, 7000);
INSERT INTO tblBookInfo 
VALUES("software conflict 2.0", 'Wikibooks', NULL, 22000);

SELECT title, publisher, author, price FROM tblBookInfo;

SELECT * FROM tblBookInfo;

SELECT publisher, title FROM tblBookInfo;

SELECT * FROM tblBookInfo
WHERE publisher = 'Wikibooks';

SELECT * FROM tblBookInfo 
WHERE price < 20000;

SELECT * FROM tblBookInfo 
WHERE title < 'a';

SELECT title, price FROM tblBookInfo WHERE title < 'a';

SELECT title, publisher, price FROM tblBookInfo
WHERE publisher = 'Wikibooks' AND price > 20000;

SELECT title, publisher, price FROM tblBookInfo
WHERE publisher = 'Wikibooks' OR publisher = 'Addison Wesley';

SELECT title, publisher, price FROM tblBookInfo
WHERE publisher = 'Wikibooks' OR price > 25000;

SELECT title, publisher FROM tblBookInfo WHERE title LIKE 'C%';

SELECT title, publisher FROM tblBookInfo WHERE title LIKE '������%';

SELECT title, publisher FROM tblBookInfo WHERE title LIKE '%Programming';

SELECT title, author FROM tblBookInfo WHERE author LIKE '%Derick%';

SELECT title, publisher FROM tblBookInfo WHERE publisher LIKE 'Wikiboo__';

SELECT title, publisher FROM tblBookInfo WHERE publisher LIKE 'Wikiboo_';

SELECT title, price FROM tblBookInfo 
WHERE price >= 25000 AND price <= 30000;

SELECT title, price FROM tblBookInfo 
WHERE price BETWEEN 25000 AND 30000; 

SELECT title FROM tblBookInfo WHERE title BETWEEN 'A' AND 'Z';

SELECT title, publisher FROM tblBookInfo
WHERE publisher = 'Apress' OR publisher = 'Wikibooks';

SELECT title, publisher FROM tblBookInfo
WHERE publisher IN ('Apress', 'Wikibooks');

SELECT title, publisher FROM tblBookInfo 
WHERE NOT publisher = 'Wikibooks';

SELECT title, publisher, price FROM tblBookInfo
WHERE publisher = 'Wikibooks' AND NOT price > 25000;

SELECT title, publisher FROM tblBookInfo
WHERE NOT title LIKE '%Programming';

SELECT title, price FROM tblBookInfo 
WHERE NOT price BETWEEN 25000 AND 30000;

SELECT title, publisher FROM tblBookInfo
WHERE NOT publisher IN ('Apress', 'Wikibooks');

SELECT title, publisher FROM tblBookInfo 
WHERE publisher NOT IN ('Apress', 'Wikibooks');

SELECT title, publisher FROM tblBookInfo ORDER BY title ASC;

SELECT title, publisher FROM tblBookInfo ORDER BY title;

SELECT title, publisher FROM tblBookInfo ORDER BY title DESC;

SELECT title, publisher FROM tblBookInfo
WHERE price = 25000 ORDER BY title;

SELECT publisher, title FROM tblBookInfo
ORDER BY publisher ASC, title DESC;

SELECT publisher, title FROM tblBookInfo 
ORDER BY 1;  -- ORDER BY publisher�� ����

SELECT publisher, title FROM tblBookInfo ORDER BY publisher ASC, title DESC;

SELECT publisher, title FROM tblBookInfo ORDER BY 1 ASC, 2 DESC;

SELECT title, publisher FROM tblBookInfo ORDER BY title LIMIT 2;

SELECT title, publisher FROM tblBookInfo 
ORDER BY title LIMIT 3, 2;  -- ���� 4��°, 5��° ���ڵ带 ��ȸ

SELECT title, author FROM tblBookInfo 
WHERE author IS NULL;

SELECT title, author FROM tblBookInfo
WHERE author = NULL; -- NULL �� ������ �׻� ���� �ٸ�

SELECT title, author FROM tblBookInfo
WHERE author = 'NULL'; -- author �÷��� ���ڿ� 'NULL'�� ���ڵ带 ��ȸ

SELECT title, author FROM tblBookInfo
WHERE author = 0; -- author �÷��� ������ 0 �� ���ڵ带 ��ȸ

SELECT title, author FROM tblBookInfo 
WHERE author IS NOT NULL;


