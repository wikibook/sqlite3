.header on
.mode column
.nullvalue NULL

CREATE TABLE tblString(title TEXT);
INSERT INTO tblString VALUES('SQLite3 ');
INSERT INTO tblString VALUES(' iPhone Programming');
INSERT INTO tblString VALUES('iPhone PROGR      ');
INSERT INTO tblString VALUES('sqlITE3');
INSERT INTO tblString VALUES(' SQLITE3   ');
INSERT INTO tblString VALUES(NULL);

SELECT title, lower(title), upper(title)
FROM tblString;

SELECT title, length(title) FROM tblString;

SELECT length(10), length(-435), length(0.456);

SELECT ltrim(title), rtrim(title), trim(title)
FROM tblString;

SELECT length(title), length(ltrim(title)),
    length(rtrim(title)), length(trim(title))
FROM tblString;

SELECT title, 		-- ���� ���ڿ�
    ltrim(title, 'Si'),  	-- ���ڿ��� ���ʿ��� ��S���� ��i���� ����
    rtrim(title, '3E')  	-- ���ڿ��� �����ʿ��� ��3���� ��E���� ����
FROM tblString;

SELECT title, substr(title, 3), substr(title, 3, 5)
FROM tblString;

SELECT title, substr(title, -5), substr(title, -5, 5)
FROM tblString;

SELECT title, replace(title, 'ITE', 'ite')
FROM tblString;




