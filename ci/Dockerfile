ARG RUBY_VERSION

FROM ruby:$RUBY_VERSION as ci

ARG NODE_VERSION
ARG BUNDLER_VERSION

RUN curl https://deb.nodesource.com/setup_current.x | bash - \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN curl -sS https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -\
    && echo "deb https://deb.nodesource.com/node_${NODE_VERSION}.x focal main" | tee /etc/apt/sources.list.d/node.list

## install main deps
RUN apt-get update && apt-get install -y --no-install-recommends \
    nodejs=$NODE_VERSION* yarn gcc g++ make rsync patch postgresql-client \
    build-essential cmake imagemagick openssl libreadline6-dev zlib1g zlib1g-dev libssl-dev \
    libyaml-dev libpq-dev libxml2-dev libxslt-dev libc6-dev libicu-dev \
    xvfb bzip2 libssl-dev unzip shared-mime-info \
    && apt-get clean \
    && rm -rf /tmp/* /var/lib/apt/lists/*

## install bundler
RUN gem update --system
RUN gem install bundler -v $BUNDLER_VERSION

RUN mkdir /app
WORKDIR /app

FROM ci as e2e

## install chrome
RUN curl -L https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list

RUN apt-get update && apt-get install -y --no-install-recommends \
    google-chrome-stable git libgtk2.0-0 libgtk-3-0 libnotify-dev libgconf-2-4 gconf2-common libnss3 libxss1 libasound2 libxtst6 xauth xvfb\
    && ln -s /opt/google/chrome/chrome /usr/bin/chrome \
    && apt-get clean \
    && rm -rf /tmp/* /var/lib/apt/lists/*
