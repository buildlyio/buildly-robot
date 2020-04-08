#!/usr/bin/env bash

set -e

bash /scripts/tcp-port-wait.sh $DATABASE_HOST $DATABASE_PORT

echo $(date -u) "- Migrating"
python manage.py migrate

echo $(date -u) "- Load Initial Data"
python manage.py loadinitialdata

echo "Adding logicmodules to buildly config"
echo "Adding Products LogicModule"
python manage.py shell -c "from core.models import LogicModule; LogicModule.objects.update_or_create(name='products', endpoint='http://productsservice:8080', endpoint_name='products')"
echo "Adding Location LogicModule"
python manage.py shell -c "from core.models import LogicModule; LogicModule.objects.update_or_create(name='locations', endpoint='http://locationservice:8080', endpoint_name='locations')"


echo $(date -u) "- Collect Static"
python manage.py collectstatic --no-input

echo $(date -u) "- Running the server"
gunicorn -b 0.0.0.0:8080 buildly.wsgi
