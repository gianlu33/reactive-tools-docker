REPO=gianlu33/reactive-tools
TAG=latest

build:
	docker build -t $(REPO):$(TAG) .

push: build login
	docker push $(REPO):$(TAG)

pull:
	docker pull $(REPO):$(TAG)

login:
	docker login

clean:
	docker rm $(shell docker ps -a -q) 2> /dev/null || true
	docker image prune -f
