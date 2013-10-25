.header on
.mode column
.nullvalue NULL

PRAGMA foreign_keys = 1;

CREATE TABLE tblPerson(  -- 테이블 생성
name TEXT,
age INTEGER,
mobile TEXT);

CREATE INDEX idxPersonAge ON tblPerson(age);  -- 인덱스 생성
CREATE VIEW vNameList AS  -- 뷰 생성
SELECT name, mobile FROM tblPerson;

ALTER TABLE tblPerson RENAME TO tblFriendList;  -- 테이블 이름을 tblFriendList로 변경

.schema tblFriendList  -- 해당 스키마 확인

.schema vNameList  -- 뷰의 이름은 변경되지 않음


ALTER TABLE tblFriendList ADD nColumn INTEGER;  -- nColumn 컬럼 추가
.schema tblFriendList  -- 추가된 nColumn 컬럼 확인

ALTER TABLE tblFriendList
ADD field_1 INTEGER DEFAULT 10;  -- 기본 값을 설정한 경우
ALTER TABLE tblFriendList
ADD field_2 INTEGER DEFAULT CURRENT_TIME;  -- 시간 기본 값을 설정한 경우

ALTER TABLE tblFriendList 
ADD field_3 INTEGER NOT NULL;  -- NOT NULL만 사용한 경우

ALTER TABLE tblFriendList      -- NOT NULL과 기본 값을 사용한 경우
ADD field_4 INTEGER NOT NULL DEFAULT 10;

