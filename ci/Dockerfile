ARG RUBY_VERSION

FROM ruby:$RUBY_VERSION as ci

ARG BUNDLER_VERSION

RUN curl https://deb.nodesource.com/setup_current.x | bash - \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

## install main deps
RUN apt-get update && apt-get install -y --no-install-recommends \
    nodejs=14* yarn gcc g++ make rsync patch postgresql-client python-psycopg2 \
    build-essential cmake imagemagick openssl libreadline6-dev zlib1g zlib1g-dev libssl-dev \
    libyaml-dev libpq-dev libxml2-dev libxslt-dev libc6-dev libicu-dev libqtwebkit-dev qt4-qmake \
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
    google-chrome-stable git libgtk2.0-0 libgtk-3-0 libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb\
    && ln -s /opt/google/chrome/chrome /usr/bin/chrome \
    && apt-get clean \
    && rm -rf /tmp/* /var/lib/apt/lists/*
