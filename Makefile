new_iam_token:
	yc iam create-token

tf-init:
	terraform -chdir=./terraform/ init

tf-init-migrate-state:
	terraform -chdir=./terraform/ init -migrate-state

tf-reconfigure:
	terraform -chdir=./terraform/ init -reconfigure

tf-validate:
	terraform -chdir=./terraform/ validate

tf-format:
	terraform -chdir=./terraform/ fmt

tf-plan:
	terraform -chdir=./terraform/ plan

tf-apply:
	terraform -chdir=./terraform/ apply

tf-destroy:
	terraform -chdir=./terraform/ destroy

deploy:
	ansible-playbook ansible/playbook.yml -i ansible/inventory.ini --vault-password-file vault-password-file -vv
