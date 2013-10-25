.header on
.mode column
.nullvalue NULL

CREATE TABLE tblBookInfo
(
    title TEXT,  -- ����
    publisher TEXT,  -- ���ǻ�
    author TEXT,  -- ����
    price INTEGER  -- ����
);

CREATE TABLE IF NOT EXISTS tblBookInfo  -- ���̺��� ���� ��쿡�� ����
(
    title TEXT,
    publisher TEXT,
    author TEXT,
    price INTEGER
);

DROP TABLE tblBookInfo;
DROP TABLE IF EXISTS tblBookInfo;






