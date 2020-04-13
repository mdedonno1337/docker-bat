DIR := ${CURDIR}
CURRENT_UID := $(shell id -u)
CURRENT_GID := $(shell id -g)

all: build copy

build:
	docker build -t bat .

copy:
	docker run --rm -v $(DIR):/out -u $(CURRENT_UID):$(CURRENT_GID) bat cp /usr/local/cargo/bin/bat /out
	ls -la bat
	./bat --version

clean:
	docker rmi -f bat
	docker rmi -f rust

