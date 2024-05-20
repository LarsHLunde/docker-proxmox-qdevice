FROM debian:12-slim
RUN apt-get update
RUN apt-get install -y nodejs npm
ADD init.sh /
ADD setup.lua /
WORKDIR "/application"
EXPOSE 5403/tcp
EXPOSE 22/tcp
ENTRYPOINT ["/bin/bash", "/init.sh"]
