#Build
FROM maven:3.8.3-openjdk-17 AS build
COPY src /openshift_test/src
COPY pom.xml /openshift_test
RUN mvn -f /openshift_test/pom.xml clean package

#Run
FROM amazoncorretto:17-alpine
COPY --from=build /openshift_test/target/openshift-*.jar /openshift.jar
ENTRYPOINT ["java", "-jar", "openshift.jar"]