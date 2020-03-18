# amazoncorretto 11 with daily `yum update`

FROM amazoncorretto:11

# This build runs `yum update` against official Amazon corretto,
# to mitigate any known vulnerabilities due to gaps caused by
# offical image release cycle.

RUN set -eux \
    && yum update -y \
    && yum clean all

ENV JAVA_HOME=/usr/lib/jvm/java-11-amazon-corretto

# EOF
