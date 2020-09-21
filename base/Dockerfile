ARG RUBY_VERSION

FROM ruby:$RUBY_VERSION

ARG BUNDLER_VERSION
ARG YARN_VERSION

RUN curl -sL https://deb.nodesource.com/setup_current.x | sudo -E bash -

## install main deps
RUN apt-get update && apt-get install -y --no-install-recommends \
    nodejs rsync patch postgresql-client python-psycopg2 \
    build-essential cmake imagemagick openssl libreadline6-dev zlib1g zlib1g-dev libssl-dev \
    libyaml-dev libpq-dev libxml2-dev libxslt-dev libc6-dev libicu-dev libqtwebkit-dev qt4-qmake \
    xvfb bzip2 libssl-dev unzip \
    && apt-get clean \
    && rm -rf /tmp/* /var/lib/apt/lists/*

## install yarn
RUN curl -o- -L https://yarnpkg.com/install.sh | bash -s -- --version $YARN_VERSION

## install bundler
RUN gem update --system
RUN gem install bundler -v $BUNDLER_VERSION

RUN mkdir /app
WORKDIR /app
