REPO=gianlu33/reactive-tools
TAG=latest

build:
	docker build -t $(REPO):$(TAG) .

deploy: build
	docker push $(REPO):$(TAG)

run_bash: check_workspace
	docker run --rm -it --network=host -v $(WORKSPACE):/usr/src/app/ -v /var/run/aesmd/:/var/run/aesmd $(REPO):$(TAG) bash

run:
	echo "TODO"

check_workspace:
	@test $(WORKSPACE) || (echo "WORKSPACE variable not defined. Run make <target> WORKSPACE=<path_to_project>" && return 1)
