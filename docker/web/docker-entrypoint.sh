#!/usr/bin/env sh
set -eu

RAILS_ROOT=/usr/src/app

envsubst '${RAILS_ROOT} ${WEB_PORT} ${SERVER_NAME}' < /tmp/docker.nginx > /etc/nginx/conf.d/default.conf

exec "$@"