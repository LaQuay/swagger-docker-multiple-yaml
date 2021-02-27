# swagger-docker-multiple-yaml

The goal of this repository is to run multiple _Swagger_ files on a single endpoint.

## Requirements
To run this project you will need _Docker_ and _docker-compose_. Also, this project is 
meant to be run under a LINUX environment. _Bash_ is also a requirement.

## What's inside
You will find a Nginx embedded inside the official image of _Swagger_ in the _Docker_
environment.

## How to run

### Setup

Run the following command to setup up the project. In here nothing is meant to be modified.

`make build`

`make run`

### Run the project

You need to modify the file `config_swagger.sh` with your desired preferences and endpoints.

`SERVER_URL`: Add here your root URL for the server that will be serving the APIs.

`SWAGGER_NUMBER`: The number of swagger files to be added.

`SWAGGER_N_NAME`: Title for the particular file.

`SWAGGER_N_FILE`: Filename of the Swagger.

`SWAGGER_N_ENDPOINT`: Endpoint in which the API will serve the information.

Run the following command to run the configuration of the endpoints for the project.

`make configure`

### Screenshots

![Swagger with Test 1](img/sample_test_1.jpg?raw=true "Swagger with Test 1")

![Swagger with Selector](img/sample_selector.jpg?raw=true "Swagger with Selector")

![Swagger with Test 2](img/sample_test_2.jpg?raw=true "Swagger with Test 2")