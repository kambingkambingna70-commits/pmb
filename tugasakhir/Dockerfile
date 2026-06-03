# Multi-stage build untuk Spring Boot app
FROM maven:3.9-eclipse-temurin-17 AS builder

WORKDIR /app

# Copy pom.xml dan download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline -B || true

# Copy source code
COPY src ./src
COPY target ./target 2>/dev/null || true

# Build app
RUN mvn clean package -DskipTests -q || mvn package -DskipTests -q

# Runtime stage
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Copy JAR dari builder stage
COPY --from=builder /app/target/*.jar app.jar

# Expose port
EXPOSE 8080

# Run app
ENTRYPOINT ["java", "-Dfile.encoding=UTF-8", "-jar", "app.jar"]
