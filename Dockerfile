FROM maven:3.6-jdk-12-alpine

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY settings.xml /usr/share/maven/ref/
COPY karatesample/pom.xml /tmp/pom.xml

COPY karatesample /usr/src/app
COPY maven_runner.sh /usr/src/app

RUN mvn -B -f /tmp/pom.xml -s /usr/share/maven/ref/settings-docker.xml prepare-package -DskipTests

RUN ["chmod", "+x", "/usr/src/app/maven_runner.sh"]

CMD ["/usr/src/app/maven_runner.sh"]