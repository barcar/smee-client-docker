FROM node:19-bullseye-slim
RUN npm install --global smee-client

RUN apt-get -y update
RUN apt-get -y upgrade

RUN apt-get install docker.io curl -y

RUN curl -L -O "https://github.com/mikefarah/yq/releases/latest/download/yq_linux_arm64"
RUN mv yq_linux_arm64 /usr/bin/yq
RUN chmod +x /usr/bin/yq

COPY ./docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]