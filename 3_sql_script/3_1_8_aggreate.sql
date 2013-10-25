.header on
.mode column
.nullvalue NULL

CREATE TABLE tblBookPrice(
	title TEXT,
	publisher TEXT,
	price INTEGER);
INSERT INTO tblBookPrice 
VALUES('SQLite 3', 'Wikibooks', 30000);
INSERT INTO tblBookPrice 
VALUES('빠르게 활용하는 파이썬 3', 'Wikibooks', 26000);
INSERT INTO tblBookPrice 
VALUES('C++ Standard Library', NULL, 30000);
INSERT INTO tblBookPrice 
VALUES("Steve Jobs' Presentation", 'Apple Press', 13000);
INSERT INTO tblBookPrice 
VALUES('Computer Programming', 'Apress', 25000);
INSERT INTO tblBookPrice 
VALUES('iPhone programming', 'Wikibooks', 26000);
INSERT INTO tblBookPrice 
VALUES('Android programming', 'Wikibooks', 36000);
INSERT INTO tblBookPrice 
VALUES('Hacking Guide', 'Apress', 14000);
INSERT INTO tblBookPrice 
VALUES('How to play the iPhone', 'Apple Press', 7000);
INSERT INTO tblBookPrice 
VALUES('Computer Programming', 'IT Press', 7000);


SELECT max(price) FROM tblBookPrice;

SELECT max(price) AS MAX_PRICE FROM tblBookPrice;

SELECT max(price) FROM tblBookPrice
WHERE publisher = 'Wikibooks';

SELECT min(price) FROM tblBookPrice;

SELECT  max(price) AS MAX_PRICE,
        min(price) AS MIN_PRICE
FROM tblBookPrice;

SELECT  min(title) AS MIN_TITLE, 
        max(title) AS MAX_TITLE 
FROM tblBookPrice;

SELECT avg(price) FROM tblBookPrice;

SELECT avg(price) FROM tblBookPrice
WHERE publisher = 'Wikibooks';

SELECT total(price), sum(price) FROM tblBookPrice;

SELECT count(*) FROM tblBookPrice;

SELECT count(publisher) FROM tblBookPrice;

SELECT group_concat(publisher, '|')
FROM tblBookPrice;

SELECT group_concat(publisher) AS CONCAT
FROM tblBookPrice;

SELECT count(DISTINCT publisher) AS COUNT,
group_concat(DISTINCT publisher) AS CONCAT
FROM tblBookPrice;


