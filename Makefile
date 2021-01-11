REPO=gianlu33/reactive-tools
TAG=latest

build:
	docker build -t $(REPO):$(TAG) .

trigger_rebuild:
	echo "" >> scripts/install_reactive_tools.sh

rebuild: trigger_rebuild push

push: build login
	docker push $(REPO):$(TAG)

pull:
	docker pull $(REPO):$(TAG)

run: check_workspace
	docker run --rm -it --network=host -v $(WORKSPACE):/usr/src/app/ -v /var/run/aesmd/:/var/run/aesmd gianlu33/reactive-tools bash

login:
	docker login

clean:
	docker rm $(shell docker ps -a -q) 2> /dev/null || true
	docker image prune -f

check_workspace:
	@test $(WORKSPACE) || (echo "WORKSPACE variable not defined. Run make <target> WORKSPACE=<path_to_project>" && return 1)
