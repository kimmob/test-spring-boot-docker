FROM gradle:8.0.1-jdk11-focal AS builder

WORKDIR /

ADD ./build.gradle build.gradle
ADD ./settings.gradle settings.gradle
ADD ./src src/

RUN gradle build

# Second stage: minimal runtime environment
FROM eclipse-temurin:17

WORKDIR /

# copy jar from the first stage
COPY --from=builder build/libs/demo2-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
