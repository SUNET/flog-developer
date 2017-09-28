#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE USER flog;
    CREATE DATABASE flog;
    GRANT ALL PRIVILEGES ON DATABASE flog TO flog;
    ALTER USER "flog" WITH PASSWORD 'docker';
    ALTER USER "flog" CREATEDB;
EOSQL
