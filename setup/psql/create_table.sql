CREATE TABLE meibo (
  -- meibo ... 名簿
  id      SERIAL,
  name    TEXT,
  zip     CHAR(8),
  address TEXT,
  birth   DATE,
  sex     BOOLEAN
);