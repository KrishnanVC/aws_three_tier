# AWS three tier architecture

An highly available AWS three tier architecture using Terraform for IaC and GitHub actions for CI/CD

## Installation Steps:
1) [Install Terraform](https://developer.hashicorp.com/terraform/install)
2) [Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
3) [Configure the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)
## Run Terraform:
Intialize the project:<br><br>
```bash
terraform init
```

Check the plan:<br><br>
```bash
terraform plan -var="myip=<ip_range_from_which_the_application_must_be_accessible>" -var="username=<database_username>" -var="password=<database_password>"
```

Apply the plan:
```bash
terraform apply -var="myip=<ip_range_from_which_the_application_must_be_accessible>" -var="username=<database_username>" -var="password=<database_password>"
```
