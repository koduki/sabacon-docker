#!/bin/bash

. $(cd $(dirname $0);pwd)/env.sh

SUBMISSION_DIR=$1

echo "STOP: docker"
docker-compose -f ${WORK_DIR}/${SUBMISSION_DIR}/docker-compose.yml stop
