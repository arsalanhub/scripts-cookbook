IMAGE_NAME = dex
CONTAINER_NAME = $(IMAGE_NAME)_container

.PHONY: run
run: build
	docker run -d --name $(CONTAINER_NAME) -p 8080:80 $(IMAGE_NAME)

.PHONY: build
build:
	docker build -t $(IMAGE_NAME) .

.PHONY: stop
stop:
	docker stop $(CONTAINER_NAME) || true
	docker rm $(CONTAINER_NAME) || true

.PHONY: clean
clean: stop
	docker rmi $(IMAGE_NAME) || true

