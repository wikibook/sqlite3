.header on
.mode column
.nullvalue NULL

PRAGMA foreign_keys = 1;

CREATE TABLE tblContact(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,  -- �ش� �÷��� NULL�� ���, ���� �߻�
    tel TEXT,
    mobile TEXT,
    gender TEXT,
    age INTEGER
);

INSERT INTO tblContact(name, tel)  -- name �÷��� NULL�� �Է�
VALUES(NULL, '02-1234-5678');

INSERT INTO tblContact(name, tel)
VALUES('Derick', '02-1234-5678');
UPDATE tblContact SET name = NULL;  -- name �÷��� NULL�� ����

----------------------------------------------------------------------

DROP TABLE tblContact;  -- ���� ���̺��� ����
CREATE TABLE tblContact(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    tel TEXT,
    mobile TEXT DEFAULT '����',  -- �⺻������ ���������� ����
    gender TEXT,
    age INTEGER
);

INSERT INTO tblContact(name, tel)
VALUES('Derick', '02-1234-5678');

SELECT * FROM tblContact;

INSERT INTO tblContact(name, tel, mobile)
VALUES('Amy', '02-1234-5678', NULL);  -- mobile �÷��� ��������� NULL�� �Է�
SELECT * FROM tblContact;

CREATE TABLE tblDataLog(
    id INTEGER,
    date NOT NULL DEFAULT CURRENT_DATE,  -- ���� ��¥�� �Է�
    time NOT NULL DEFAULT CURRENT_TIME,  -- ���� �ð��� �Է�
    timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP -- ���� ��¥�� �ð��� �Է�
);

INSERT INTO tblDataLog(id) VALUES(1);
INSERT INTO tblDataLog(id) VALUES(2);   -- 6�� ���� �ð� ��
SELECT * FROM tblDataLog;

------------------------------------------------------------------------

DROP TABLE tblContact;
CREATE TABLE tblContact(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,  -- UNIQUE ���� ���� ����
    tel TEXT,
    mobile TEXT DEFAULT '����',
    gender TEXT,
    age INTEGER
);

INSERT INTO tblContact(name, tel)
VALUES('Derick', '02-1234-5678');

INSERT INTO tblContact(name, tel)  -- name �÷��� ���� ������ ���ڵ�
VALUES('Derick', '031-9876-5432');

------------------------------------------------------------------------

DROP TABLE tblContact;
CREATE TABLE tblContact(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    tel TEXT,
    mobile TEXT DEFAULT '����',
    gender TEXT CHECK(gender IN ('M', 'F')),  -- 'M','F'�� ����
    age INTEGER,
    UNIQUE(name, mobile)
);

INSERT INTO tblContact(name, tel, gender)
VALUES('Derick', '02-1234-5678', 'M');     -- ������ �����ϴ� ���

INSERT INTO tblContact(name, tel, gender)
VALUES('Amy', '02-1234-5678', '����');     -- ������ ��߳��� ���

INSERT INTO tblContact(name, tel, gender)
VALUES('Amy', '02-1234-5678', 'Female');

UPDATE tblContact SET gender = 'Man'  -- ������ ��߳��� �����ϴ� ���
WHERE name = 'Derick';


