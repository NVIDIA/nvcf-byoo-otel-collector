.PHONY: test docker-build check-docker-build-env docker-run update-examples update-config-template validate-config

DOCKER_TAG := $(shell whoami)-dev

test:
	find . -name go.mod -execdir go test -v ./... \;

update-examples:
	./scripts/update-examples.sh

update-config-template:
	./scripts/start-generator.sh

validate-otelconfig:
	./scripts/validate-otelconfig.sh

docker-build: check-docker-build-env
	DOCKER_BUILDKIT=1 docker build --network=host --secret id=SERVICE_USER_ACCESS_TOKEN,env=SERVICE_USER_ACCESS_TOKEN --build-arg OTEL_BUILDER_VERSION=$(OTEL_BUILDER_VERSION) -f ./Dockerfile -t byoo-otel-collector:$(DOCKER_TAG) .

docker-run:
	docker run --network=host -v./accounts-secrets.json:/var/secrets/accounts-secrets.json -v./secrets:/etc/byoo-otel-collector/secrets/ -v./test/local/otelconfig.yaml:/etc/byoo-otel-collector/config.yaml byoo-otel-collector:$(DOCKER_TAG) $(EXTRA_ARGS)


check-docker-build-env:
	@if [ -z "$(SERVICE_USER_ACCESS_TOKEN)" ]; then \
			echo "Error: SERVICE_USER_ACCESS_TOKEN not defined."; \
			exit 1; \
	fi

	@if [ -z "$(OTEL_BUILDER_VERSION)" ]; then \
			echo "Error: OTEL_BUILDER_VERSION not defined."; \
			exit 1; \
	fi
