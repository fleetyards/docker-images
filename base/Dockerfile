ARG RUBY_VERSION

FROM ruby:$RUBY_VERSION

ARG BUNDLER_VERSION

RUN curl -sL https://deb.nodesource.com/setup_current.x | bash - \
    && curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \

## install main deps
RUN apt-get update && apt-get install -y --no-install-recommends \
    nodejs yarn gcc g++ make rsync patch postgresql-client python-psycopg2 \
    build-essential cmake imagemagick openssl libreadline6-dev zlib1g zlib1g-dev libssl-dev \
    libyaml-dev libpq-dev libxml2-dev libxslt-dev libc6-dev libicu-dev libqtwebkit-dev qt4-qmake \
    xvfb bzip2 libssl-dev unzip \
    && apt-get clean \
    && rm -rf /tmp/* /var/lib/apt/lists/*

## install bundler
RUN gem update --system
RUN gem install bundler -v $BUNDLER_VERSION

RUN mkdir /app
WORKDIR /app
