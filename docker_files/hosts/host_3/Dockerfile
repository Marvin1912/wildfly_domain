FROM quay.io/wildfly/wildfly:28.0.1.Final-jdk17

COPY certs/server.keystore /opt/jboss/wildfly/domain/configuration

COPY hosts/host.xml /opt/jboss/wildfly/domain/configuration/host.xml
COPY modules/postgresql /opt/jboss/wildfly/modules/org/postgresql/main

COPY startup.sh /opt/jboss/startup.sh

USER root

RUN yum update -y && yum install -y vim less

RUN chmod +x /opt/jboss/startup.sh

RUN ln -s /opt/jboss/wildfly/domain/servers/server/log logs

USER jboss

ENV HTTPS_PORT 8446
ENV JBOSS_HOST_NAME host-3
ENV SERVER_GROUP jms-server-group

RUN /opt/jboss/wildfly/bin/add-user.sh -ds -m -u admin -p admin --silent
RUN /opt/jboss/wildfly/bin/add-user.sh -ds -a -g guest -u jms-import -p password --silent

CMD ["/opt/jboss/startup.sh"]
