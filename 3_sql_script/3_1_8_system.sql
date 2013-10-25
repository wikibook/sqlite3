.header on
.mode column
.nullvalue NULL

CREATE TABLE tblNumber(value REAL);
INSERT INTO tblNumber VALUES(200.528);
INSERT INTO tblNumber VALUES(350.24);
INSERT INTO tblNumber VALUES(-45);
INSERT INTO tblNumber VALUES(-30.349);
INSERT INTO tblNumber VALUES(NULL);

INSERT INTO tblNumber VALUES(10);

SELECT changes(), total_changes();

DELETE FROM tblNumber;
SELECT changes(), total_changes();

SELECT last_insert_rowid();  -- 마지막에 입력된 ROWID

SELECT sqlite_version(), sqlite_source_id();


