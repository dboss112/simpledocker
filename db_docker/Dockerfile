FROM mysql

# Add a database

ENV MYSQL_DATABASE account

COPY ./sql_script/ /docker-entrypoint-initdb.d/

EXPOSE 3306:3306
