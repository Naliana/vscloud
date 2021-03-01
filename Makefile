.PHONY: help provision

help:
	@echo help text goes here

provision:
	cd terraform && terraform init && terraform apply -auto-approve
install:
	scripts/install.sh
