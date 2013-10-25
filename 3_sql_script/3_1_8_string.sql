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

SELECT title, 		-- 원본 문자열
    ltrim(title, 'Si'),  	-- 문자열의 왼쪽에서 ‘S’와 ‘i’를 삭제
    rtrim(title, '3E')  	-- 문자열의 오른쪽에서 ‘3’과 ‘E’를 삭제
FROM tblString;

SELECT title, substr(title, 3), substr(title, 3, 5)
FROM tblString;

SELECT title, substr(title, -5), substr(title, -5, 5)
FROM tblString;

SELECT title, replace(title, 'ITE', 'ite')
FROM tblString;




