# Use a lightweight OpenJDK image
FROM openjdk:17-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the fat JAR into the image (adjust the JAR name if needed)
COPY target/myproject-1.0-SNAPSHOT-jar-with-dependencies.jar app.jar

# Command to run the JAR
ENTRYPOINT ["java", "-jar", "app.jar"]
