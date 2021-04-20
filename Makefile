REPO							?= gianlu33/reactive-tools
TAG								?= fosdem

BACKUP						?= registry.rosetta.ericssondevops.com/gftl-er-5g-hosts/authentic-execution/fosdem-21-images/reactive-tools

VOLUME						?= $(shell pwd)

build:
	docker build -t $(REPO):$(TAG) --build-arg DUMMY=$(shell date +%s) .

push: login
	docker push $(REPO):$(TAG)

push_backup:
		docker tag $(REPO):$(TAG) $(BACKUP):$(TAG)
		docker push $(BACKUP):$(TAG)

pull:
	docker pull $(REPO):$(TAG)

run:
	docker run --rm -it --network=host -v $(VOLUME):/usr/src/app/ $(REPO):$(TAG) bash

login:
	docker login

clean:
	docker rm $(shell docker ps -a -q) 2> /dev/null || true
	docker image prune -f
