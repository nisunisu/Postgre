-- Synopsis
  -- BEGIN;
  -- BEGIN ISOLATION LEVEL {SERIALIZABLE | REPEATABLE READ | READ COMMITED | READ UNCOMMITED };
  -- BEGIN {READ WRITE | READ ONLY};


-- Get default setting
SHOW default_transaction_isolation;


-- Basics
BEGIN;
  CREATE TABLE fruit (
    id   int,
    name text
  );
  INSERT INTO fruit VALUES (1, 'banana');
COMMIT;
SELECT * FROM fruit;


-- In case of EMERGENCY
ROLLBACK;
ABORT;


-- SAVEPOINT
BEGIN;
  SAVEPOINT sp1;
  ---- Execute some INVALID command ----
  ROLLBACK to sp1; -- rollback to sp1
  
  ---- Execute some VALID   command ----
COMMIT;


-- Item Lock
BEGIN;
  -- Use "FOR UPDATE" to lock items
  SELECT * FROM meibo WHERE id = 1 FOR UPDATE;
COMMIT;


-- Table Lock
BEGIN;
  LOCK TABLE meibo IN ACCESS EXCLUSIVE MODE;
COMMIT;