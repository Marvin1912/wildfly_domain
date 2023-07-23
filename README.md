<style>
red { color: red }
</style>

# Home Application with a WildFly Domain
This GitHub repository provides a comprehensive example of configuring a WildFly Domain. 

It includes the necessary configuration files and scripts to set up a WildFly Domain environment, showcasing the distributed architecture and management capabilities of WildFly.

Features:

- Domain configuration: Includes domain.xml, host.xml, and other relevant configuration files.
- Host Controllers: Demonstrates the setup and configuration of multiple host controllers within the domain.
- Profiles: Illustrates the usage of "full-ha", to customize the behavior and capabilities of the host controllers.
- Clustering: Highlights the configuration of clustering and load balancing features in the WildFly Domain.
- High Availability: Shows how to enable high availability features and failover mechanisms in a WildFly Domain setup.
- Management and Monitoring: Provides examples of managing and monitoring the domain using WildFly management tools and interfaces.

Furthermore, this repository serves to lay the foundation for a home application. The basic infrastructure is represented via the following architecture description.

![Infrastructure](Infrastruktur.png?raw=true "Infrastructure")

### TLS Certificate
To be able to establish connections via TLS, a certificate was created. The certificate was distributed to the server
and stored in the local JVM in the cacerts keystore as a test. Below are the commands that were used to create/import
the certificate.

<red>_The certificate is purely for testing and does not contain any sensitive information._</red>

#### Creation
- keytool -genkeypair -alias wildfly_domain -keyalg RSA -keysize 2048 -validity 365 -keystore server.keystore -dname "cn=Server Administrator,o=mgeitner,c=DE" -keypass secret -storepass secret -ext SAN=dns:host-1,dns:host-2
- keytool -export -alias wildfly_domain -file server.crt -keystore server.keystore -storepass secret

#### JVM Import
- sudo bin/keytool -import -file ~/workspace/wildfly_domain/certs/server.crt -alias wildfly_domain -keystore lib/security/cacerts
