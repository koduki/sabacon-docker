#!/bin/bash

. $(cd $(dirname $0);pwd)/env.sh

SENARIO=$1
SUBMISSION_DIR=$2
REPOS_URL="https://github.com/koduki/sabacon-test.git"
RESULT_FILE=${WORK_DIR}/${SUBMISSION_DIR}/result.txt

echo "START: clone test senario" &>> $RESULT_FILE
git clone --depth 1 ${REPOS_URL} ${WORK_DIR}/sabacon-test &>> $RESULT_FILE

echo "START: stress test" &>> $RESULT_FILE
rm -rf ${WORK_DIR}/report &>> $RESULT_FILE
/opt/gatling/bin/gatling.sh -sf ${WORK_DIR}/sabacon-test/simulations -s ${SENARIO} -rf ${WORK_DIR}/report &>> $RESULT_FILE

echo "START: archive report" &>> $RESULT_FILE
cd ${WORK_DIR}/report/* &>> $RESULT_FILE
tar cfz ${WORK_DIR}/report.tar.gz * &>> $RESULT_FILE

echo "END:" &>> $RESULT_FILE

echo $?