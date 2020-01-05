# Copyright (c) 2019 Joseph R. Quinn <quinn.josephr@protonmail.com>
# SPDX-License-Identifier: ISC

DOCKER_HUB_USER=quinnjr
DOCKER_HUB_REPO=$(DOCKER_HUB_USER)/zsh-docker

DOCKER_BUILD_FLAGS=--pull --compress --tag $(DOCKER_HUB_REPO):v$(VERSION) --build-arg VERSION=$(VERSION) --build-arg VERSION_LATEST=$(VERSION_LATEST)

require-%:
	@: $(if $(${*}),,$(error $* variable must be set))

build: require-DOCKER_HUB_REPO require-VERSION require-VERSION_LATEST
ifeq ("$(VERSION)","$(VERSION_LATEST)")
	DOCKER_BUILDKIT=1 docker build $(DOCKER_BUILD_FLAGS) \
		--tag "$(DOCKER_HUB_REPO):latest" .
else
	DOCKER_BUILDKIT=1 docker build $(DOCKER_BUILD_FLAGS) .
endif

deploy: require-DOCKER_HUB_REPO require-DOCKER_HUB_USER require-DOCKER_HUB_PASS require-VERSION require-VERSION_LATEST
	@echo $(DOCKER_HUB_PASS) | docker login -u $(DOCKER_HUB_USER) --password-stdin
	docker push $(DOCKER_HUB_REPO):v$(VERSION)
ifeq ("$(VERSION)","$(VERSION_LATEST)")
	docker push $(DOCKER_HUB_REPO):latest
endif
