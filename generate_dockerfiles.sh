#!/bin/bash

set -o pipefail -e

# TEMPLATES
# Dockerfile.corretto-yum.tpl
# test-image.sh.tpl
# test-image.yaml.tpl

AMAZON_CORRETTO_VERSIONS=(8 11)

gen_dockerfile() {
  DOCKERFILE_TEMPLATE="Dockerfile.corretto-yum.tpl"
  TEST_IMAGE_SH_TEMPLATE="test-image.sh.tpl"
  TEST_IMAGE_YAML_TEMPLATE="test-image.yaml.tpl"

  DOCKERFILE_TARGET="${AMAZON_CORRETTO_VERSION}/Dockerfile"
  TEST_IMAGE_SH_TARGET="${AMAZON_CORRETTO_VERSION}/test-image.sh"
  TEST_IMAGE_YAML_TARGET="${AMAZON_CORRETTO_VERSION}/test-image.yaml"

  DOCKERFILE_TARGET_DIR="$(dirname ${DOCKERFILE_TARGET})"
  echo -en "Generating Dockerfile for ${AMAZON_CORRETTO_VERSION}.. "
  if [ ! -r ${DOCKERFILE_TEMPLATE} ]; then
    echo "failed"
    echo "Missing Dockerfile template ${DOCKERFILE_TEMPLATE}"
    exit 1
  fi

  # create target dockerfile dir
  if [ ! -e ${DOCKERFILE_TARGET_DIR} ]; then
    mkdir -p ${DOCKERFILE_TARGET_DIR}
  fi

  sed "s/%AMAZON_CORRETTO_VERSION%/${AMAZON_CORRETTO_VERSION}/g;" \
    ${DOCKERFILE_TEMPLATE} > ${DOCKERFILE_TARGET} && \
  sed "s/%AMAZON_CORRETTO_VERSION%/${AMAZON_CORRETTO_VERSION}/g;" \
    ${TEST_IMAGE_SH_TEMPLATE} > ${TEST_IMAGE_SH_TARGET} && \
  sed "s/%AMAZON_CORRETTO_VERSION%/${AMAZON_CORRETTO_VERSION}/g;" \
    ${TEST_IMAGE_YAML_TEMPLATE} > ${TEST_IMAGE_YAML_TARGET} && \
  echo "done" || \
  echo "failed"
}

for version in ${AMAZON_CORRETTO_VERSIONS[@]}; do
  AMAZON_CORRETTO_VERSION=$(echo $version)
  SCALA_VERSION=$(echo $version | cut -d- -f2)
  HADOOP_VERSION=$(echo $version | cut -d- -f3)
  OS_VERSION=$(echo $version | cut -d- -f4)

  gen_dockerfile

done

echo -n "Generating symlinks for current versions.. "
latest=$(echo "${AMAZON_CORRETTO_VERSIONS[@]}" | tr ' ' '\n\' | uniq | sort -n | head -n1)
[ -e current ] && rm current || true
ln -s ${latest} current
echo "done"
