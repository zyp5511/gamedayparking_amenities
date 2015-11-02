CREATE DATABASE testdb;
CREATE USER test WITH PASSWORD 'test';
ALTER USER test WITH SUPERUSER CREATEDB;
GRANT ALL PRIVILEGES ON DATABASE testdb to test;
\connect testdb;
CREATE EXTENSION postgis;
CREATE EXTENSION postgis_topology;
