.header on
.mode column
.nullvalue NULL

CREATE TABLE IF NOT EXISTS tblBookInfo  -- ���̺��� ���� ��쿡�� ����
(
    title TEXT,
    publisher TEXT,
    author TEXT,
    price INTEGER
);

INSERT INTO tblBookInfo(title, publisher, author, price) 
VALUES('SQLite3', '��Ű�Ͻ�', '��ȣö, �����', 30000);

INSERT INTO tblBookInfo(title, price)
VALUES('Refactoring Database', 25000);


