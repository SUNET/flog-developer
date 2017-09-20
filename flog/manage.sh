#!/bin/sh
set -e

docker exec -it flogdev_flog-app_1 bash -c "/opt/env/bin/python /opt/flog/manage.py $@ --settings=flog.settings.prod"
