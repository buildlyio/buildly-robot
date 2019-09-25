#!/usr/bin/env bash

set -e

bash tcp-port-wait.sh $DATABASE_HOST $DATABASE_PORT

echo $(date -u) "- Migrating"
python manage.py migrate

echo $(date -u) "- Load Initial Data"
python manage.py loadinitialdata

echo "Adding logicmodules to bifrost config"
echo "Adding Documents LogicModule"
python manage.py shell -c "from gateway.models import LogicModule; LogicModule.objects.update_or_create(name='documents', endpoint='http://documentsservice:8080', endpoint_name='documents')"
echo "Adding Products LogicModule"
python manage.py shell -c "from gateway.models import LogicModule; LogicModule.objects.update_or_create(name='products', endpoint='http://productsservice:8080', endpoint_name='products')"
echo "Adding CRM LogicModule"
python manage.py shell -c "from gateway.models import LogicModule; LogicModule.objects.update_or_create(name='crm', endpoint='http://crmservice:8080', endpoint_name='crm')"
echo "Adding Location LogicModule"
python manage.py shell -c "from gateway.models import LogicModule; LogicModule.objects.update_or_create(name='locations', endpoint='http://locationservice:8080', endpoint_name='locations')"
echo "Adding TimeTracking LogicModule"
python manage.py shell -c "from gateway.models import LogicModule; LogicModule.objects.update_or_create(name='timetracking', endpoint='http://timetrackingservice:8080', endpoint_name='timetracking')"

echo $(date -u) "- Collect Static"
python manage.py collectstatic --no-input

echo "Starting celery worker"
celery_cmd="celery -A gateway worker -l info -f /var/log/celery.log"
$celery_cmd &

echo $(date -u) "- Running the server"
gunicorn -b 0.0.0.0:8080 bifrost-api.wsgi
