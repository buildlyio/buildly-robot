# Platform Robot Test Suite
End to end test suite for all platform services including Midgard Angular and Midgard React

## Test locally
This setup can be used to test Bifrost and Midgard locally.
For this you need to run all services from a docker compose file:

`docker-compose -f docker-compose-localhost.yaml up`

Once all services are started the following is available on your localhost:

- `http://localhost:9000` [Midgard Angular Frontend](http://localhost:9000)
- `http://localhost:9001` [Midgard React Frontend](http://localhost:9001)
- `http://localhost:8090/docs` [Bifrost Swagger docs](http://localhost:8090/docs)
- `http://localhost:8090/admin` [Bifrost Django Admin](http://localhost:8090/admin)

## Running the test suite
The test suite can be executed by running

`docker-compose up`

This will start all services with the right configuration and then execute the test suite with the right variables.

## Update to a new version a service
The file [.env](../master/.env) is in control of all service versions used by the docker-compose files.
Therefor to update to a new service version, you'll need to update the .env file.

## Run test suite in CI environment
This is currently work in progress...
