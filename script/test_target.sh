#!/bin/bash

. $(cd $(dirname $0);pwd)/env.sh

SENARIO=$1
HOST=http://172.17.0.1/

echo "START: stress test" 

rm -rf ${WORK_DIR}/report
mkdir -p ${WORK_DIR}/report

docker run -v ${WORK_DIR}/report:/opt/gatling/results/ -e JAVA_OPTS="-DbaseUrl=${HOST}" koduki/sabacon-test /script/docker-entrypoint.sh ${SENARIO} 

echo "START: archive report" 

cd ${WORK_DIR}/report/* 
tar cfz ${WORK_DIR}/report.tar.gz * 

echo "END:"

echo $?
