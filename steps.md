## Terraform Workflow (Example)

```bash
vim main.tf   # Create or edit Terraform configuration file inside terraform_for_devOps folder

terraform init   # Initialize Terraform (downloads providers and sets up working directory)

terraform plan   # Preview changes before applying

terraform apply  # Apply changes and create resources

ls   # List files to verify resource creation (e.g., firstfile.txt)

terraform destroy   # Destroy all resources (e.g., deletes firstfile.txt)

###########################################################
now to create the s3 bucket in aws, we would need aws cli to install(git bash)

# Install aws cli using below official site and command

https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip # if error here, sudo apt install unzip
sudo ./aws/install

aws --version

In AWS, create an IAM User, attach s3full access create user
create access key, cli -->create access key


now in cli run below command

aws configure
give access and sceret key and hit enter enter
aws s3 ls
now see the s3_bucket.tf

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket

terraform init
terraform plan
terraform apply

aws s3 ls## Terraform Destroy Target (Specific Resource)

```bash
terraform destroy -target=local_file.<resource_name>


> **Note:**
> S3 bucket names must be **globally unique across all AWS accounts**.  
> If you get an error like *"bucket name already exists"*, it means the name is already taken by someone else.  
> Use a unique naming pattern (e.g., add project name, environment, or random suffix).

