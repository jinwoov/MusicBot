# Build stage
FROM maven:3.8.7-openjdk-18-slim AS build
COPY pom.xml /app/
COPY src /app/src
RUN mvn -f /app/pom.xml clean package

# # Run stage
FROM openjdk:18-jdk-alpine
COPY config.txt /app/
COPY --from=build /app/target/JMusicBot-Snapshot-All.jar /app/app.jar
RUN apk add --no-cache freetype fontconfig ttf-dejavu
ENTRYPOINT ["java","-Dconfig=/app/config.txt","-jar","/app/app.jar"]