FROM larsks/esp-open-sdk AS builder
WORKDIR /app

RUN git clone --recursive --branch v1.13 https://github.com/micropython/micropython.git
RUN git -C micropython clone --recursive --branch v1.9.3 https://github.com/micropython/micropython-lib.git

RUN make -C micropython/mpy-cross -j `nproc --all`

# ------------------------------------
FROM larsks/esp-open-sdk
RUN yum install -y patch git rsync openssh-server java-1.8.0-openjdk

COPY --from=builder /app/micropython/mpy-cross/mpy-cross /usr/bin

ENV PATH="/usr/sbin:${PATH}"
RUN adduser jenkins && \
    echo "jenkins:jenkins" | chpasswd && \
    mkdir /home/jenkins/.m2

# Setup SSH
RUN mkdir /home/jenkins/.ssh && touch $_/authorized_keys
RUN chown -R jenkins:jenkins /home/jenkins/.m2/ && \
    chown -R jenkins:jenkins /home/jenkins/.ssh/
EXPOSE 22
RUN ssh-keygen -A

USER jenkins
WORKDIR /home/jenkins

USER root

CMD ["/usr/sbin/sshd", "-D"]
