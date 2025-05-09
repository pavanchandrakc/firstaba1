# Use a lightweight OpenJDK image
# Use JDK 17 for building
FROM openjdk:17-jdk-slim as build

WORKDIR /app
COPY . .
RUN mvn clean package

# Use JRE 17 to run (optional, or reuse same image)
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/myproject-1.0-SNAPSHOT-jar-with-dependencies.jar app.jar
CMD ["java", "-jar", "app.jar"]

