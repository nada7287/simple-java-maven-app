FROM artifactory.nada.com/docker/maven:3.8.6-amazoncorretto-11 as builder

########################
# Copy source code 
#######################
WORKDIR /app
COPY src  ./src
COPY pom.xml ./pom.xml

######################
# Maven targets
####################
RUN mvn clean install \
&& mvn test

FROM artifactory.nada.com/docker/maven:3.8.6-amazoncorretto-11 
WORKDIR /app
COPY --from=builder /app/target/*.jar my-app.jar

###################
# Run application 
################
CMD ["java","-jar","/app/my-app.jar"]



