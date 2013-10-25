.header on
.mode column
.nullvalue NULL

CREATE VIRTUAL TABLE tblEmail
USING fts3(subject, contents);  -- �� �÷� ��� ���� �˻� ����

CREATE VIRTUAL TABLE tblName USING fts3;  -- 'content'��� �÷��� ����


CREATE INDEX idxTitle ON tblEmail(title);
ALTER TABLE tblEmail ADD COLUMN(to TEXT);

INSERT INTO tblEmail(subject, contents)
VALUES('Design Pattern', 'I know how to work ...');
UPDATE tblEmail SET contents = 'I do not know how to work ...'
WHERE subject = 'Design Pattern';
SELECT subject, contents FROM tblEmail;


UPDATE tblEmail SET subject = 'subject is changed' WHERE rowid = 1;
DELETE FROM tblEmail WHERE rowid = 1;
INSERT INTO tblEmail(docid, subject, contents)  -- ��������� rowid ����
VALUES(10, 'Cover Work in Magazine',
        'I would like to express my sincere thanks.');
SELECT rowid, subject, contents FROM tblEmail;


-- FTS �ε��� ����ȭ
INSERT INTO tblEmail(subject, contents)   
VALUES('Design Pattern', 'I do not know how to work ...');
INSERT INTO tblEmail(subject, contents)
VALUES('Hard working', 'Long time ago, worker');
SELECT optimize(tblEmail) FROM tblEmail;  -- FTS �ε��� ����ȭ


SELECT rowid, subject, contents FROM tblEmail
WHERE contents MATCH 'work';  -- FTS �ε����� Ȱ���ϴ� ���

SELECT rowid, subject, contents FROM tblEmail
WHERE contents LIKE '%work%';   -- LIKE�� �˻��ϴ� ���

SELECT rowid, subject, contents FROM tblEmail
WHERE contents MATCH 'work*';

SELECT rowid, subject, contents FROM tblEmail
WHERE subject MATCH 'work*'; 

SELECT rowid, subject, contents FROM tblEmail
WHERE tblEmail MATCH 'work*';  -- ���̺��� ��� �÷��� �˻�

SELECT rowid, subject, contents FROM tblEmail
WHERE contents MATCH 'work* how';

SELECT rowid, subject, contents FROM tblEmail
WHERE contents MATCH 'how OR ago';

SELECT rowid, subject, contents FROM tblEmail
WHERE tblEmail MATCH 'subject:work* ';  -- ��������� �˻��� �÷� ����

SELECT rowid, subject, contents FROM tblEmail
WHERE tblEmail MATCH 'subject:work* contents:ago';

SELECT rowid, subject, contents FROM tblEmail
WHERE subject = 'Hard working';  -- ���ڿ� �˻�, FTS �ε��� ������� ����

SELECT rowid, subject, contents FROM
tblEmail WHERE rowid = 10;  -- rowid�� �˻�

SELECT rowid, subject, contents FROM
tblEmail WHERE rowid BETWEEN 11 AND 12;   -- rowid�� �˻�

