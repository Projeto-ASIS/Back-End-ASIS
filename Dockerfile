FROM maven:3.9.8-amazoncorretto-17 AS build
WORKDIR /app
COPY . .

RUN mvn clean package -Dmaven.resources.encoding=UTF-8

FROM openjdk:17-jdk
WORKDIR /app

EXPOSE 8080

COPY --from=build /app/target/api-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]