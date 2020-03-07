-- General
SELECT * FROM meibo;
SELECT name FROM meibo;
SELECT * FROM meibo WHERE birth >= '1970/1/3';
SELECT * FROM meibo ORDER BY birth;      -- 昇順
SELECT * FROM meibo ORDER BY birth ASC;  -- 昇順
SELECT * FROM meibo ORDER BY birth DESC; -- 降順
SELECT count(*) FROM meibo;
SELECT max(birth) FROM meibo;
SELECT min(birth) FROM meibo;
SELECT char_length(zip) FROM meibo; -- 文字数
SELECT pg_current_logfile(); -- 現在利用しているログファイル

-- AS
SELECT id AS 番号, name AS なまえ, zip AS POSTALCode, address AS 住所 FROM meibo;


-- LIMIT ... OFFSET ...
SELECT * FROM meibo ORDER BY birth LIMIT 2 OFFSET 0;
SELECT * FROM meibo ORDER BY birth LIMIT 2 OFFSET 2;


-- GROUP BY / HAVING
SELECT sex, count(*) FROM meibo GROUP BY sex;
SELECT sex, count(*) FROM meibo GROUP BY sex HAVING count(*) >= 3;


-- JOIN
CREATE TABLE email (
  -- meibo ... 名簿
  id    SERIAL,
  email TEXT
);
INSERT INTO email(email) VALUES ('hoge1@example.com');
INSERT INTO email(email) VALUES ('hoge2@example.com');
INSERT INTO email(email) VALUES ('hoge3@example.com');
INSERT INTO email(email) VALUES ('hoge4@example.com');
SELECT name, email FROM meibo JOIN email ON meibo.id = email.id;
SELECT name, email FROM meibo, email WHERE meibo.id = email.id;


-- Sub query
SELECT id, name, ( SELECT email FROM email WHERE meibo.id = email.id )
FROM meibo
ORDER BY id;

SELECT name FROM meibo WHERE birth = (SELECT max(birth) FROM meibo);