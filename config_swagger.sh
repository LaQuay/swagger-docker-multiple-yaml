#!/usr/bin/env bash

### Configuration ###
# Add your SWAGGER_N information.
#
# SWAGGER_X_NAME Title of the Swagger file
# SWAGGER_X_FILE File that will be added to the general Swagger environment
# SWAGGER_X_ENDPOINT The endpoint of the API (SERVER_URL + SWAGGER_N_ENDPOINT) = FULL_URL
#
# More info in README.md

SERVER_URL=YOUR_BASE_SERVER_URL
SWAGGER_NUMBER=3

SWAGGER_1_NAME="TEST 1"
SWAGGER_1_FILE=swagger.example.1.yaml
SWAGGER_1_ENDPOINT="test1/"

SWAGGER_2_NAME="TEST 2"
SWAGGER_2_FILE=swagger.example.2.yaml
SWAGGER_2_ENDPOINT="test2/"

SWAGGER_3_NAME="TEST 3"
SWAGGER_3_FILE=swagger.example.3.yaml
SWAGGER_3_ENDPOINT="test3/"

# Manually add new lines for new files, copy the second line as example
APIS="{url: \"./$SWAGGER_1_FILE\", name: \"$SWAGGER_1_NAME\"}, \
        {url: \"./$SWAGGER_2_FILE\", name: \"$SWAGGER_2_NAME\"}, \
        {url: \"./$SWAGGER_3_FILE\", name: \"$SWAGGER_3_NAME\"}"

### CODE - DO NOT MODIFY FROM HERE ###
NGINX_ROOT=/usr/share/nginx/html

if [ ! "$BASH_VERSION" ]; then
  echo "Please do not use sh to run this script ($0), execute it with bash" 1>&2
  exit 1
fi

mkdir tmp_swagger
cd tmp_swagger
rm -rf *

for IDX in $(seq ${SWAGGER_NUMBER}); do
  SWAGGER_NAME="SWAGGER_${IDX}_NAME"
  SWAGGER_NAME=${!SWAGGER_NAME}
  SWAGGER_FILE="SWAGGER_${IDX}_FILE"
  SWAGGER_FILE=${!SWAGGER_FILE}
  SWAGGER_ENDPOINT="SWAGGER_${IDX}_ENDPOINT"
  SWAGGER_ENDPOINT=${!SWAGGER_ENDPOINT}

  echo "Swagger for $SWAGGER_NAME"

  # copy Swagger YAMLs
  cp ../"$SWAGGER_FILE" "$SWAGGER_FILE"

  # changing Swagger URL outputs
  sed -i "s|ENV_BACKEND_SWAGGER|$SERVER_URL$SWAGGER_ENDPOINT|" "$SWAGGER_FILE"

  # modify yaml to add auth
  sed -i "/components:/a \  securitySchemes:\n    bearerAuth:\n      type: http\n      scheme: bearer\n      bearerFormat: JWT" "$SWAGGER_FILE"
  sed -i "/components:/i \security:\n  - bearerAuth: []" "$SWAGGER_FILE"

  # copy files to Swagger container
  docker cp "$SWAGGER_FILE" swagger-docker-multiple-yaml_swagger_1:/app/"$SWAGGER_FILE"
done

# write custom tag in index.html so later can be modified
docker exec -i swagger-docker-multiple-yaml_swagger_1 sh -c "cd $NGINX_ROOT && sed -i 's|url: \"./swagger.yaml\"|urls: [ADD_HERE_URLS]|' index.html"
docker exec -i swagger-docker-multiple-yaml_swagger_1 sh -c "cp *.yaml $NGINX_ROOT/"
docker exec -i swagger-docker-multiple-yaml_swagger_1 sh -c "cd $NGINX_ROOT && sed -i 's|ADD_HERE_URLS|$APIS|' index.html"

cd ..
rm -rf tmp_swagger
