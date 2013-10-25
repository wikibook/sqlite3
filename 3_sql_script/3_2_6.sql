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

INSERT INTO tblBookInfo 
VALUES(100000000000, 'SQLite 3', 30000, 1);
INSERT INTO tblBookInfo 
VALUES(200000000000, '빠르게 활용하는 파이썬 3', 26000, 1);
INSERT INTO tblBookInfo
VALUES(300000000000, 'C++ Standard Library', 30000, NULL);
INSERT INTO tblBookInfo 
VALUES(400000000000, "Steve Jobs' Presentation", 13000, 2);
INSERT INTO tblBookInfo 
VALUES(500000000000, 'Computer Programming', 25000, 3);
INSERT INTO tblBookInfo 
VALUES(600000000000, 'iPhone programming', 26000, 1);
INSERT INTO tblBookInfo 
VALUES(700000000000, 'Android programming', 36000, 1);
INSERT INTO tblBookInfo 
VALUES(800000000000, 'Hacking Guide', 14000, 3);
INSERT INTO tblBookInfo 
VALUES(900000000000, 'How to play the iPhone', 7000, 2);
INSERT INTO tblBookInfo 
VALUES(110000000000, 'Computer Programming', 7000, 4);


CREATE INDEX idxBookInfoTitle ON tblBookInfo(title ASC);

CREATE INDEX idxBookInfoTitle ON tblBookInfo(title DESC);

EXPLAIN QUERY PLAN
SELECT * FROM tblBookInfo ORDER BY title;

CREATE INDEX IF NOT EXISTS idxBookInfoTitle
ON tblBookInfo(title ASC);

CREATE UNIQUE INDEX idxBookInfoTitle_uk ON tblBookInfo(title);

CREATE INDEX idxBookInfoTitleISBN ON tblBookInfo(title ASC, isbn DESC);

DROP INDEX idxBookInfoTitle;
DROP INDEX idxBookInfoTitleISBN;


