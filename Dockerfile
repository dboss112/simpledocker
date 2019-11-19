FROM tomcat:8.5-alpine

ENV jdbc.driverClassName=com.mysql.jdbc.Driver jdbc.url=jdbc:mysql://172.31.9.59:3306/account jdbc.username=root jdbc.password=swarup

ADD /target/account-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/account.war

CMD ["catalina.sh" , "run"]

EXPOSE 8009
