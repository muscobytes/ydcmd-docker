#!/usr/bin/env make

NAMESPACE := muscobytes
IMAGE := ydcmd
TAGS := latest $(VERSION)
DOT_ENV_FILE := $(shell pwd)/.env

ifneq ($(wildcard $(DOT_ENV_FILE)),"")
	include $(DOT_ENV_FILE)
endif

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: run
run:
	docker run -ti --rm -e YDCMD_TOKEN=$(YDCMD_TOKEN) $(NAMESPACE)/$(IMAGE) ls

.PHONY: build
build:
	docker build $(foreach TAG, $(TAGS),--tag $(NAMESPACE)/$(IMAGE):$(TAG)) .

.PHONY: push
push:
	docker push --all-tags $(NAMESPACE)/$(IMAGE)

.PHONY: login
login:
	docker login docker.io
