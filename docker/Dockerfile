FROM centos:7
RUN yum install -y wget
RUN yum install -y tar
RUN yum install -y curl
COPY ./jdk1.8.0_161/ /opt/jdk1.8.0_161
RUN alternatives --install /usr/bin/java java /opt/jdk1.8.0_161/bin/java 2
RUN alternatives --install /usr/bin/jar jar /opt/jdk1.8.0_161/bin/jar 2
RUN alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_161/bin/javac 2
RUN alternatives --set jar /opt/jdk1.8.0_161/bin/jar
RUN alternatives --set javac /opt/jdk1.8.0_161/bin/javac
ENV JAVA_HOME /opt/jdk1.8.0_161/jre
EXPOSE 8080 9090 80
COPY ./hipchat.sh /opt/hipchat.sh
COPY ./startup.sh /opt/startup.sh
COPY ./toro-integrate-3.0-ALPHA/ /opt/toro-integrate-3.0-ALPHA
HEALTHCHECK  --interval=10s --retries=5 CMD bash ./opt/hipchat.sh
CMD bash ./opt/startup.sh

