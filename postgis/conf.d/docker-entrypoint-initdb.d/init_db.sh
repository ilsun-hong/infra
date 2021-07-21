#!/bin/sh
set -e

POSTGIS_PATH="/usr/local/share/postgresql/contrib/postgis-2.5"

psql -q -c "UPDATE pg_database SET datistemplate=FALSE WHERE datname='template1';"
psql -q -c "DROP DATABASE template1;"
psql -q -c "CREATE DATABASE template1 WITH TEMPLATE=template0 ENCODING='UNICODE';"
psql -q -c "UPDATE pg_database SET datistemplate=TRUE WHERE datname='template1';"
psql -q -c "\c template1"
psql -q -c "VACUUM FREEZE;"
createdb -E UTF8 test
psql test -f /init-sql.d/init_yogiyo.sql
psql -q postgres -c "CREATE EXTENSION postgis"
psql -q yogyo -c "CREATE EXTENSION postgis"
psql -q -U postgres yogyo -f $POSTGIS_PATH/legacy_gist.sql
psql -q -d postgres -c "UPDATE pg_database SET datistemplate='true' WHERE datname='template_postgis';"
psql -q -d template_postgis -f $POSTGIS_PATH/postgis.sql
psql -q -d template_postgis -f $POSTGIS_PATH/spatial_ref_sys.sql
psql -q -d template_postgis -f /init-sql.d/init_postgis.sql
psql -q -d template_postgis -f $POSTGIS_PATH/legacy_gist.sql

roles_dump="/dump.d/roles.dump"
if [ -f $roles_dump ]; then
  psql -U postgres -f $roles_dump
else
  echo "dumpfile \"$roles_dump\" does not exist, skipping"
fi

yostaging_dump="/dump.d/yostaging_cleaned.dump"
if [ -f $yostaging_dump ]; then
    psql -U postgres yogyo < $yostaging_dump
else
  echo "dumpfile \"$yostaging_dump\" does not exist, skipping"
fi

bizcenter_dump="/dump.d/bizcenter.dump"
if [ -f $bizcenter_dump ]; then
    createdb owner -E UTF8
    psql -U postgres owner < $bizcenter_dump
else
  echo "dumpfile \"$bizcenter_dump\" does not exist, skipping"
fi
