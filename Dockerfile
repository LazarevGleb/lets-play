FROM gradle:7.5.1-jdk17-alpine as builder
USER root
WORKDIR /builder
ADD . /builder
RUN gradle build --no-daemon

FROM openjdk:17-alpine
WORKDIR /app
COPY --from=builder /builder/build/libs/letsPlay-0.0.1-SNAPSHOT.jar letsPlay.jar
ARG DEPENDENCY=builder/build/dependency
ENTRYPOINT ["java", "-Xmx330m", "-Xss512k", "-Xdebug", "-Xrunjdwp:transport=dt_socket,address=*:5005,server=y,suspend=n", "-jar", "letsPlay.jar"]
