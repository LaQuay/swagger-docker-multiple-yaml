NAME=docker-swagger
VERSION=1.0.0
DOCKER_NAME=laquay/$(NAME)
DOCKER_NAME_FULL=$(DOCKER_NAME):$(VERSION)

build:
	docker build -t $(DOCKER_NAME_FULL) docker/.

run:
	docker-compose -f docker-compose.yml up -d

stop:
	docker-compose -f docker-compose.yml stop

configure:
	bash config_swagger.sh

test-server:
	docker run -it -p "8081:80" \
	    --name $(NAME) \
	    --env-file .env \
	    --volume `pwd`/swagger.example.1.yaml:/app/swagger.yaml \
	    --rm $(DOCKER_NAME_FULL)
