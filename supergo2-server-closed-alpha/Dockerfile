FROM maven:3.6.3-jdk-14 AS build

COPY src /usr/src/app/src
COPY pom.xml /usr/src/app

RUN mkdir -p /root/.m2 \
    && mkdir /root/.m2/repository

RUN mvn -f /usr/src/app/pom.xml clean package

FROM openjdk:14
COPY --from=build /usr/src/app/target/supergo2-server-0.0.1-SNAPSHOT.jar /usr/app/supergo2-server-0.0.1-SNAPSHOT.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/app/supergo2-server-0.0.1-SNAPSHOT.jar","--spring.config.location=/usr/app/config/supergo2-server.yml"]
