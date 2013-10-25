.header on
.mode column
.nullvalue NULL

CREATE TABLE tblNumber(value REAL);
INSERT INTO tblNumber VALUES(200.528);
INSERT INTO tblNumber VALUES(350.24);
INSERT INTO tblNumber VALUES(-45);
INSERT INTO tblNumber VALUES(-30.349);
INSERT INTO tblNumber VALUES(NULL);

SELECT max(value), min(value) FROM tblNumber;

SELECT max(title), min(title) FROM tblString;

SELECT value,       	-- 원본값
        abs(value),  	-- 절대값
        round(value), 	-- 첫째 자리에서 반올림
        round(value, 2)  	-- 둘째 자리에서 반올림
FROM tblNumber;

SELECT random(), randomblob(4);

SELECT lower(hex(randomblob(4)));

