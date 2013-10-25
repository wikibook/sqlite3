.header on
.mode column
.nullvalue NULL
.width 28 15 22 8

CREATE TABLE IF NOT EXISTS tblBookInfo  -- 테이블이 없는 경우에만 생성
(
    title TEXT,
    publisher TEXT,
    author TEXT,
    price INTEGER
);

INSERT INTO tblBookInfo 
VALUES('SQLite 3', 'Wikibooks', 'Derick, DSP', 30000);
INSERT INTO tblBookInfo 
VALUES('빠르게 활용하는 파이썬 3', 'Wikibooks', '신호철, 우상정, 최동진', 26000);
INSERT INTO tblBookInfo 
VALUES('C++ Standard Library', 'Addison Wesley', 'Nicolai Josuttis', 30000);
INSERT INTO tblBookInfo 
VALUES('Advanced Programming', 'Addison Wesley', 'Stevens Rago', 48000);
INSERT INTO tblBookInfo 
VALUES("Steve Jobs' Presentation", 'Apple Press', 'Steve Jobs', 13000);
INSERT INTO tblBookInfo 
VALUES("Computer Programming", 'Apress', 'Derick', 25000);
INSERT INTO tblBookInfo 
VALUES("iPhone programming", 'Wikibooks', 'Amy, Derick, 최동진', 25000);
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

SELECT title, publisher FROM tblBookInfo WHERE title LIKE '빠르게%';

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
ORDER BY 1;  -- ORDER BY publisher와 동일

SELECT publisher, title FROM tblBookInfo ORDER BY publisher ASC, title DESC;

SELECT publisher, title FROM tblBookInfo ORDER BY 1 ASC, 2 DESC;

SELECT title, publisher FROM tblBookInfo ORDER BY title LIMIT 2;

SELECT title, publisher FROM tblBookInfo 
ORDER BY title LIMIT 3, 2;  -- 상위 4번째, 5번째 레코드를 조회

SELECT title, author FROM tblBookInfo 
WHERE author IS NULL;

SELECT title, author FROM tblBookInfo
WHERE author = NULL; -- NULL 값 간에는 항상 서로 다름

SELECT title, author FROM tblBookInfo
WHERE author = 'NULL'; -- author 컬럼이 문자열 'NULL'인 레코드를 조회

SELECT title, author FROM tblBookInfo
WHERE author = 0; -- author 컬럼이 정수값 0 인 레코드를 조회

SELECT title, author FROM tblBookInfo 
WHERE author IS NOT NULL;


