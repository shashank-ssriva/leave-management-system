FROM tomcat:9.0.24
#https://github.com/docker-library/tomcat

ADD ./target/leave-management-system-1.0.0-SNAPSHOT.war $CATALINA_HOME/webapps/leave-management-system.war

EXPOSE 8080
#CMD ["catalina.sh", "run"]