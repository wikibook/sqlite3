.header on
.mode column
.nullvalue NULL
.width 28 15 22 8

CREATE TABLE IF NOT EXISTS tblBookInfo  -- ���̺��� ���� ��쿡�� ����
(
    title TEXT,
    publisher TEXT,
    author TEXT,
    price INTEGER
);

INSERT INTO tblBookInfo 
VALUES('SQLite 3', 'Wikibooks', 'Derick, DSP', 30000);
INSERT INTO tblBookInfo 
VALUES('������ Ȱ���ϴ� ���̽� 3', 'Wikibooks', '��ȣö, �����, �ֵ���', 26000);
INSERT INTO tblBookInfo 
VALUES('C++ Standard Library', 'Addison Wesley', 'Nicolai Josuttis', 30000);
INSERT INTO tblBookInfo 
VALUES('Advanced Programming', 'Addison Wesley', 'Stevens Rago', 48000);
INSERT INTO tblBookInfo 
VALUES("Steve Jobs' Presentation", 'Apple Press', 'Steve Jobs', 13000);
INSERT INTO tblBookInfo 
VALUES("Computer Programming", 'Apress', 'Derick', 25000);
INSERT INTO tblBookInfo 
VALUES("iPhone programming", 'Wikibooks', 'Amy, Derick, �ֵ���', 25000);
INSERT INTO tblBookInfo 
VALUES("JSP guide", 'Apress', NULL, 7000);
INSERT INTO tblBookInfo 
VALUES("software conflict 2.0", 'Wikibooks', NULL, 22000);


UPDATE tblBookInfo SET title = 'Software Conflict 2.0'
WHERE title = 'software conflict 2.0';

UPDATE tblBookInfo SET title = 'Software Conflict 2.0', price = 25000
WHERE title = 'software conflict 2.0';

UPDATE tblBookInfo SET publisher = 'WIKIBOOKS'
WHERE publisher = 'Wikibooks';

UPDATE tblBookInfo SET author = 'No Author' 
WHERE author IS NULL;

UPDATE tblBookInfo SET price = price + 2000 -- �ش� ���ڵ��� ���� �̿��Ͽ� ���� ����
WHERE publisher = 'Apress';

