CREDHUB_URL		?= credhub.wings.pivotal.io
DEPLOYMENT_MANIFEST	?=
PROD_PATH		?= $(shell pwd)

deploy-%:
	rm -rf secrets.yml

	lpass show "Shared-Concourse/concourse-credhub-uaa" --notes > secrets.yml

	bosh -e prod deploy -d $* \
	-o $(PROD_PATH)/wings/ops-uaa-credhub.yml \
	-l $(PROD_PATH)/secrets.yml \
	-v credhub_uaa_hostname=$(CREDHUB_URL) \
	$(DEPLOYMENT_MANIFEST)
