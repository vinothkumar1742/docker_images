# Docker image to use.
FROM base-ubuntu:20.04

# Install system packages.
RUN apt-get update && apt-get install -y libcurl4 openssl liblzma5

# Install MongoDB.
WORKDIR /tmp
RUN set -x \
  && wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-ubuntu2004-7.0.14.tgz --quiet \
  && tar -zxvf mongodb-linux-*-7.0.14.tgz > /dev/null \
  && mv mongodb-linux-x86_64-ubuntu2004-7.0.14/bin/* /usr/local/bin/ \
  && rm -rf mongodb-linux-x86_64-ubuntu2004-7.0.14*

# Install MongoDB shell.
RUN set -x \
  && wget https://downloads.mongodb.com/compass/mongosh-2.3.0-linux-x64.tgz --quiet \
  && tar xvzf mongosh-2.3.0-linux-x64.tgz > /dev/null \
  && mv mongosh-2.3.0-linux-x64/bin/* /usr/local/bin/ \
  && rm -rf mongosh-2.3.0-linux-x64*

# Create MongoDB directories.
RUN set -x \
  && mkdir /opt/mongo-db \
  && mkdir /opt/mongo-db/data \
  && mkdir /opt/mongo-db/log \
  && mkdir /opt/mongo-db/conf \
  && mkdir /opt/mongo-db/script \
  && mkdir /opt/mongo-db/system \
  && touch /opt/mongo-db/system/server.pid \
  && touch /opt/mongo-db/system/supervisor.ini \
  && ln -s /opt/mongo-db/system/supervisor.ini /etc/supervisord.d/mongo-db.ini \


# Set default work directory.
WORKDIR /opt/mongo-db