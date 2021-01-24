FROM larsks/esp-open-sdk AS builder
WORKDIR /app

RUN git clone --recursive --branch v1.13 https://github.com/micropython/micropython.git
RUN git -C micropython clone --recursive --branch v1.9.3 https://github.com/micropython/micropython-lib.git

RUN make -C micropython/mpy-cross -j `nproc --all`

# ------------------------------------
FROM larsks/esp-open-sdk
RUN yum install -y patch git rsync openssh-server

COPY --from=builder /app/micropython/mpy-cross/mpy-cross /usr/bin

RUN adduser --quiet jenkins

RUN chown -R jenkins:jenkins /home/jenkins/.m2/ && \
    chown -R jenkins:jenkins /home/jenkins/.ssh/

USER jenkins
WORKDIR /home/jenkins

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
