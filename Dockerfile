# Use Maven with OpenJDK 17 for building
FROM maven:3.9.9-openjdk-17-slim AS build

# Set working directory
WORKDIR /app

# Copy all source code into the container
COPY . .

# Build the application
RUN mvn clean package

# Use a lightweight Java runtime for running the app
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy the built jar file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
