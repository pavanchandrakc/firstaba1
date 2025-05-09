# Use OpenJDK 17 image for building
FROM openjdk:17-jdk-slim AS build

# Set the working directory inside the container
WORKDIR /app

# Copy your project files into the container
COPY . .

# Run Maven build
RUN mvn clean package

# Use OpenJDK 11 for the runtime environment
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /app/target/devopsaba-0.0.1-SNAPSHOT.jar /app/devopsaba.jar
ENTRYPOINT ["java", "-jar", "/app/devopsaba.jar"]
