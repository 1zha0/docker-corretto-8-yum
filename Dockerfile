FROM amazoncorretto:8

# This build runs `yum update` against official Amazon corretto,
# to mitigate any known vulnerabilities due to gaps caused by
# offical image release cycle.

RUN set -eux \
    && yum update -y \
    && yum clean all

ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-amazon-corretto
