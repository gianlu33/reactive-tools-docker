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

push_all:
	make push $(REPO):$(TAG_LATEST)
	make push $(REPO):$(TAG_NATIVE)
	make push $(REPO):$(TAG_SGX)
	make push $(REPO):$(TAG_SANCUS)

pull_all:
	make pull $(REPO):$(TAG_LATEST)
	make pull $(REPO):$(TAG_NATIVE)
	make pull $(REPO):$(TAG_SGX)
	make pull $(REPO):$(TAG_SANCUS)

build:
	docker build -t $(REPO):$(TAG) --build-arg DUMMY=$(shell date +%s) -f $(DOCKERFILE) .

push: build login
	docker push $(REPO):$(TAG)

pull:
	docker pull $(REPO):$(TAG)

run: check_workspace
	docker run --rm -it --network=host -v $(WORKSPACE):/usr/src/app/ -v /var/run/aesmd/:/var/run/aesmd $(REPO):$(TAG) bash

login:
	docker login

clean:
	docker rm $(shell docker ps -a -q) 2> /dev/null || true
	docker image prune -f

check_workspace:
	@test $(WORKSPACE) || (echo "WORKSPACE variable not defined. Run make <target> WORKSPACE=<path_to_project>" && return 1)
