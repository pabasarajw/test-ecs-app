FROM gradle:jdk17-alpine AS build
COPY --chown=1001:root . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build --no-daemon 

FROM eclipse-temurin:17-jre-jammy

EXPOSE 8084

RUN mkdir /app

COPY --chown=1001 --from=build /home/gradle/src/build/libs/test-ecs-app-0.0.1-SNAPSHOT.jar /app/test-ecs-app.jar

ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom","-jar","/app/test-ecs-app.jar"]