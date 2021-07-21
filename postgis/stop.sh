#!/bin/bash
set -e

if [ -f run.prop ]; then
    echo "run.prop file found."
    echo "Loading run.prop file."
    export $(cat run.prop | grep -v ^#)
else
    echo "run.prop file not found!"
    exit 1
fi

# Docker Properties
[ -z "${SERVICE_NAME}" ] && echo 'Error: SERVICE_NAME not declared' && exit 1

# Postgres Properties
[ -z "${POSTGIS_PORT}" ] && echo 'Error: POSTGIS_PORT not declared' && exit 1
[ -z "${POSTGIS_PASSWORD}" ] && echo 'Error: POSTGIS_PASSWORD not declared' && exit 1

docker-compose down
