
FROM openjdk:11.0
WORKDIR /app
COPY ./target/Uber.jar .
EXPOSE 9091
CMD [ "java", "-jar", "Uber.jar" ] 

