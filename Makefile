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

check:
	-git clone https://github.com/sharkdp/bat.git /tmp/bat
	-git --git-dir=/tmp/bat/.git pull
	@echo ""
	@echo ""
	@echo "latest bat version"
	@git --git-dir=/tmp/bat/.git describe --tags `git --git-dir=/tmp/bat/.git rev-list --tags --max-count=1`
	@echo ""
	@echo "current bat version"
	@bat --version | sed -e 's/bat //g'
	@echo ""

