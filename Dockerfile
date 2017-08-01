FROM ubuntu:latest

MAINTAINER Isaac A., <isaac@isaacs.site>

RUN apt update && \
    apt upgrade -y && \
    apt install -y lib32gcc1 lib32stdc++6 unzip curl && \
    curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
    apt install -y nodejs && \
    useradd -d /home/container -m container
    echo nameserver 91.214.70.1 > /etc/resolv.conf

USER container
ENV  USER container
ENV  HOME /home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
COPY ./wrapper.js /wrapper.js
COPY ./node_modules/ /node_modules/

CMD ["/bin/bash", "/entrypoint.sh"]
