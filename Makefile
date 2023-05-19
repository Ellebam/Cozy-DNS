include .env

.PHONY: install-go run-playbooks clean \
provision-local provision-aws provision-azure provision-gcp provision-vsphere

export SERVER_IP ROOT_PASSWORD USERNAME USER_PASSWORD \
PUBLIC_KEY PROVIDER KEY_PAIR VPC_ID SUBNET_ID SECURITY_GROUP_ID \
AWS_ACCESS_KEY AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN \
ARM_SUBSCRIPTION_ID ARM_CLIENT_ID ARM_CLIENT_SECRET ARM_TENANT_ID \
GOOGLE_CREDENTIALS GOOGLE_PROJECT GOOGLE_REGION

install-go:
	# Write the steps needed to install Golang if it is not already installed on your system.
	# This might vary depending on your operating system.

run-playbooks:
	# Convert your ansible playbooks to Go script or Shell script.

provision-local: 
	docker-compose -f containers/docker-compose.yml up -d

provision-aws:
	cd terraform/aws && terraform init && terraform apply -auto-approve

provision-azure:
	cd terraform/azure && terraform init && terraform apply -auto-approve

provision-gcp:
	cd terraform/gcp && terraform init && terraform apply -auto-approve

provision-vsphere:
	cd terraform/vsphere && terraform init && terraform apply -auto-approve

provision: provision-$(PROVIDER)

clean:
	docker-compose -f containers/docker-compose.yml down
	rm -rf terraform/*/terraform.tfstate*
	rm -rf terraform/*/terraform.tfstate.backup
	rm -rf terraform/*/terraform.tfstate.d
	echo "Cleaned up Docker containers and Terraform files."
