FROM centos:centos6

ENV DB_INIT false

RUN yum update -y
RUN yum install -y epel-release wget
#RUN yum install -y git golang

# pull postgres 9.6
RUN wget https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm

# install postgresql server and commands
RUN yum install -y pgdg-centos96-9.6-3.noarch.rpm
RUN yum update -y
RUN yum install -y postgresql96-server postgresql96-contrib sudo

# Add all files in current directory into container under /code folder
ADD . ./code

# make postgresql data directory and tell pgsql to use it
# https://www.postgresql.org/docs/9.2/static/creating-cluster.html
RUN mkdir /usr/local/pgsql/
RUN chown postgres /usr/local/pgsql
# log into postgres user profile
RUN sudo -u postgres /usr/pgsql-9.6/bin/initdb -D /usr/local/pgsql/data -E UTF8
# create logfile for postgresql
RUN sudo -u postgres touch /usr/local/pgsql/logfile

# open all connections to listen
RUN echo "hostnossl all all 0.0.0.0/0 trust" >> /usr/local/pgsql/data/pg_hba.conf
RUN echo "listen_addresses = '*'" >> /usr/local/pgsql/data/postgresql.conf

# run the init.sh file when running the container
ENTRYPOINT ["./code/init.sh"]
CMD [$DB_INIT]
# expose the port 5432 to be mapped outside the container
EXPOSE 5432
