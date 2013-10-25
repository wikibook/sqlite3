.header on
.mode column
.nullvalue NULL
PRAGMA foreign_keys = 1;

CREATE TABLE tblBookInfo(
	isbn INTEGER PRIMARY KEY,
	title TEXT,
	price INTEGER,
	publisher_id INTEGER,
	CONSTRAINT ctPublisherID_fk FOREIGN KEY(publisher_id)
    REFERENCES tblPublisherInfo(publisher_id)
);

CREATE TABLE tblPublisherInfo(
	publisher_id INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT
);

INSERT INTO tblPublisherInfo VALUES(1, 'Wikibooks');
INSERT INTO tblPublisherInfo VALUES(2, 'Apple Press');
INSERT INTO tblPublisherInfo VALUES(3, 'Apress');
INSERT INTO tblPublisherInfo VALUES(4, 'IT Press');

INSERT INTO tblBookInfo	-- ���� ���Ἲ�� �����ϴ� ���
VALUES(100000000000, 'SQLite 3', 30000, 1);  

INSERT INTO tblBookInfo	-- ���� ���Ἲ�� �����ϴ� ���, ���� �߻�
VALUES(200000000000, '������ Ȱ���ϴ� ���̽� 3', 26000, 54321);  

UPDATE tblBookInfo SET publisher_id = 54321
WHERE isbn = 100000000000;

INSERT INTO tblBookInfo
VALUES(300000000000, 'C++ Standard Library', 30000, NULL);




