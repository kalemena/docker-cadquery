VERSION := latest

all: build 

pull:
	docker pull kalemena/cadquery:$(VERSION)

build:
	@echo "+++ Building docker image +++"
	docker pull ubuntu:22.04
	docker build --build-arg VERSION=$(VERSION) -t kalemena/cadquery:$(VERSION) .
	docker tag kalemena/cadquery:$(VERSION) kalemena/cadquery:latest

cadquery:
	./run.sh
