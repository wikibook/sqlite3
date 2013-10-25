.header on
.mode column
.nullvalue NULL

BEGIN TRANSACTION;
CREATE TABLE tblBookInfo  -- ���̺��� ���� ��쿡�� ����
(
    title TEXT,
    publisher TEXT,
    author TEXT,
    price INTEGER
);
INSERT INTO "tblBookInfo" VALUES('SQLite 3','WIKIBOOKS','Derick, DSP',30000);
INSERT INTO "tblBookInfo" VALUES('������ Ȱ���ϴ� ���̽� 3','WIKIBOOKS','��ȣö,
 �����, �ֵ���',26000);
INSERT INTO "tblBookInfo" VALUES('C++ Standard Library','Addison Wesley','Nicola
i Josuttis',30000);
INSERT INTO "tblBookInfo" VALUES('Advanced Programming','Addison Wesley','Steven
s Rago',48000);
INSERT INTO "tblBookInfo" VALUES('Steve Jobs'' Presentation','Apple Press','Stev
e Jobs',13000);
INSERT INTO "tblBookInfo" VALUES('Computer Programming','Apress','Derick',27000)
;
INSERT INTO "tblBookInfo" VALUES('iPhone programming','WIKIBOOKS','Amy, Derick,
�ֵ���',25000);
INSERT INTO "tblBookInfo" VALUES('JSP guide','Apress','No Author',9000);
INSERT INTO "tblBookInfo" VALUES('Software Conflict 2.0','WIKIBOOKS','No Author'
,22000);
COMMIT;

DELETE FROM tblBookInfo 
WHERE title = 'SQLite 3';

DELETE FROM tblBookInfo 
WHERE publisher IN ('Apress', 'Apple Press');

