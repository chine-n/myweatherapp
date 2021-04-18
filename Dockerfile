FROM tomcat:latest
COPY /target/weather-app-0.0.1-SNAPSHOT.jar /usr/local/tomcat/webapps/weather-app-0.0.1-SNAPSHOT.jar
