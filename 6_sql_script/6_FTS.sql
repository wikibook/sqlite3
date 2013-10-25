.header on
.mode column
.nullvalue NULL

CREATE VIRTUAL TABLE tblEmail
USING fts3(subject, contents);  -- 두 컬럼 모두 전문 검색 가능

CREATE VIRTUAL TABLE tblName USING fts3;  -- 'content'라는 컬럼을 갖음


CREATE INDEX idxTitle ON tblEmail(title);
ALTER TABLE tblEmail ADD COLUMN(to TEXT);

INSERT INTO tblEmail(subject, contents)
VALUES('Design Pattern', 'I know how to work ...');
UPDATE tblEmail SET contents = 'I do not know how to work ...'
WHERE subject = 'Design Pattern';
SELECT subject, contents FROM tblEmail;


UPDATE tblEmail SET subject = 'subject is changed' WHERE rowid = 1;
DELETE FROM tblEmail WHERE rowid = 1;
INSERT INTO tblEmail(docid, subject, contents)  -- 명시적으로 rowid 지정
VALUES(10, 'Cover Work in Magazine',
        'I would like to express my sincere thanks.');
SELECT rowid, subject, contents FROM tblEmail;


-- FTS 인덱스 최적화
INSERT INTO tblEmail(subject, contents)   
VALUES('Design Pattern', 'I do not know how to work ...');
INSERT INTO tblEmail(subject, contents)
VALUES('Hard working', 'Long time ago, worker');
SELECT optimize(tblEmail) FROM tblEmail;  -- FTS 인덱스 최적화


SELECT rowid, subject, contents FROM tblEmail
WHERE contents MATCH 'work';  -- FTS 인덱스를 활용하는 경우

SELECT rowid, subject, contents FROM tblEmail
WHERE contents LIKE '%work%';   -- LIKE로 검색하는 경우

SELECT rowid, subject, contents FROM tblEmail
WHERE contents MATCH 'work*';

SELECT rowid, subject, contents FROM tblEmail
WHERE subject MATCH 'work*'; 

SELECT rowid, subject, contents FROM tblEmail
WHERE tblEmail MATCH 'work*';  -- 테이블의 모든 컬럼을 검색

SELECT rowid, subject, contents FROM tblEmail
WHERE contents MATCH 'work* how';

SELECT rowid, subject, contents FROM tblEmail
WHERE contents MATCH 'how OR ago';

SELECT rowid, subject, contents FROM tblEmail
WHERE tblEmail MATCH 'subject:work* ';  -- 명시적으로 검색할 컬럼 지정

SELECT rowid, subject, contents FROM tblEmail
WHERE tblEmail MATCH 'subject:work* contents:ago';

SELECT rowid, subject, contents FROM tblEmail
WHERE subject = 'Hard working';  -- 문자열 검색, FTS 인덱스 사용하지 않음

SELECT rowid, subject, contents FROM
tblEmail WHERE rowid = 10;  -- rowid로 검색

SELECT rowid, subject, contents FROM
tblEmail WHERE rowid BETWEEN 11 AND 12;   -- rowid로 검색

