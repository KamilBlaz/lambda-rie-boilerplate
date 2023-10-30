
export RUNTIME_LANG = python
export RUNTIME_VERSION = 3.10
export IMAGE_NAME = backend:${RUNTIME_LANG}-${RUNTIME_VERSION}

.PHONY: lint-dockerfile build  local-lambda

lint-dockerfile:
	@hadolint docker/Dockerfile

build:
	docker-compose build \
 			--build-arg RUNTIME_LANG=${RUNTIME_LANG} \
 			--build-arg RUNTIME_VERSION=${RUNTIME_VERSION} \
 			--build-arg IMAGE_NAME=${IMAGE_NAME}

local-lambda:
	docker-compose up
