FROM ubuntu:14.04
MAINTAINER eyeos

ENV InstallationDir /var/service/
ENV WHATAMI websockify

#RUN apt-get install -y openssl
#RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 68576280 && \
#    apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y software-properties-common python-software-properties && \
#    apt-add-repository "deb https://deb.nodesource.com/node_5.x $(lsb_release -sc) main" && \
#    apt-get update && \
#    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y nodejs npm
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y nodejs npm
RUN apt-get install openssl

WORKDIR ${InstallationDir}
COPY . ${InstallationDir}

RUN cd netMeasurer && npm install && npm cache clean && cd ..

WORKDIR src
RUN bash ${InstallationDir}/src/generate-keys.sh

RUN npm install --verbose && \
    npm cache clean

CMD ${InstallationDir}/start.sh
