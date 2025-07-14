#  Azure Managed Disks Deployment using Terraform & GitHub Actions

This project automates the provisioning of **Azure Managed Disks** using **Terraform** and integrates **CI/CD automation** with **GitHub Actions**. It simplifies infrastructure as code, remote deployment, and cost analysis.

---

##  Project Structure

```
Azure-Managed-Disks/
├── main.tf                   # Terraform resources (Managed Disks)
├── provider.tf               # Azure provider config
├── variables.tf              # Input variable declarations
├── output.tf                 # Output values from the deployment
├── terraform.tfvars          # Default variable values
├── environments/
│   ├── dev.tfvars            # Dev-specific variables
│   ├── prod.tfvars           # Prod-specific variables
│   └── backend.tf            # Remote backend config
└── .github/
    └── workflows/
        └── deploy.yml        # GitHub Actions CI/CD pipeline
```

---

##  What This Project Does

- Provisions **Azure Managed Disks**
- Stores Terraform state in **Azure Blob Storage**
- Automates `terraform plan` and `terraform apply` using GitHub Actions
- Runs **Infracost** to generate cost estimates
- Uses **GitHub Environments** for manual apply approvals

---

## Azure Credentials Setup

Generate credentials using:

```bash
az ad sp create-for-rbac   --name "ServicePrincipal-ManagedDisks"   --role Contributor   --scopes /subscriptions/$(az account show --query id -o tsv)   --sdk-auth
```

Copy the JSON output and store it in GitHub Secrets as:

```
AZURE_CREDENTIALS
```

---

##  GitHub Secrets Required

| Secret Name         | Description                                  |
|---------------------|----------------------------------------------|
| `AZURE_CREDENTIALS` | Azure SP credentials (JSON output above)     |
| `INFRACOST_API_KEY` | Infracost API key for cost estimation         |

---

##  Remote State Backend

Defined in `environments/backend.tf`:

| Property           | Value                   |
|--------------------|--------------------------|
| Storage Account    | `prathyushastateacct`    |
| Container          | `tfstate`                |
| State File Name    | `manageddisks.tfstate`   |

---

##  GitHub Actions Workflow

### Trigger: On push to `main` or PR

**Pipeline Steps:**

1. Checkout code
2. Set up Terraform
3. Authenticate with Azure via `AZURE_CREDENTIALS`
4. Create backend if it doesn't exist
5. Run `terraform init` and `terraform plan`
6. Generate Infracost report and upload artifacts
7. On `main` branch: wait for manual approval via Environments
8. Run `terraform apply` after approval

---

##  Collaborators & Manual Approvals

1. Go to **GitHub → Settings → Collaborators** → Add your team members
2. Go to **GitHub → Settings → Environments** → Create a new environment: `dev-approval`
3. Add reviewers to the environment → ensures manual approval before apply

---

##  How to Use

### 1. Prerequisites

- Terraform installed
- Azure CLI with `az login`
- Azure subscription
- GitHub secrets added (`AZURE_CREDENTIALS`, `INFRACOST_API_KEY`)

---

### 2. Clone the Repo

```bash
git clone https://github.com/Pratyushaa94/Azure-Managed-Disks.git
cd Azure-Managed-Disks
```

---

### 3. Set Your Variables

Edit `terraform.tfvars` or `environments/dev.tfvars`:

```hcl
resource_group_name = "rg-managed-disks"
location            = "East US"
disk_name           = "my-managed-disk"
disk_size_gb        = 128
disk_sku            = "Premium_LRS"
```

> Ensure disk name is lowercase, alphanumeric, and unique in the resource group.

---

### 4. Push to GitHub

```bash
git checkout -b feature/managed-disks
git add .
git commit -m "Add Terraform for Azure Managed Disks"
git push -u origin feature/managed-disks
```

GitHub Actions will now:

 Validate credentials  
 Ensure backend exists  
 Run plan and Infracost  
Await approval  
 Apply infrastructure

---

##  Infracost Integration

- Generates cost report during each plan
- Report saved as `infracost-report.txt`
- Requires `INFRACOST_API_KEY` secret

---

##  What Are Azure Managed Disks?

Azure Managed Disks are cloud-based storage volumes used with Azure VMs.

- Azure handles replication, availability, and scalability
- Supports different tiers: Standard, Premium, Ultra
- Ideal for storing OS disks, data disks, or backups
- Easily attached to or detached from VMs

---

##  Use Cases

- Persistent storage for Azure Virtual Machines
- Scalable block storage for apps and DBs
- Backup and disaster recovery targets

---
