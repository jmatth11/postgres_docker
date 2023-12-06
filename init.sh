#!/bin/bash

# setup ability to escape with ctrl c
trap ctrl_c INT

# define function to execute when ctrl c is entered
function ctrl_c() {
    echo "** Trapped CTRL-C"
    exit 0
}

# start up postgres server
sudo -u postgres /usr/pgsql-9.6/bin/pg_ctl start -D /usr/local/pgsql/data/ -l /usr/local/pgsql/logfile
echo "starting service"

# wait for posgresql server to start up
sleep 5

if [ "$1" = "init" ]; then
    # create test_db admin user
    psql -U postgres postgres < /code/create_admin.sql || exit 1
    # create test_db db
    psql -U postgres postgres < /code/create_db.sql || exit 1
fi

# keep docker from closing
while true; do
    sleep 1
done
