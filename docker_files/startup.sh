#!/bin/bash

sed -i "s/###REPLACE_SERVER_GROUP###/$SERVER_GROUP/" /opt/jboss/wildfly/domain/configuration/host.xml

/opt/jboss/wildfly/bin/domain.sh \
  -b 0.0.0.0 \
  -bmanagement 0.0.0.0 \
  -bprivate $(hostname -i) \
  -Djboss.https.port=$HTTPS_PORT \
  -Djboss.host.name=$JBOSS_HOST_NAME
