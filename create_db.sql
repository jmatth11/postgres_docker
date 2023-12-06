-- create test_db database to generate tables and things for
DROP DATABASE IF EXISTS test_db;
CREATE DATABASE test_db
    OWNER = postgres
    ENCODING = UTF8
    CONNECTION LIMIT = 1000;
