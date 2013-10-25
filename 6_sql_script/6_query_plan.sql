.header on
.mode column
.nullvalue NULL

CREATE TABLE tblFriendInfo(
    id INTEGER PRIMARY KEY AUTOINCREMENT,   -- 기본키
    name TEXT,
    age INTEGER);
INSERT INTO tblFriendInfo(name, age)  -- 4개의 레코드 입력
VALUES('Tom', 20);
INSERT INTO tblFriendInfo(name, age)
VALUES('Mary', 45);
INSERT INTO tblFriendInfo(name, age)
VALUES('Derick', 31);
INSERT INTO tblFriendInfo(name, age)
VALUES('Amy', 27);

EXPLAIN QUERY PLAN
SELECT * FROM tblFriendInfo WHERE id = 3;  -- 기본키 인덱스를 이용

EXPLAIN QUERY PLAN
SELECT * FROM tblFriendInfo
WHERE name = 'Tom';     -- 인덱스를 이용하지 않음

EXPLAIN QUERY PLAN
SELECT * FROM tblFriendInfo ORDER BY name;   -- 인덱스를 이용하지 않음


CREATE INDEX idx_name 
ON tblFriendInfo(name DESC);  -- name 필드에 인덱스 생성

EXPLAIN QUERY PLAN
SELECT * FROM tblFriendInfo WHERE name = 'Tom';  -- idx_name 인덱스를 이용

EXPLAIN QUERY PLAN
SELECT * FROM tblFriendInfo ORDER BY name;  -- idx_name 인덱스를 이용


EXPLAIN QUERY PLAN
SELECT * FROM tblFriendInfo
WHERE id BETWEEN 2 AND 3;  -- 인덱스를 이용


EXPLAIN QUERY PLAN
SELECT * FROM tblFriendInfo
WHERE id > 2;  -- 인덱스를 이용


EXPLAIN QUERY PLAN
SELECT * FROM tblFriendInfo
WHERE id BETWEEN 2 AND 3;  -- 인덱스를 이용

EXPLAIN QUERY PLAN
SELECT * FROM tblFriendInfo
WHERE id > 2;  -- 인덱스를 이용

EXPLAIN QUERY PLAN
SELECT * FROM tblFriendInfo
WHERE age BETWEEN 25 AND 40;  -- 인덱스를 이용하지 않음

EXPLAIN QUERY PLAN
SELECT * FROM tblFriendInfo
WHERE name = 'Amy' OR name = 'Derick';  -- 인덱스 이용

EXPLAIN QUERY PLAN
SELECT * FROM tblFriendInfo
WHERE name IN ('Amy', 'Derick');  -- 인덱스 이용










CREATE TABLE tblFriendInfo2(
    id INTEGER PRIMARY KEY AUTOINCREMENT,   -- 기본키
    name TEXT,
    age INTEGER);
CREATE INDEX idx_name2
ON tblFriendInfo2(name DESC);  -- tblFriendInfo2 테이블의 name에 인덱스 생성
INSERT INTO tblFriendInfo2(name, age)  -- 2개의 레코드 입력
VALUES('David', 45);
INSERT INTO tblFriendInfo2(name, age)
VALUES('Jini', 16);

-- UNION인 경우도 인덱스를 활용함
EXPLAIN QUERY PLAN
SELECT * FROM tblFriendInfo
UNION
SELECT * FROM tblFriendInfo2 
ORDER BY name;

EXPLAIN QUERY PLAN
SELECT * FROM tblFriendInfo
UNION
SELECT * FROM tblFriendInfo;

DROP INDEX idx_name2;  -- tblFriendInfo2 테이블의 인덱스 삭제
EXPLAIN QUERY PLAN  
SELECT * FROM tblFriendInfo
UNION
SELECT * FROM tblFriendInfo2 
ORDER BY name;  -- tblFriendInfo 테이블의 인덱스만 이용
