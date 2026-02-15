# Estágio de build
FROM maven:3.8.4-openjdk-17-slim AS build
WORKDIR /app
# CORREÇÃO: copia o pom.xml da subpasta correta
COPY gerenciador-biblioteca/pom.xml .
RUN mvn dependency:go-offline
# CORREÇÃO: copia o src da subpasta correta
COPY gerenciador-biblioteca/src ./src
RUN mvn clean package -DskipTests

# Estágio de execução (use a imagem alternativa para evitar o erro)
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
