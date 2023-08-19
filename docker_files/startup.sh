#!/bin/bash

/opt/jboss/wildfly/bin/domain.sh \
  -b 0.0.0.0 \
  -bmanagement 0.0.0.0 \
  -bprivate $(hostname -i) \
  -Djboss.https.port=$HTTPS_PORT \
  -Djboss.host.name=$JBOSS_HOST_NAME
