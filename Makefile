# Version
VERSION := 0.1.0
MAJOR   := $(word 1, $(subst ., ,$(VERSION)))
MINOR   := $(word 2, $(subst ., ,$(VERSION)))
PATCH   := $(word 3, $(subst ., ,$(VERSION)))

IMAGE:=tmp/image
RESULTS=tmp/results
DOCKER_IMAGE:=ahawkins/asciidoctor

$(IMAGE): Dockerfile
	docker build -t $(DOCKER_IMAGE) .
	mkdir -p $(@D)
	touch $@

.PHONY: check
check:
	docker --version
	bats --version

$(RESULTS):
	mkdir -p $@

.PHONY: test
test: $(IMAGE) | $(RESULTS)
	env DOCKER_IMAGE=$(DOCKER_IMAGE) OUTPUT_DIR=$(CURDIR)/$(RESULTS) FIXTURE_DIR=$(CURDIR)/test/fixtures \
		bats test/smoke_test.bats

.PHONY: push
push: $(IMAGE)
	docker tag $(DOCKER_IMAGE) $(DOCKER_IMAGE):latest
	docker tag $(DOCKER_IMAGE) $(DOCKER_IMAGE):$(MAJOR)
	docker tag $(DOCKER_IMAGE) $(DOCKER_IMAGE):$(MAJOR).$(MINOR)
	docker tag $(DOCKER_IMAGE) $(DOCKER_IMAGE):$(MAJOR).$(MINOR).$(PATCH)
	docker push $(DOCKER_IMAGE):latest
	docker push $(DOCKER_IMAGE):$(MAJOR)
	docker push $(DOCKER_IMAGE):$(MAJOR).$(MINOR)
	docker push $(DOCKER_IMAGE):$(MAJOR).$(MINOR).$(PATCH)

.PHONY: clean
clean:
	rm -rf $(IMAGE) $(RESULTS)
