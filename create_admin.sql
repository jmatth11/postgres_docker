-- Create special admin user just for test_db database
DROP ROLE IF EXISTS test_admin;
CREATE ROLE test_admin
    LOGIN
    ENCRYPTED PASSWORD 'password';
