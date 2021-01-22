REPO						= gianlu33/reactive-tools
TAG_LATEST			= latest
TAG_NATIVE			= native
TAG_SGX					= sgx
TAG_SANCUS			= sancus

TAG							?= latest

ifeq ($(TAG), latest)
DOCKERFILE 			= Dockerfile
else
DOCKERFILE			= Dockerfile_$(TAG)
endif

VOLUME					?= $(shell pwd)

push_all:
	make push TAG=$(TAG_LATEST)
	make push TAG=$(TAG_NATIVE)
	make push TAG=$(TAG_SGX)
	make push TAG=$(TAG_SANCUS)

pull_all:
	make pull TAG=$(TAG_LATEST)
	make pull TAG=$(TAG_NATIVE)
	make pull TAG=$(TAG_SGX)
	make pull TAG=$(TAG_SANCUS)

build:
	docker build -t $(REPO):$(TAG) --build-arg DUMMY2=$(shell date +%s) -f $(DOCKERFILE) .

push: build login
	docker push $(REPO):$(TAG)

pull:
	docker pull $(REPO):$(TAG)

run:
	docker run --rm -it --network=host -v $(VOLUME):/usr/src/app/ -v /var/run/aesmd/:/var/run/aesmd $(REPO):$(TAG) bash

login:
	docker login

clean:
	docker rm $(shell docker ps -a -q) 2> /dev/null || true
	docker image prune -f
