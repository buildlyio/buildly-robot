
echo "Adding logicmodules to bifrost config"

echo "Adding Documents LogicModule"
docker exec -it bifrost bash -c "python manage.py shell -c \"from gateway.models import LogicModule; LogicModule.objects.create(name='documents', endpoint='http://documentsservice:8080', endpoint_name='documents')\""

echo "Adding Products LogicModule"
docker exec -it bifrost bash -c "python manage.py shell -c \"from gateway.models import LogicModule; LogicModule.objects.create(name='products', endpoint='http://productsservice:8080', endpoint_name='products')\""

echo "Adding CRM LogicModule"
docker exec -it bifrost bash -c "python manage.py shell -c \"from gateway.models import LogicModule; LogicModule.objects.create(name='crm', endpoint='http://crmservice:8080', endpoint_name='crm')\""

echo "Adding Location LogicModule"
docker exec -it bifrost bash -c "python manage.py shell -c \"from gateway.models import LogicModule; LogicModule.objects.create(name='locations', endpoint='http://locationservice:8080', endpoint_name='locations')\""

echo "Adding TimeTracking LogicModule"
docker exec -it bifrost bash -c "python manage.py shell -c \"from gateway.models import LogicModule; LogicModule.objects.create(name='timetracking', endpoint='http://timetrackingservice:8080', endpoint_name='timetracking')\""
