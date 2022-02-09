FROM maven:3.6.3-jdk-8 AS maven
WORKDIR /app

COPY pom.xml ./
RUN mvn dependency:go-offline
RUN mvn spring-javaformat:help

COPY . ./
RUN mvn spring-javaformat:apply
RUN mvn package

FROM openjdk:8-jre-alpine
EXPOSE 8080

COPY --from=maven /app/target/spring-petclinic-*.jar ./spring-petclinic.jar
CMD ["/usr/bin/java", "-jar", "./spring-petclinic.jar"]
