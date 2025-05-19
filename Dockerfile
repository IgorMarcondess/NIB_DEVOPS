# Etapa 1: build do projeto com Maven
FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /app

# Copia os arquivos do projeto dentro da pasta N.I.B
COPY N.I.B/pom.xml .
COPY N.I.B/src ./src

RUN mvn clean package -DskipTests

# Etapa 2: imagem de execução
FROM openjdk:17-jdk

WORKDIR /app

# Copia o JAR gerado da etapa anterior
COPY --from=build /app/target/N.I.B-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
