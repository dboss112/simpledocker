FROM mysql

# Add a database

ENV MYSQL_DATABASE account

COPY ./db_docker/sql_script.sql /docker-entrypoint-initdb.d/sql_script.sql

EXPOSE 3306:3306
