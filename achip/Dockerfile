FROM amd64/openjdk:18-ea-19-jdk
ARG JAR_FILE=target/achip-0.0.1-SNAPSHOT.jar
WORKDIR /opt/app
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","app.jar"]

#openjdk:18-jdk-alpine

#FROM eclipse-temurin:17-jdk-jammy as builder
#WORKDIR /opt/app
#COPY .mvn/ .mvn
#COPY mvnw pom.xml ./
#RUN ./mvnw package
#COPY ./src ./src
#RUN ./mvnw clean install
#
#FROM eclipse-temurin:17-jre-jammy
#WORKDIR /opt/app
#EXPOSE 8080
#COPY --from=builder /opt/app/target/*.jar /opt/app/*.jar
#ENTRYPOINT ["java", "-jar", "/opt/app/*.jar" ]