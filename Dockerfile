FROM debian:12-slim
RUN apt-get update
RUN apt-get install -y openssh-server corosync-qnetd corosync-qdevice
ADD init.sh /
ADD setup.lua /
EXPOSE 5403/tcp
EXPOSE 22/tcp
ENTRYPOINT ["/bin/bash", "/init.sh"]
