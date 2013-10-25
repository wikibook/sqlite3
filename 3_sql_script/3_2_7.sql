.header on
.mode column
.nullvalue NULL

PRAGMA foreign_keys = 1;

CREATE TABLE tblContact(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,  -- 해당 컬럼이 NULL인 경우, 에러 발생
    tel TEXT,
    mobile TEXT,
    gender TEXT,
    age INTEGER
);

INSERT INTO tblContact(name, tel)  -- name 컬럼에 NULL을 입력
VALUES(NULL, '02-1234-5678');

INSERT INTO tblContact(name, tel)
VALUES('Derick', '02-1234-5678');
UPDATE tblContact SET name = NULL;  -- name 컬럼을 NULL로 수정

----------------------------------------------------------------------

DROP TABLE tblContact;  -- 기존 테이블을 삭제
CREATE TABLE tblContact(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    tel TEXT,
    mobile TEXT DEFAULT '생략',  -- 기본값으로 ‘생략’을 지정
    gender TEXT,
    age INTEGER
);

INSERT INTO tblContact(name, tel)
VALUES('Derick', '02-1234-5678');

SELECT * FROM tblContact;

INSERT INTO tblContact(name, tel, mobile)
VALUES('Amy', '02-1234-5678', NULL);  -- mobile 컬럼에 명시적으로 NULL을 입력
SELECT * FROM tblContact;

CREATE TABLE tblDataLog(
    id INTEGER,
    date NOT NULL DEFAULT CURRENT_DATE,  -- 현재 날짜가 입력
    time NOT NULL DEFAULT CURRENT_TIME,  -- 현재 시간이 입력
    timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP -- 현재 날짜와 시간이 입력
);

INSERT INTO tblDataLog(id) VALUES(1);
INSERT INTO tblDataLog(id) VALUES(2);   -- 6분 정도 시간 후
SELECT * FROM tblDataLog;

------------------------------------------------------------------------

DROP TABLE tblContact;
CREATE TABLE tblContact(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,  -- UNIQUE 제약 사항 설정
    tel TEXT,
    mobile TEXT DEFAULT '생략',
    gender TEXT,
    age INTEGER
);

INSERT INTO tblContact(name, tel)
VALUES('Derick', '02-1234-5678');

INSERT INTO tblContact(name, tel)  -- name 컬럼의 값이 동일한 레코드
VALUES('Derick', '031-9876-5432');

------------------------------------------------------------------------

DROP TABLE tblContact;
CREATE TABLE tblContact(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    tel TEXT,
    mobile TEXT DEFAULT '생략',
    gender TEXT CHECK(gender IN ('M', 'F')),  -- 'M','F'만 가능
    age INTEGER,
    UNIQUE(name, mobile)
);

INSERT INTO tblContact(name, tel, gender)
VALUES('Derick', '02-1234-5678', 'M');     -- 조건을 만족하는 경우

INSERT INTO tblContact(name, tel, gender)
VALUES('Amy', '02-1234-5678', '여성');     -- 조건을 어긋나는 경우

INSERT INTO tblContact(name, tel, gender)
VALUES('Amy', '02-1234-5678', 'Female');

UPDATE tblContact SET gender = 'Man'  -- 조건을 어긋나게 수정하는 경우
WHERE name = 'Derick';


