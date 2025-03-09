# terraform-snowflake

This repository contains Terraform configurations to manage Snowflake infrastructure as code.

## Prerequisites

Ensure the following dependencies are installed before proceeding:

1. **Snowflake Account**

   - A valid Snowflake account with appropriate privileges.
   - An `ACCOUNTADMIN` or equivalent role to create resources.

2. **Terraform Installed**

   - Download and install Terraform from [terraform.io](https://developer.hashicorp.com/terraform/downloads).
   - Verify installation:
     ```bash
     terraform version
     ```

3. **Git Installed**

   - Download and install Git from [git-scm.com](https://git-scm.com/).

## Local Environment Setup

### 1. Clone the Repository

```bash
git clone https://github.com/shourabhmodak/terraform-snowflake.git
cd terraform-snowflake
```

### 2. Generate RSA Key Pair for Snowflake Service Account for TerraformAuthentication

Run the following command in Git Bash to generate the private key without encryption:

```bash
openssl genrsa 2048 | openssl pkcs8 -topk8 -inform PEM -out ~/.ssh/svc_tf_key.p8 -nocrypt
```

Generate the public key by referencing the private key from previous step:

```bash
openssl rsa -in ~/.ssh/svc_tf_key.p8 -pubout -out ~/.ssh/svc_tf_key.pub
```

### 3. Create Snowflake Service Account User using the key-pair authentication

Copy the public key content in PEM format, in between the `---BEGIN` and `---END` and use in place of `YOUR_PUBLIC_KEY_CONTENT` in next step.
```bash
-----BEGIN PUBLIC KEY-----
MIIBIj...
-----END PUBLIC KEY-----
```


Log into Snowflake and execute:

```sql
USE ROLE ACCOUNTADMIN;

CREATE OR REPLACE USER SVC_TERRAFORM
rsa_public_key = "YOUR_PUBLIC_KEY_CONTENT"
default_role = PUBLIC
must_change_password = FALSE;

ALTER USER SVC_TERRAFORM SET RSA_PUBLIC_KEY='YOUR_PUBLIC_KEY_CONTENT';
```

### 4. Configure Terraform Variables

Create a `terraform.tfvars` file with your Snowflake credentials:

```hcl
snowflake_organisation = "your-organisation"
snowflake_account      = "your-account"
snowflake_user         = "your-username"
```


## Execution

### 1. Initialize Terraform

```bash
terraform init
```

### 2. Plan the Infrastructure Changes

```bash
terraform plan
```

This will show the resources that will be created in Snowflake.

### 3. Apply the Configuration

```bash
terraform apply -auto-approve
```

This will create the specified Snowflake infrastructure.

## Cleanup

To remove all resources created by Terraform:

```bash
terraform destroy -auto-approve
```

## Notes

- You could consider using a remote Terraform backend (e.g. AWS S3) for state management.
- Make sure `*.tfvars` is included in `.gitignore` to avoid sensitive information getting commited into source code repository.


