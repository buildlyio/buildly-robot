
echo "Adding logicmodules to Buildly config"

echo "Adding Products LogicModule"
docker exec -it buildly bash -c "python manage.py shell -c \"from gateway.models import LogicModule; LogicModule.objects.create(name='products', endpoint='http://productsservice:8080', endpoint_name='products')\""

echo "Adding Location LogicModule"
docker exec -it buildly bash -c "python manage.py shell -c \"from gateway.models import LogicModule; LogicModule.objects.create(name='locations', endpoint='http://locationservice:8080', endpoint_name='locations')\""
