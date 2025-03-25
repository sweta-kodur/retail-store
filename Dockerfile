# Use Gradle image to build the project
FROM gradle:8.2.1-jdk17 AS build

# Set work directory
WORKDIR /home/gradle/project

# Copy everything and build
COPY . .
RUN gradle clean build --no-daemon

# Second stage - smaller runtime image
FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

# Copy jar from build stage
COPY --from=build /home/gradle/project/build/libs/retail-store-1.0.jar app.jar

# Expose port (change if your app runs on a different port)
EXPOSE 8089

# Run the jar
ENTRYPOINT ["java", "-jar", "app.jar"]

