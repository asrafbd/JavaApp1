FROM tomcat:9.0
COPY target/*.jar /usr/local/tomcat/webapps/
EXPOSE 8080
