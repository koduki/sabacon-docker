#FROM httpd:2.4
FROM ubuntu

# Install base
RUN apt-get update -y && \
apt-get install -y \
    curl \
    vim \
    wget \
    unzip \
    git && \
apt-get install -y \
    apache2 && \
apt-get install -y \
    openjdk-8-jdk

# Install docker
RUN apt-get install -y apt-transport-https ca-certificates && \
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" >> /etc/apt/sources.list.d/docker.list && \
apt-get update -y && \
apt-get install -y docker-engine && \
curl -L https://github.com/docker/compose/releases/download/1.8.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && \
chmod +x /usr/local/bin/docker-compose

# Install ssh
RUN apt-get update -y && \
apt-get install -y \
    openssh-server
ADD authorized_keys /root/.ssh/authorized_keys
RUN sed -ri 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config && \
mkdir -p /var/run/sshd && chmod 755 /var/run/sshd && \
chmod -R g-rwx,o-rwx /root/.ssh

# Install Gatling
RUN wget https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/2.2.2/gatling-charts-highcharts-bundle-2.2.2-bundle.zip && \
unzip gatling-charts-highcharts-bundle-2.2.2-bundle.zip && \
mv gatling-charts-highcharts-bundle-2.2.2 /opt/gatling && \
rm gatling-charts-highcharts-bundle-2.2.2-bundle.zip

# Configuration apache
ADD run-apache2.sh /run-apache2.sh 
RUN chmod a+x /run-apache2.sh 

# Configuration app
ADD script /script
RUN chmod a+x /script/*

EXPOSE 80 22
#CMD /run-apache2.sh
CMD /usr/sbin/sshd -D
