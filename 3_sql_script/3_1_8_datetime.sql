.header on
.mode column
.nullvalue NULL

SELECT date('now');  -- 지역 시간(Local Time)으로 오늘의 날짜

SELECT date('now', 'utc');  -- UTC 기준으로 오늘의 날짜

SELECT date('now', '3 days');  -- 오늘의 날짜에서 3일 더한 일

SELECT date('now', '-3 days');  -- 오늘의 날짜에서 3일 뺀 일

SELECT date('now', 'start of month');  -- 이번 달의 첫 날짜

SELECT date('now', 'weekday 0'); -- 다가올 일요일 날짜

SELECT time('now', 'localtime');  -- 지역 시간으로 지금 시간

SELECT datetime('now', 'localtime'); -- 지역 시간으로 지금 날짜와 시간

SELECT datetime(1234567890, 'unixepoch');

-- unix timestamp을 읽어서 datetime 형태의 지역 시간으로 변환
SELECT datetime(1234567890, 'unixepoch', 'localtime');

SELECT strftime('%H:%M(%m-%d)', 'now', 'localtime'); -- 현재 시간을 원하는 형태로 변환

SELECT julianday('now');  -- real 타입의 율리우스일을 반환

CREATE TABLE tblFriend(
    name TEXT,
    birthday TEXT   -- 날짜를 저장할 컬럼
);

INSERT INTO tblFriend
VALUES('Derick', date('1980-06-10'));	-- 날짜를 지정하는 경우
INSERT INTO tblFriend
VALUES('Baby', date('now'));  	-- 현재 시간을 입력하는 경우

SELECT name, strftime('%m-%d(%Y)', birthday)
FROM tblFriend;  -- 출력 형식을 원하는 형태로 변경








