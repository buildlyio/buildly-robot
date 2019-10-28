
echo "Adding logicmodules to bifrost config"

echo "Adding Products LogicModule"
docker exec -it bifrost bash -c "python manage.py shell -c \"from gateway.models import LogicModule; LogicModule.objects.create(name='products', endpoint='http://productsservice:8080', endpoint_name='products')\""
