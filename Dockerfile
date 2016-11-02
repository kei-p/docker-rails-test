FROM ubuntu:14.04
MAINTAINER kei-p "muddyapesjm66@gmail.com"

## Install Web Packages
RUN  apt-get update -qq \
  && apt-get install -y -qq \
      wget \
      autoconf \
      imagemagick \
      libaio1 \
      libbz2-dev \
      libevent-dev \
      libglib2.0-dev \
      libjpeg-dev \
      libmagickcore-dev \
      libmagickwand-dev \
      libncurses-dev \
      libcurl4-openssl-dev \
      libffi-dev \
      libgdbm-dev \
      libpq-dev \
      libreadline-dev libreadline6-dev \
      libssl-dev \
      libtool \
      libxml2-dev \
      libxslt-dev \
      libyaml-dev \
      software-properties-common \
      zlib1g-dev \
      git \
      curl \
      make \
      build-essential g++ \
  && apt-get clean -qq \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

## Mysql
ADD http://dev.mysql.com/get/mysql-apt-config_0.1.5-2ubuntu14.04_all.deb /tmp/
RUN DEBIAN_FRONTEND=noninteractive dpkg -i /tmp/mysql-apt-config_0.1.5-2ubuntu14.04_all.deb \
  && DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-server

RUN git clone https://github.com/MarkLeith/mysql-sys.git /tmp/mysql-sys

ADD my.cnf /etc/mysql/my.cnf

ADD mysql-init /usr/bin/mysql-init
RUN chmod +x /usr/bin/mysql-init \
  && /usr/bin/mysql-init

## Ruby
ENV RUBY_MAJOR 2.2
ENV RUBY_VERSION 2.2.5

ENV PATH $PATH:/opt/rubies/ruby-$RUBY_VERSION/bin

RUN curl -O http://ftp.ruby-lang.org/pub/ruby/$RUBY_MAJOR/ruby-$RUBY_VERSION.tar.gz && \
    tar -zxvf ruby-$RUBY_VERSION.tar.gz && \
    cd ruby-$RUBY_VERSION && \
    ./configure --disable-install-doc && \
    make && \
    make install && \
    cd .. && \
    rm -r ruby-$RUBY_VERSION ruby-$RUBY_VERSION.tar.gz && \
    echo 'gem: --no-document' > /usr/local/etc/gemrc

## Rubygems and Bundler
ENV RUBYGEMS_MAJOR 2.3
ENV RUBYGEMS_VERSION 2.3.0

ADD http://production.cf.rubygems.org/rubygems/rubygems-$RUBYGEMS_VERSION.tgz /tmp/
RUN cd /tmp && \
    tar -zxf /tmp/rubygems-$RUBYGEMS_VERSION.tgz && \
    cd /tmp/rubygems-$RUBYGEMS_VERSION && \
    ruby setup.rb && \
    /bin/bash -l -c 'gem install bundler --no-rdoc --no-ri' && \
    echo "gem: --no-ri --no-rdoc" > ~/.gemrc
