# Initialize DB
# /usr/pgsql-11/bin/postgresql-11-setup initdb # こちらでもよいが、今回は参照した本に記載されているinitdbを使うことにする
initdb -E UTF8 --no-locale
grep "listen_addressed" ${PGDATA}/postgresql.conf # get initial setting 1
grep "port"             ${PGDATA}/postgresql.conf # get initial setting 2
grep "log_destination"  ${PGDATA}/postgresql.conf # get initial setting 3
cat ${PGDATA}/pg_hba.conf


# Start / Stop postgres
pg_ctl start
pg_ctl status
pg_ctl stop


# Create new user
# usernaeme ... "testuser"
createuser --interactive testuser # -> "n" * 3


# Get all user
psql -c "SELECT usename FROM pg_user;"


# Create new db
# db name ... "testdb"
createdb -O testuser testdb


# Get all available DB names
psql -l


# Login to DB
psql -d testdb # Connect to testdb
psql           # Connect to the db of which name is same as current user
psql -d template1 -U postgres
psql -d testdb -U testuser


# Logout
\q # or "Ctrl-d"


# Backslash Commands
# \q  ... psqlを終了
# \l  ... DB一覧を表示
# \dn ... スキーマ一覧を表示
# \d  ... TBL、インデックス、シーケンス、ビューの一覧を表示
# \dt ... TBL、インデックス、シーケンス、ビューの一覧を表示di インデックス一覧を表示
# \ds ... シーケンスの一覧を表示
# \dv ... ビューの一覧を表示
# \dS ... システムTBLの一覧を表示
# \du ... DBのユーザー一覧を表示
# \df ... 関数の一覧を表示
# \h  ... SQLヘルプ
# \r  ... 入力途中のクエリをリセット
# \timing ... SQL実行時間計測表示のON/OFF


# Schema
psql -c "\dn" # get all schemas
psql -c "SELECT current_schema();" # current schema
psql -c "SHOW search_path;" # 優先されるスキーマの順序


# Create / Drop schema
psql -c "CREATE SCHEMA test_schema;"
psql -c "DROP SCHEMA test_schema CASCADE;"


# Create / Drop TBL
psql -f psql/create_table.sql # create
psql -f psql/drop_table.sql   # drop


# For more, See psql folder