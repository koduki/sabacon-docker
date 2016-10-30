#!/bin/bash

. $(cd $(dirname $0);pwd)/env.sh

SENARIO=$1

echo "START: stress test" 

rm -rf ${WORK_DIR}/report
mkdir -p ${WORK_DIR}/report

docker run -it -v ${WORK_DIR}/report:/opt/gatling/results/ -e JAVA_OPTS="-DbaseUrl=http://192.168.99.100" koduki/sabacon-test /script/docker-entrypoint.sh ${SENARIO} 

echo "START: archive report" 

cd ${WORK_DIR}/report/* 
tar cfz ${WORK_DIR}/report.tar.gz * 

echo "END:"

echo $?