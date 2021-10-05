ARG RUBY_VERSION
FROM ruby:$RUBY_VERSION-slim-buster

ARG BUNDLER_VERSION

# Configure bundler
ENV LANG=C.UTF-8 \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3

ARG APP_USER=dockeruser
ARG APP_HOME=/home/${APP_USER}/test_project

RUN useradd -ms /bin/bash ${APP_USER}

USER $APP_USER
WORKDIR $APP_HOME

# Install required Bundler version
RUN gem install bundler:$BUNDLER_VERSION

RUN gem install bundler
COPY . ./
