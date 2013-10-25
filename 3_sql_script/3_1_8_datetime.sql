.header on
.mode column
.nullvalue NULL

SELECT date('now');  -- ���� �ð�(Local Time)���� ������ ��¥

SELECT date('now', 'utc');  -- UTC �������� ������ ��¥

SELECT date('now', '3 days');  -- ������ ��¥���� 3�� ���� ��

SELECT date('now', '-3 days');  -- ������ ��¥���� 3�� �� ��

SELECT date('now', 'start of month');  -- �̹� ���� ù ��¥

SELECT date('now', 'weekday 0'); -- �ٰ��� �Ͽ��� ��¥

SELECT time('now', 'localtime');  -- ���� �ð����� ���� �ð�

SELECT datetime('now', 'localtime'); -- ���� �ð����� ���� ��¥�� �ð�

SELECT datetime(1234567890, 'unixepoch');

-- unix timestamp�� �о datetime ������ ���� �ð����� ��ȯ
SELECT datetime(1234567890, 'unixepoch', 'localtime');

SELECT strftime('%H:%M(%m-%d)', 'now', 'localtime'); -- ���� �ð��� ���ϴ� ���·� ��ȯ

SELECT julianday('now');  -- real Ÿ���� �����콺���� ��ȯ

CREATE TABLE tblFriend(
    name TEXT,
    birthday TEXT   -- ��¥�� ������ �÷�
);

INSERT INTO tblFriend
VALUES('Derick', date('1980-06-10'));	-- ��¥�� �����ϴ� ���
INSERT INTO tblFriend
VALUES('Baby', date('now'));  	-- ���� �ð��� �Է��ϴ� ���

SELECT name, strftime('%m-%d(%Y)', birthday)
FROM tblFriend;  -- ��� ������ ���ϴ� ���·� ����








