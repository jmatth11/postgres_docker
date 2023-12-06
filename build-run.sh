# create data volume to persist db data
docker volume create test-db-data
# build the docker file and give it the tag-name test-db
# if the build fails exit with code 1
docker build -t test-db . || exit 1
