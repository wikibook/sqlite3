.header on
.mode column
.nullvalue NULL

BEGIN TRANSACTION;
CREATE TABLE tblBookInfo  -- 테이블이 없는 경우에만 생성
(
    title TEXT,
    publisher TEXT,
    author TEXT,
    price INTEGER
);
INSERT INTO "tblBookInfo" VALUES('SQLite 3','WIKIBOOKS','Derick, DSP',30000);
INSERT INTO "tblBookInfo" VALUES('빠르게 활용하는 파이썬 3','WIKIBOOKS','신호철,
 우상정, 최동진',26000);
INSERT INTO "tblBookInfo" VALUES('C++ Standard Library','Addison Wesley','Nicola
i Josuttis',30000);
INSERT INTO "tblBookInfo" VALUES('Advanced Programming','Addison Wesley','Steven
s Rago',48000);
INSERT INTO "tblBookInfo" VALUES('Steve Jobs'' Presentation','Apple Press','Stev
e Jobs',13000);
INSERT INTO "tblBookInfo" VALUES('Computer Programming','Apress','Derick',27000)
;
INSERT INTO "tblBookInfo" VALUES('iPhone programming','WIKIBOOKS','Amy, Derick,
최동진',25000);
INSERT INTO "tblBookInfo" VALUES('JSP guide','Apress','No Author',9000);
INSERT INTO "tblBookInfo" VALUES('Software Conflict 2.0','WIKIBOOKS','No Author'
,22000);
COMMIT;

DELETE FROM tblBookInfo 
WHERE title = 'SQLite 3';

DELETE FROM tblBookInfo 
WHERE publisher IN ('Apress', 'Apple Press');

