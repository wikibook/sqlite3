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
VALUES('빠르게 활용하는 파이썬 3','Wikibooks', 26000);
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

SELECT publisher, count(*)	-- 각 출판사별로 출간된 책의 권 수 조회
FROM tblBookPrice
GROUP BY publisher;   	-- publisher 컬럼을 기준으로 그룹화

SELECT publisher, count(*)
FROM tblBookPrice
GROUP BY 1;  -- SELECT 문의 첫 컬럼으로 그룹화

SELECT publisher AS PUB, count(*) AS Count
FROM tblBookPrice
GROUP BY PUB;

SELECT publisher, price, count(*)
FROM tblBookPrice
GROUP BY publisher, price;  -- publisher, price 순으로 그룹화

SELECT publisher, count(*)
FROM tblBookPrice
WHERE publisher IN ('Wikibooks', 'Apress' )
GROUP BY publisher;

SELECT publisher, count(*)
FROM tblBookPrice
GROUP BY publisher
HAVING count(*)>=2;  -- 해당 그룹의 갯수가 2개 이상인 집합만 조회

SELECT publisher, count(*) FROM tblBookPrice
WHERE publisher IN ('Wikibooks', 'IT Press')  
GROUP BY publisher
HAVING count(*)>=2;

SELECT publisher, count(*) AS Count
FROM tblBookPrice
GROUP BY publisher
ORDER BY Count DESC;

