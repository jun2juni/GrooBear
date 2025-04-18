
# 아마존 jdk 사용
FROM amazoncorretto:21
ARG JAR_FILE=target/*.war
COPY ${JAR_FILE} sevenFS-0.0.1.war
ENTRYPOINT ["java","-jar","/sevenFS-0.0.1.war"]