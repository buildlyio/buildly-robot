# Buildly Robot Test Suite
End to end test suite for the Buildly platform, including both the Buildly Core backend and Buildly UI.

## Test locally
This setup can be used to test Buildly Core and Buildly UI locally.
For this you need to run all services from a docker compose file:

`docker-compose -f docker-compose.yaml up`

Once all services are started the following is available on your localhost:

- `http://localhost:9001` [Buildly UI React Frontend](http://localhost:9001)
- `http://localhost:8080/docs` [Buildly Swagger docs](http://localhost:8080/docs)
- `http://localhost:8080/admin` [Buildly Django Admin](http://localhost:8080/admin)

## Running the test suite
The test suite can be executed by running

`docker-compose up`

This will start all services with the right configuration and then execute the test suite with the right variables.

## Update to a new version a service
The file [.env](../master/.env) is in control of all service versions used by the docker-compose files.
Therefor to update to a new service version, you'll need to update the .env file.

## Run test suite in CI environment
This is currently work in progress...
