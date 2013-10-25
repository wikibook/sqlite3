.header on
.mode column
.nullvalue NULL

PRAGMA foreign_keys = 1;

CREATE TABLE tblPerson(  -- ���̺� ����
name TEXT,
age INTEGER,
mobile TEXT);

CREATE INDEX idxPersonAge ON tblPerson(age);  -- �ε��� ����
CREATE VIEW vNameList AS  -- �� ����
SELECT name, mobile FROM tblPerson;

ALTER TABLE tblPerson RENAME TO tblFriendList;  -- ���̺� �̸��� tblFriendList�� ����

.schema tblFriendList  -- �ش� ��Ű�� Ȯ��

.schema vNameList  -- ���� �̸��� ������� ����


ALTER TABLE tblFriendList ADD nColumn INTEGER;  -- nColumn �÷� �߰�
.schema tblFriendList  -- �߰��� nColumn �÷� Ȯ��

ALTER TABLE tblFriendList
ADD field_1 INTEGER DEFAULT 10;  -- �⺻ ���� ������ ���
ALTER TABLE tblFriendList
ADD field_2 INTEGER DEFAULT CURRENT_TIME;  -- �ð� �⺻ ���� ������ ���

ALTER TABLE tblFriendList 
ADD field_3 INTEGER NOT NULL;  -- NOT NULL�� ����� ���

ALTER TABLE tblFriendList      -- NOT NULL�� �⺻ ���� ����� ���
ADD field_4 INTEGER NOT NULL DEFAULT 10;

