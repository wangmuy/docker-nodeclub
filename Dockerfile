FROM ubuntu:16.04
MAINTAINER Zhongdi Wang <wangmuy@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Bash instead of Dash
RUN echo "dash dash/sh boolean false" | debconf-set-selections && \
    dpkg-reconfigure -p critical dash

# apt using ustc mirror
COPY sources.ustc.list /etc/apt/sources.list

RUN apt-get update && \
  apt-get install -y git vim \
    mongodb-server redis-server nodejs npm
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN cd /var/lib && git clone https://github.com/cnodejs/nodeclub.git \
  && cd nodeclub && git checkout 46d23adaa3499586c38020c330420e1e293de9a1 \
  && make install && make test

COPY start.sh /start.sh
RUN chmod 777 /start.sh
ENTRYPOINT ["/start.sh"]
