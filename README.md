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

_The certificate is purely for testing and does not contain any sensitive information._

#### Creation
- keytool -genkeypair -alias wildfly_domain -keyalg RSA -keysize 2048 -validity 365 -keystore server.keystore -dname "cn=Server Administrator,o=mgeitner,c=DE" -keypass secret -storepass secret -ext SAN=dns:host-1,dns:host-2,dns:host-3
- keytool -export -alias wildfly_domain -file server.crt -keystore server.keystore -storepass secret

#### JVM Deletion / Import
- sudo bin/keytool -delete -alias wildfly_domain -keystore lib/security/cacerts
- sudo bin/keytool -import -file ~/workspace/wildfly_domain/certs/server.crt -alias wildfly_domain -keystore lib/security/cacerts

#### Check the validity of the certificate
- openssl x509 -inform der -in server.crt -out server.pem
- openssl x509 -in server.pem -text -noout
- Certificate -> Data -> Validity

### Local Docker Registry
A local Docker registry runs on the server so that the images can be quickly distributed within the network. In order for the builds and pushes to work towards the insecure registry (no TLS), the following must be added to the respective system.
<pre>
/etc/docker/daemon.json

{
    "insecure-registries" : ["&lt;host&gt;:&lt;port&gt;"]
}
</pre>

## Misc
If following exception occurs, a possible solution can be found at following link:
https://stackoverflow.com/questions/56580375/tls-ssl-with-wildfly-16-0-0-final-and-ejb-client-fails-with-org-xnio-http-upgrad

<pre>
Caused by: org.xnio.http.UpgradeFailedException: Invalid response code 200
	at org.xnio.http.HttpUpgrade$HttpUpgradeState$UpgradeResultListener.handleEvent(HttpUpgrade.java:471) ~[xnio-api-3.8.9.Final.jar:3.8.9.Final]
	at org.xnio.http.HttpUpgrade$HttpUpgradeState$UpgradeResultListener.handleEvent(HttpUpgrade.java:400) ~[xnio-api-3.8.9.Final.jar:3.8.9.Final]
	at org.xnio.ChannelListeners.invokeChannelListener(ChannelListeners.java:92) ~[xnio-api-3.8.9.Final.jar:3.8.9.Final]
	at org.xnio.conduits.ReadReadyHandler$ChannelListenerHandler.readReady(ReadReadyHandler.java:66) ~[xnio-api-3.8.9.Final.jar:3.8.9.Final]
	at org.xnio.nio.NioSocketConduit.handleReady(NioSocketConduit.java:89) ~[xnio-nio-3.8.9.Final.jar:3.8.9.Final]
	at org.xnio.nio.WorkerThread.run(WorkerThread.java:591) ~[xnio-nio-3.8.9.Final.jar:3.8.9.Final]
	at ...asynchronous invocation...(Unknown Source) ~[na:na]
	at org.jboss.remoting3.EndpointImpl.connect(EndpointImpl.java:600) ~[jboss-remoting-5.0.27.Final.jar:5.0.27.Final]
	at org.jboss.remoting3.EndpointImpl.connect(EndpointImpl.java:565) ~[jboss-remoting-5.0.27.Final.jar:5.0.27.Final]
	at org.jboss.remoting3.ConnectionInfo$None.getConnection(ConnectionInfo.java:82) ~[jboss-remoting-5.0.27.Final.jar:5.0.27.Final]
	at org.jboss.remoting3.ConnectionInfo.getConnection(ConnectionInfo.java:55) ~[jboss-remoting-5.0.27.Final.jar:5.0.27.Final]
	at org.jboss.remoting3.EndpointImpl.doGetConnection(EndpointImpl.java:499) ~[jboss-remoting-5.0.27.Final.jar:5.0.27.Final]
	at org.jboss.remoting3.EndpointImpl.getConnectedIdentity(EndpointImpl.java:445) ~[jboss-remoting-5.0.27.Final.jar:5.0.27.Final]
	at org.jboss.remoting3.UncloseableEndpoint.getConnectedIdentity(UncloseableEndpoint.java:52) ~[jboss-remoting-5.0.27.Final.jar:5.0.27.Final]
	at org.wildfly.naming.client.remote.RemoteNamingProvider.getFuturePeerIdentityPrivileged(RemoteNamingProvider.java:151) ~[wildfly-naming-client-2.0.0.Final.jar:2.0.0.Final]
	at org.wildfly.naming.client.remote.RemoteNamingProvider.lambda$getFuturePeerIdentity$0(RemoteNamingProvider.java:138) ~[wildfly-naming-client-2.0.0.Final.jar:2.0.0.Final]
	at java.base/java.security.AccessController.doPrivileged(AccessController.java:318) ~[na:na]
	at org.wildfly.naming.client.remote.RemoteNamingProvider.getFuturePeerIdentity(RemoteNamingProvider.java:138) ~[wildfly-naming-client-2.0.0.Final.jar:2.0.0.Final]
	at org.wildfly.naming.client.remote.RemoteNamingProvider.getPeerIdentity(RemoteNamingProvider.java:126) ~[wildfly-naming-client-2.0.0.Final.jar:2.0.0.Final]
	at org.wildfly.naming.client.remote.RemoteNamingProvider.getPeerIdentityForNaming(RemoteNamingProvider.java:106) ~[wildfly-naming-client-2.0.0.Final.jar:2.0.0.Final]
	... 76 common frames omitted
</pre>
