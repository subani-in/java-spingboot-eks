# Use official OpenJDK 17 image as base
FROM dvmarques/openjdk-17-jdk-alpine-with-timezone

# Set the working directory inside the container
WORKDIR /app

# Copy the built JAR file into the container
COPY target/user-service-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8082

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]