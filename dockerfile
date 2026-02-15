@"
# Estágio de build
FROM maven:3.8.4-openjdk-17-slim AS build
WORKDIR /app
COPY gerenciador-biblioteca/pom.xml .
RUN mvn dependency:go-offline
COPY gerenciador-biblioteca/src ./src
RUN mvn clean package -DskipTests

# Estágio de execução
FROM openjdk:17-slim
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
"@ | Out-File -FilePath Dockerfile -Encoding UTF8
