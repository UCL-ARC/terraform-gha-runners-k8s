SHELL := /bin/bash
.PHONY: *

define terraform-apply
	. init.sh $$ \
    echo "Running: terraform apply on $(1)" && \
    cd $(1) && \
	terraform init -upgrade && \
	terraform validate && \
	terraform apply --auto-approve
endef

define terraform-destroy
	. init.sh $$ \
    echo "Running: terraform destroy on $(1)" && \
    cd $(1) && \
	terraform apply -destroy --auto-approve
endef

ec2-k3s:
	$(call terraform-apply, ./ec2-k3s)

ec2-k3s-destroy:
	$(call terraform-destroy, ./ec2-k3s)

ec2-k3s-ssh:
	cd ./ec2-k3s && ./ssh.sh

gha-runners:
	$(call terraform-apply, ./gha-runners)

gha-runners-destroy:
	$(call terraform-destroy, ./gha-runners)
