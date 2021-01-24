FROM ubuntu:18.04

# Make sure the package repository is up to date.
RUN apt-get update && \
    apt-get -qy full-upgrade && \
    apt-get install -qy git rsync && \
# Install a basic SSH server
    apt-get install -qy openssh-server && \
    sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd && \
    mkdir -p /var/run/sshd && \
# Install JDK 8 (latest stable edition at 2019-04-01)
    apt-get install -qy openjdk-8-jdk && \
# Add user jenkins to the image
    adduser --quiet jenkins && \
# Set password for the jenkins user (you may want to alter this).
    echo "jenkins:jenkins" | chpasswd && \
    mkdir /home/jenkins/.m2

# Install Build Essentials
RUN apt-get update && \
    apt-get install -y \
    build-essential file apt-utils

# Install docker
RUN apt-get -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

RUN apt-get update
RUN apt-get -y install docker-ce
RUN curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

RUN usermod -a -G docker jenkins

# Clean apt
RUN apt-get autoremove -y

# Setup SSH
RUN mkdir /home/jenkins/.ssh && touch $_/authorized_keys
RUN chown -R jenkins:jenkins /home/jenkins/.m2/ && \
    chown -R jenkins:jenkins /home/jenkins/.ssh/
EXPOSE 22

# Setup jenkins user
USER jenkins
WORKDIR /home/jenkins

USER root

CMD ["/usr/sbin/sshd", "-D"]
