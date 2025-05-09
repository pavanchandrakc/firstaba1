# Use Maven with OpenJDK 17 for building
FROM maven:3.9-openjdk-17 AS build

# Set working directory
WORKDIR /app

# Copy pom.xml and other necessary files to the container
COPY pom.xml .

# Run Maven to fetch dependencies
RUN mvn dependency:go-offline

# Copy the rest of the project files
COPY . .

# Run Maven build
RUN mvn clean install

# Use a minimal image to run the application
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy the jar file from the build image
COPY --from=build /app/target/devopsaba-0.0.1-SNAPSHOT.jar /app/devopsaba.jar

# Expose the application port (if needed)
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "/app/devopsaba.jar"]
