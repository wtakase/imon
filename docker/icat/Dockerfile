FROM irods/icat:4.0.3
MAINTAINER wtakase <wataru.takase@kek.jp>

ENV FLUME_VERSION 1.6.0

RUN mkdir /opt/java && \
    cd /opt/java && \
    wget -P /opt/java --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.oracle.com/otn-pub/java/jdk/8u20-b26/jre-8u20-linux-x64.tar.gz && \
    tar zxf jre-8u20-linux-x64.tar.gz --strip 1 && \
    rm -f jre-8u20-linux-x64.tar.gz

ENV JAVA_HOME=/opt/java PATH=/opt/java/bin:$PATH

RUN mkdir /opt/flume && \
    cd /opt/flume && \
    wget -P /opt/flume http://archive.apache.org/dist/flume/${FLUME_VERSION}/apache-flume-${FLUME_VERSION}-bin.tar.gz && \
    tar zxf apache-flume-${FLUME_VERSION}-bin.tar.gz --strip 1 && \
    rm -f apache-flume-${FLUME_VERSION}-bin.tar.gz

COPY flume.conf  /opt/flume/conf/
COPY run.sh /
RUN sed -i -e "/^tail.*/i /run.sh &" /opt/irods/bootstrap.sh

RUN apt-get update && apt-get install -y cron
COPY rotate_rodslog.sh /
RUN echo "10/* * * * * root /rotate_rodslog.sh" >> /etc/crontab
