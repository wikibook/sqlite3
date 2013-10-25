.header on
.mode column
.nullvalue NULL

CREATE TABLE tblType( value );
INSERT INTO tblType VALUES(200.528);        	-- REAL
INSERT INTO tblType VALUES(-45);                	-- INTEGER
INSERT INTO tblType VALUES('String Value');     	-- TEXT
INSERT INTO tblType VALUES(NULL);               	-- NULL
INSERT INTO tblType VALUES(x'0101');		-- BLOB
SELECT value, typeof(value) FROM tblType;

SELECT  ifnull(10, 20), ifnull(NULL, 20),
        ifnull(10, NULL), ifnull(NULL, NULL);


SELECT  coalesce(10, NULL, 30),
        coalesce(NULL, 20, 30),
        coalesce(NULL, NULL, 30),
        coalesce(NULL, NULL, NULL);

SELECT 'Steve Jobs'' Presentation';  -- 원본 문자열을 변경하는 경우

SELECT quote("Steve Jobs' Presentation");  -- quote() 함수를 사용하는 경우















