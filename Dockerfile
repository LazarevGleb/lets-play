FROM gradle:7.5.1-jdk17-alpine as builder
USER root
WORKDIR /builder
ADD . /builder
RUN gradle build --no-daemon

FROM openjdk:17-alpine
WORKDIR /app
EXPOSE 8080
COPY --from=builder /builder/build/libs/letsPlay-0.0.1-SNAPSHOT.jar letsPlay.jar
ARG DEPENDENCY=builder/build/dependency
ENTRYPOINT ["java", "-jar", "letsPlay.jar"]
