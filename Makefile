REPO						= gianlu33/reactive-tools
TAG							?= latest

VOLUME					?= $(shell pwd)

build:
	DOCKER_BUILDKIT=1 docker build --ssh default -t $(REPO):$(TAG) --build-arg DUMMY2=$(shell date +%s) .

push: login
	docker push $(REPO):$(TAG)

pull:
	docker pull $(REPO):$(TAG)

run:
	docker run --rm -it --network=host -v $(VOLUME):/usr/src/app/ $(REPO):$(TAG) bash

login:
	docker login

clean:
	docker rm $(shell docker ps -a -q) 2> /dev/null || true
	docker image prune -f
