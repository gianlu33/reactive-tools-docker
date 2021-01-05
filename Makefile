REPO=gianlu33/reactive-tools
TAG=latest

build:
	docker build -t $(REPO):$(TAG) .

deploy: build login
	docker push $(REPO):$(TAG)

login:
	docker login

run_bash: check_workspace
	docker run --rm -it --network=host -v $(WORKSPACE):/usr/src/app/ -v /var/run/aesmd/:/var/run/aesmd $(REPO):$(TAG) bash

run:
	echo "TODO"

clean:
	docker rm $(shell docker ps -a -q) 2> /dev/null || true
	docker image prune -f

check_workspace:
	@test $(WORKSPACE) || (echo "WORKSPACE variable not defined. Run make <target> WORKSPACE=<path_to_project>" && return 1)
