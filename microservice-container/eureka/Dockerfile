FROM openjdk:11-jre-slim
COPY build/libs/eureka-0.0.1-SNAPSHOT.jar app.jar
ENV PORT=8080
EXPOSE 8080/tcp
ENTRYPOINT ["sh", "-c", "java -jar app.jar"]