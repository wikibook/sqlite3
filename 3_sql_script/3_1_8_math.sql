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

SELECT value,       	-- ������
        abs(value),  	-- ���밪
        round(value), 	-- ù° �ڸ����� �ݿø�
        round(value, 2)  	-- ��° �ڸ����� �ݿø�
FROM tblNumber;

SELECT random(), randomblob(4);

SELECT lower(hex(randomblob(4)));

