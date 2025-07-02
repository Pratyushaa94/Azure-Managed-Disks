# Azure Managed Disks Terraform Deployment

This repository contains Terraform code and a GitHub Actions workflow to deploy Azure Managed Disks resources.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed locally (for manual runs)
- An Azure subscription
- Service Principal credentials with sufficient permissions
- GitHub repository secrets configured:
  - `AZURE_CREDENTIALS`: JSON output from `az ad sp create-for-rbac --sdk-auth`

## Files

- `main.tf`: Main Terraform configuration for Azure resources
- `variables.tf`: Input variables for the deployment
- `output.tf`: Output values from the deployment
- `providers.tf`: Provider configuration (Azure)
- `terraform.tfvars`: Variable values
- `.github/workflows/deploy.yml`: GitHub Actions workflow for CI/CD

## Usage

### 1. Configure Secrets

Add your Azure credentials as a secret named `AZURE_CREDENTIALS` in your GitHub repository.

### 2. Workflow

On every push to the `main` branch or on pull requests, the workflow will:

- Checkout the code
- Set up Terraform
- Log in to Azure
- Run `terraform init` and `terraform plan`
- On push to `main`, run `terraform apply`

### 3. Manual Deployment

To deploy manually:

```powershell
terraform init
terraform plan
terraform apply
```

## What are Azure Managed Disks?

Azure Managed Disks are storage drives provided by Microsoft Azure that you can use with virtual machines. They work like hard drives in the cloud. Azure takes care of managing these disks for you, so you don’t have to worry about storage accounts or hardware.

You can choose different types of disks based on your needs (for example, faster or cheaper). Managed Disks are reliable, secure, and easy to use for storing data in Azure.