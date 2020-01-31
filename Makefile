HELM_ARTIFACTORY=https://artifactory.toolchain.lead.prod.liatr.io/artifactory/helm
HELM_HARBOR=https://harbor.toolchain.lead.sandbox.liatr.io/api/chartrepo

GIT_BRANCH?=$(shell git rev-parse --abbrev-ref HEAD)
VERSION=$(shell git describe --tags --dirty | cut -c 2-)
IS_SNAPSHOT = $(if $(findstring -, $(VERSION)),true,false)
MAJOR_VERSION := $(word 1, $(subst ., ,$(VERSION)))
MINOR_VERSION := $(word 2, $(subst ., ,$(VERSION)))
PATCH_VERSION := $(word 3, $(subst ., ,$(word 1,$(subst -, , $(VERSION)))))
NEW_VERSION ?= $(MAJOR_VERSION).$(MINOR_VERSION).$(shell echo $$(( $(PATCH_VERSION) + 1)) )
ARTIFACTORY_CREDS ?= $(shell cat /root/.docker/config.json | sed -n 's/.*auth.*"\(.*\)".*/\1/p'| head -1 | base64 -d)
HARBOR_CREDS ?= $(shell cat /root/.docker/config.json | sed -n 's/.*auth.*"\(.*\)".*/\1/p'| tail -1 | base64 -d)

version:
	@echo "$(VERSION)"

harbor_creds:
	@echo "$(HARBOR_CREDS)"

build: 
	@skaffold build 

charts: 
	@helm init --client-only
	@helm lint charts/hello-world
	@helm package --version $(VERSION) --app-version v$(VERSION) charts/hello-world

helm_push_artifactory:
	@curl -f -X PUT -u $(ARTIFACTORY_CREDS) -T hello-world-$(VERSION).tgz $(HELM_ARTIFACTORY)/hello-world-$(VERSION).tgz

helm_push_harbor:
	@curl -u '$(HARBOR_CREDS)' -X POST $(HELM_HARBOR)/jlab/charts \
	 -H "Content-Type: multipart/form-data" \
	 -F "chart=@hello-world-$(VERSION).tgz;type=application/x-compressed-tar"

.PHONY: charts
