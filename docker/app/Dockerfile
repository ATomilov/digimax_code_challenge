ARG RUBY_VERSION
FROM ruby:$RUBY_VERSION-slim-buster

ARG APP_USER=dockeruser
ARG APP_HOME=/home/${APP_USER}/test_project

RUN useradd -ms /bin/bash ${APP_USER}

USER $APP_USER
WORKDIR $APP_HOME
