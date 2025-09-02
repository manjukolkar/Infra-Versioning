# Infra Versioning Project 🚀

This repo demonstrates **Infrastructure as Code (IaC)** using **Terraform + Git + Jenkins**.

### What It Does
- Provisions an **S3 bucket**
- Provisions an **EC2 instance**
- Stores Terraform state in **S3 with DynamoDB locking**
- CI/CD pipeline using **Jenkins**

### Setup
1. Create backend infra (only once):
   ```bash
   aws s3 mb s3://infra-versioning-state-bucket --region us-east-1
   aws dynamodb create-table        --table-name terraform-locks        --attribute-definitions AttributeName=LockID,AttributeType=S        --key-schema AttributeName=LockID,KeyType=HASH        --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1        --region us-east-1
   ```

2. Install **Terraform** and **AWS CLI** on Jenkins EC2.

3. Configure Jenkins pipeline with:
   - SCM: GitHub → https://github.com/manjukolkar/Infra-Versioning.git
   - Branch: `main`
   - Script Path: `Jenkinsfile`

4. Run pipeline → Approve deployment → Infra is created.

### Rollback
- Checkout an older Git commit.
- Re-run Jenkins pipeline.
- Terraform syncs infra back to that version.
