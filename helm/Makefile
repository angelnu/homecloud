#Binaries
KUBECTL_BIN=/snap/bin/microk8s kubectl
HELM_BIN=/snap/bin/microk8s helm3

PRE_INSTALL=
CRD_CHARTS=postgresop-crd cert-manager #db-crd openebs
REGULAR_CHARTS= \
metallb cert-manager-dnsmadeeasy certs ingress-nginx \
home-assistant-wrapper esphome \
ttrss nextcloud-bundle heimdall reverse-proxy gitea-wrapper \
chirpstack-packet-multiplexer lorawan-server mosquitto-wrapper
EXAMPLE_CHARTS=postgres postgresop cockroach login iobroker keel
USED_CHILDRENS=$(CRD_CHARTS) $(REGULAR_CHARTS)
ALL_CHILDRENS=$(USED_CHILDRENS) $(EXAMPLE_CHARTS)

#Other Settings
POST_INSTALL_postgresop-crd=-${KUBECTL_BIN} apply -f https://raw.githubusercontent.com/zalando/postgres-operator/master/charts/postgres-operator/crds/postgresqls.yaml ; \
  while ! ${KUBECTL_BIN} get pods -A |grep postgresop-crd-postgres-operator|grep Running; do echo .; sleep 2; done

#OPTIONS_openebs=--namespace=openebs

CERT_MANAGER_CDR_VERSION=1.1.0
PRE_INSTALL_cert-manager=-${KUBECTL_BIN} create namespace cert-manager
POST_INSTALL_cert-manager=${KUBECTL_BIN} apply -f https://github.com/jetstack/cert-manager/releases/download/v$(CERT_MANAGER_CDR_VERSION)/cert-manager.crds.yaml; \
  while ! ${KUBECTL_BIN} get pods -A |grep cert-manager-webhook|grep Running; do echo .; sleep 2; done
OPTIONS_cert-manager=--namespace cert-manager
POST_DELETE_cert-manager=${KUBECTL_BIN} delete namespace cert-manager

POST_INSTALL_login=-${KUBECTL_BIN} delete service $(CHART_NAME)-openldap

.PHONY: $(foreach _children,$(ALL_CHILDRENS),$(_children)-dep $(_children)-sel $(_children) $(_children)-del)
ENABLE_CONFIG=--set all.enabled=true

# build all
#   make dep
#   make

# install single component
#   make login-sel (only once)
#   make login-dep
#   make login

all: pre-install $(USED_CHILDRENS)
	@echo
	@echo "All charts installed:"
	@echo "$(CHILDRENS)"

all-cdr: pre-install $(CRD_CHARTS)
	@echo
	@echo "All CDR charts installed:"
	@echo "$(CHILDRENS)"
	
dep: $(foreach _children,$(ALL_CHILDRENS),$(_children)-dep)
	${HELM_BIN} dep update .

del: $(foreach _children,$(ALL_CHILDRENS),$(_children)-del)

list:
	${HELM_BIN} list -a --all-namespaces

pre-install: $(PRE_INSTALL)
	@echo
	@echo "All pre-installs executed:"
	@echo "$(PRE_INSTALL)"
	-${KUBECTL_BIN} create namespace test

CHART_NAME=$(1)
RELEASE_NAME=$(2)$(1)
VAR_FILE=$(3)
NAMESPACE=$(4)
CHILDREN_SETS=--set all.enabled=false --set $(CHART_NAME).enabled=true $(OPTIONS_$(1))
define CHILDREN_RULES

$(RELEASE_NAME)-dep:
	-${HELM_BIN} dep update charts/$(CHART_NAME)

$(RELEASE_NAME):
	$(PRE_INSTALL_$(CHART_NAME))
	if ${HELM_BIN} list --all-namespaces|grep -q "^$(RELEASE_NAME)"; then \
	  echo "Upgrading $(CHART_NAME)"; \
	  ansible-vault decrypt $(VAR_FILE) --output - | ${HELM_BIN} $(CHILDREN_SETS) upgrade $(NAMESPACE) -f - -i $(RELEASE_NAME) . --render-subchart-notes  --reset-values; \
	else \
	  echo "Install $(CHART_NAME)"; \
	  ansible-vault decrypt $(VAR_FILE) --output - | ${HELM_BIN} $(CHILDREN_SETS) install $(NAMESPACE) -f -    $(RELEASE_NAME) . --render-subchart-notes; \
	fi
	$(POST_INSTALL_$(CHART_NAME))

$(RELEASE_NAME)-del:
	${HELM_BIN} delete $(NAMESPACE) $(OPTIONS_$(1)) $(RELEASE_NAME)
		$(POST_DELETE_$(CHART_NAME))

$(RELEASE_NAME)-debug:
	ansible-vault decrypt $(VAR_FILE) --output - | ${HELM_BIN} $(CHILDREN_SETS) template $(NAMESPACE) -f - $(RELEASE_NAME) .

$(RELEASE_NAME)-test:
	${HELM_BIN} test $(NAMESPACE) $(RELEASE_NAME)

endef

$(foreach _children, $(ALL_CHILDRENS),  \
	$(eval $(call CHILDREN_RULES,$(_children),,values-prod.yaml,)))
$(foreach _children, $(ALL_CHILDRENS),  \
	$(eval $(call CHILDREN_RULES,$(_children),test-,values-test.yaml,--namespace test)))
