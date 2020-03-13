# Corretto with Daily `yum update`

This is a clone of Dockerfile for [Corretto 8 & 11](https://aws.amazon.com/corretto/) with `yum update` applied.

## Tags

- latest-yum
- 8-yum
- 11-yum

## Testing

Tests are defined in `test-image.yaml` using [GoogleContainerTools/container-structure-test](
https://github.com/GoogleContainerTools/container-structure-test). To run tests, execute `./test-image.sh`. 

## Usage

A `JAVA_HOME` environment variable is configured to assist in tasks that require a known location of additional JRE/JDK files. For example installing a custom certificate into the default cacerts truststore.

```dockerfile
keytool -import -trustcacerts -alias myAlias -file myCert.cer -keystore $JAVA_HOME/jre/lib/security/cacerts -storepass changeit -noprompt
```
