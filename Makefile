.PHONY: help provision install destroy

help:
	@echo help text goes here

provision:
	cd terraform && terraform init && terraform apply -auto-approve
install:
	scripts/install.sh
destroy:
	cd terraform && terraform destroy -auto-approve
