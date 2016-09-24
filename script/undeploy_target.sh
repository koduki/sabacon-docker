#!/bin/bash

. $(cd $(dirname $0);pwd)/env.sh

SUBMISSION_DIR=$1
REPOS_URL="https://github.com/koduki/sabacon-test.git"

git clone --depth 1 ${REPOS_URL} ${WORK_DIR}/${SUBMISSION_DIR}

echo "STOP: docker"
docker-compose -f ${WORK_DIR}/${SUBMISSION_DIR}/docker-compose.yml stop

echo "CLEANUP"
rm -rf /var/tmp/*