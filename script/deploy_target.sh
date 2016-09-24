#!/bin/bash

. $(cd $(dirname $0);pwd)/env.sh

REPOS_URL=$1
SUBMISSION_DIR=$2

# run clone
echo "START: clone"
git clone --depth 1 ${REPOS_URL} ${WORK_DIR}/${SUBMISSION_DIR}

# run docker
echo "START: docker"
docker-compose -f ${WORK_DIR}/${SUBMISSION_DIR}/docker-compose.yml up -d

sleep 3s