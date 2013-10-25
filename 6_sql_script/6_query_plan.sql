.header on
.mode column
.nullvalue NULL

CREATE TABLE tblFriendInfo(
    id INTEGER PRIMARY KEY AUTOINCREMENT,   -- �⺻Ű
    name TEXT,
    age INTEGER);
INSERT INTO tblFriendInfo(name, age)  -- 4���� ���ڵ� �Է�
VALUES('Tom', 20);
INSERT INTO tblFriendInfo(name, age)
VALUES('Mary', 45);
INSERT INTO tblFriendInfo(name, age)
VALUES('Derick', 31);
INSERT INTO tblFriendInfo(name, age)
VALUES('Amy', 27);

EXPLAIN QUERY PLAN
SELECT * FROM tblFriendInfo WHERE id = 3;  -- �⺻Ű �ε����� �̿�

EXPLAIN QUERY PLAN
SELECT * FROM tblFriendInfo
WHERE name = 'Tom';     -- �ε����� �̿����� ����

EXPLAIN QUERY PLAN
SELECT * FROM tblFriendInfo ORDER BY name;   -- �ε����� �̿����� ����


CREATE INDEX idx_name 
ON tblFriendInfo(name DESC);  -- name �ʵ忡 �ε��� ����

EXPLAIN QUERY PLAN
SELECT * FROM tblFriendInfo WHERE name = 'Tom';  -- idx_name �ε����� �̿�

EXPLAIN QUERY PLAN
SELECT * FROM tblFriendInfo ORDER BY name;  -- idx_name �ε����� �̿�


EXPLAIN QUERY PLAN
SELECT * FROM tblFriendInfo
WHERE id BETWEEN 2 AND 3;  -- �ε����� �̿�


EXPLAIN QUERY PLAN
SELECT * FROM tblFriendInfo
WHERE id > 2;  -- �ε����� �̿�


EXPLAIN QUERY PLAN
SELECT * FROM tblFriendInfo
WHERE id BETWEEN 2 AND 3;  -- �ε����� �̿�

EXPLAIN QUERY PLAN
SELECT * FROM tblFriendInfo
WHERE id > 2;  -- �ε����� �̿�

EXPLAIN QUERY PLAN
SELECT * FROM tblFriendInfo
WHERE age BETWEEN 25 AND 40;  -- �ε����� �̿����� ����

EXPLAIN QUERY PLAN
SELECT * FROM tblFriendInfo
WHERE name = 'Amy' OR name = 'Derick';  -- �ε��� �̿�

EXPLAIN QUERY PLAN
SELECT * FROM tblFriendInfo
WHERE name IN ('Amy', 'Derick');  -- �ε��� �̿�










CREATE TABLE tblFriendInfo2(
    id INTEGER PRIMARY KEY AUTOINCREMENT,   -- �⺻Ű
    name TEXT,
    age INTEGER);
CREATE INDEX idx_name2
ON tblFriendInfo2(name DESC);  -- tblFriendInfo2 ���̺��� name�� �ε��� ����
INSERT INTO tblFriendInfo2(name, age)  -- 2���� ���ڵ� �Է�
VALUES('David', 45);
INSERT INTO tblFriendInfo2(name, age)
VALUES('Jini', 16);

-- UNION�� ��쵵 �ε����� Ȱ����
EXPLAIN QUERY PLAN
SELECT * FROM tblFriendInfo
UNION
SELECT * FROM tblFriendInfo2 
ORDER BY name;

EXPLAIN QUERY PLAN
SELECT * FROM tblFriendInfo
UNION
SELECT * FROM tblFriendInfo;

DROP INDEX idx_name2;  -- tblFriendInfo2 ���̺��� �ε��� ����
EXPLAIN QUERY PLAN  
SELECT * FROM tblFriendInfo
UNION
SELECT * FROM tblFriendInfo2 
ORDER BY name;  -- tblFriendInfo ���̺��� �ε����� �̿�
