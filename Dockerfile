FROM marcelobarretto/tomcat-mysql

MAINTAINER Marcelo Barretto <marcelo.barretto@gmail.com>

# Install Required packages
RUN apt-get -qq update && apt-get -qq -y install maven2 git

# Add application properties file
ADD config/application.properties /application.properties

# Clone repository, configure/compile project and deploy to tomcat
RUN mkdir -p /git/icc &&\
    git clone https://github.com/marcosmko/MC437_GRUPO6.git /git/icc &&\
    mv -f /application.properties /git/icc/ICC/src/main/resources/application.properties &&\
    mvn package -DskipTests -f /git/icc/ICC/pom.xml &&\
    mv -f /git/icc/ICC/target/ICC.war ${CATALINA_HOME}/webapps/ICC.war &&\
    rm -rf /git

# Clean up to minimize image size
RUN apt-get -y purge maven2 git && apt-get -y autoremove

ADD start.sh /start.sh

RUN chmod 755 /start.sh

# Launch Tomcat
CMD ["/bin/bash", "/start.sh"]
