#!/bin/bash

# Install base
apt-get update -y && \
apt-get install -y \
    curl \
    vim \
    wget \
    unzip \
    git 

# Install docker
apt-get install -y apt-transport-https ca-certificates && \
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" >> /etc/apt/sources.list.d/docker.list && \
apt-get update -y && \
apt-get install -y docker-engine && \
curl -L https://github.com/docker/compose/releases/download/1.8.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && \
chmod +x /usr/local/bin/docker-compose && \
usermod -aG docker ubuntu

# Gatling
apt-get install -y openjdk-8-jdk && \
wget https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/2.2.2/gatling-charts-highcharts-bundle-2.2.2-bundle.zip && \
unzip gatling-charts-highcharts-bundle-2.2.2-bundle.zip && \
mv gatling-charts-highcharts-bundle-2.2.2 /opt/gatling && \
rm gatling-charts-highcharts-bundle-2.2.2-bundle.zip

# Deploy script
wget https://codeload.github.com/koduki/sabacon-docker/zip/master
unzip master
mv sabacon-docker-master/script /script
chmod a+x /script/*
rm master && rm -rf sabacon-docker-master/