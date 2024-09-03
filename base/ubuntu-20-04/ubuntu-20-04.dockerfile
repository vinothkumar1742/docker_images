# Docker image to use.
FROM ubuntu:20.04

# Install system packages.
RUN set -x \
  && apt update \
  && apt upgrade -y \
  && apt install -y wget vim net-tools gcc make tar git unzip sysstat gzip curl nano openssl bash tree

# Install Supervisor.
RUN set -x \
  && apt-get install -y supervisor \
  && mkdir /etc/supervisord.d 
  

# Set default work directory.
WORKDIR /
