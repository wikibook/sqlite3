.header on
.mode column
.nullvalue NULL

CREATE TABLE tblBookInfo
(
    title TEXT,  -- 제목
    publisher TEXT,  -- 출판사
    author TEXT,  -- 저자
    price INTEGER  -- 가격
);

CREATE TABLE IF NOT EXISTS tblBookInfo  -- 테이블이 없는 경우에만 생성
(
    title TEXT,
    publisher TEXT,
    author TEXT,
    price INTEGER
);

DROP TABLE tblBookInfo;
DROP TABLE IF EXISTS tblBookInfo;






