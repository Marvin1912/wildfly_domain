FROM quay.io/wildfly/wildfly:28.0.1.Final-jdk17

COPY certs/server.keystore /opt/jboss/wildfly/domain/configuration
COPY certs/server.crt /opt/jboss/wildfly/domain/configuration

COPY hosts/host.xml /opt/jboss/wildfly/domain/configuration/host.xml
COPY modules/postgresql /opt/jboss/wildfly/modules/org/postgresql/main

COPY modules/sun/jdk/module.xml /opt/jboss/wildfly/modules/system/layers/base/sun/jdk/main

COPY startup.sh /opt/jboss/startup.sh

USER root

RUN yum update -y && yum install -y vim less

RUN chmod +x /opt/jboss/startup.sh

RUN /opt/java/openjdk/bin/keytool -import -file /opt/jboss/wildfly/domain/configuration/server.crt -alias wildfly_domain -cacerts -storepass changeit -noprompt

RUN mkdir -p /home/app/export /home/app/google
RUN chown -R jboss /home/app

USER jboss

ENV HTTPS_PORT 8445
ENV JBOSS_HOST_NAME host-2
ENV SERVER_GROUP web-server-group

RUN /opt/jboss/wildfly/bin/add-user.sh -ds -m -u admin -p admin --silent
RUN /opt/jboss/wildfly/bin/add-user.sh -ds -a -g guest -u jms-import -p password --silent

CMD ["/opt/jboss/startup.sh"]
