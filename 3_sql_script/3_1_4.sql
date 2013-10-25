.header on
.mode column
.nullvalue NULL

CREATE TABLE IF NOT EXISTS tblBookInfo  -- 테이블이 없는 경우에만 생성
(
    title TEXT,
    publisher TEXT,
    author TEXT,
    price INTEGER
);

INSERT INTO tblBookInfo(title, publisher, author, price) 
VALUES('SQLite3', '위키북스', '신호철, 우상정', 30000);

INSERT INTO tblBookInfo(title, price)
VALUES('Refactoring Database', 25000);


