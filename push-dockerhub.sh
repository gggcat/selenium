#!/bin/bash

#
# タグ名生成
#
BUILD_LOG=$(docker-compose build selenium)
PYTHON_VER=$(docker run zzzcat/dispshell python --version | awk '{ print $2 }')
CHROMIUM_VER=$(docker-compose run selenium chromium --version | awk '{ print $2 }')
PYTHON_TAG=$(echo ${PYTHON_VER} | perl -pe 's/([0-9]+)\.([0-9]+)\.([0-9]+).*/$1.$2/g')
CHROMIUM_TAG=$(echo ${CHROMIUM_VER} | perl -pe 's/([0-9]+)\.([0-9]+)\.([0-9]+).*/$1.$2/g')
TAG_NAME="py${PYTHON_TAG}-ch${CHROMIUM_TAG}"

#
# DockerHub に Push
#
CONTAINER_NAME="zzzcat/selenium:${TAG_NAME}"
docker login -u ${DOCKERHUB_USER} -p ${DOCKERHUB_PASS}
docker build -t ${CONTAINER_NAME} -f selenium-dispshell.Dockerfile .
docker push ${CONTAINER_NAME}
