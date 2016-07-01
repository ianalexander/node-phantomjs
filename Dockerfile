# dockerhub - A repository for various dockerfiles
# For more information; http://github.com/cmfatih/dockerhub
#
# node-phantomjs
#
# Usage
#   docker run ianalexan/node-phantomjs /usr/bin/phantomjs -v
#   docker run ianalexan/node-phantomjs /usr/bin/nodejs --version
#   docker run -v `pwd`:/mnt/current ianalexan/node-phantomjs /usr/bin/nodejs /mnt/current/index.js


# VERSION 1.0

FROM debian:jessie

MAINTAINER ianalexan

# Basics
RUN apt-get update && \
  apt-get upgrade -y

# Node
RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
  apt-get install -y nodejs

# Phantomjs
ENV PHANTOMJS_VERSION 2.1.1
RUN \
  apt-get install -y vim git wget libfreetype6 libfontconfig bzip2 && \
  mkdir -p /srv/var && \
  wget --no-check-certificate -O /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 http://cnpmjs.org/downloads/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 && \
  tar -xjf /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 -C /tmp && \
  rm -f /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 && \
  mv /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64/ /srv/var/phantomjs && \
  ln -s /srv/var/phantomjs/bin/phantomjs /usr/bin/phantomjs
RUN \
  apt-get autoremove -y && \
  apt-get clean all

# Default command
CMD ["/usr/bin/phantomjs", "--version"]
CMD ["node", "--version"]
