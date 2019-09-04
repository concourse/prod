CREDHUB_URL		?= credhub.wings.pivotal.io
DEPLOYMENT_MANIFEST	?=

deploy-%:
	rm -rf secrets.yml

	lpass show "Shared-Concourse/concourse-credhub-uaa" --notes > secrets.yml

	bosh -e prod deploy -d $* \
	-o ~/workspace/prod-temp/wings/ops-uaa-credhub.yml \
	-l ~/workspace/prod-temp/secrets.yml \
	-v credhub_uaa_hostname=$(CREDHUB_URL) \
	$(DEPLOYMENT_MANIFEST)
