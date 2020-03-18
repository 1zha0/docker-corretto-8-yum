# amazoncorretto %AMAZON_CORRETTO_VERSION% with daily `yum update`

FROM amazoncorretto:%AMAZON_CORRETTO_VERSION%

# This build runs `yum update` against official Amazon corretto,
# to mitigate any known vulnerabilities due to gaps caused by
# offical image release cycle.

RUN set -eux \
    && yum update -y \
    && yum clean all

ENV JAVA_HOME=/usr/lib/jvm/java-%AMAZON_CORRETTO_VERSION%-amazon-corretto

# EOF