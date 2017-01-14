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
	docker push $(DOCKER_IMAGE):latest

.PHONY: clean
clean:
	rm -rf $(IMAGE) $(RESULTS)
