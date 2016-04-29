#!/bin/bash
set -e
export DOCKER_IMAGE=jeredding/pine-golang
export IMAGE_TAG=1.6-dev

realpath () {
  [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

BASENAME="$(dirname "$(realpath "$0")")";

######
# These options should be standard for any build that plans to be automated
#  because the build will
#   * always clean up intermediary images
if [[ "x${JENKINS_URL}" == "x" ]]; then
    BUILD_ARGS="--force-rm"
else
    BUILD_ARGS="--rm"
fi

docker build ${BUILD_ARGS} -t ${DOCKER_IMAGE}:${IMAGE_TAG} $BASENAME

if [[ $? -eq 0 ]]; then
    echo "${DOCKER_IMAGE}:${IMAGE_TAG}: SUCCESS"
else
    echo "${DOCKER_IMAGE}:${IMAGE_TAG}: FAILURE";
    false;
fi