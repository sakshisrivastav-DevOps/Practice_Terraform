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

#########################

## Create EC2 Instance using Terraform

```bash
# Create Terraform file
vim terraform_for_devops/ec2.tf

# Generate SSH key pair
ssh-keygen   # give name: deployer-key

# Go to public key file
cd deployer-key.pub

# Copy the public key or copy the pwd path for security purpose and add it into ec2.tf

# Validate Terraform configuration
terraform validate

# Apply configuration to create EC2 instance
terraform apply

## AWS CLI Multi-Profile Configuration

```bash
# Navigate to AWS directory
cd ~/.aws/

# List files
ls

# View config file
cat config

# Edit config file
vim config
```

```
[default]         # default profile

[dev]             # second profile (dev environment)
```

```bash
# Edit credentials file
vim credentials
```

```
[default]
aws_access_key_id = <your_default_access_key>        # access key for default profile
aws_secret_access_key = <your_default_secret_key>    # secret key for default profile

[dev]
aws_access_key_id = <your_dev_access_key>            # access key for dev profile
aws_secret_access_key = <your_dev_secret_key>        # secret key for dev profile
```

```bash
# Login using specific profile
aws login --profile dev   # login using dev profile
```

# Notes

- `default` → used when no profile is specified  
- `dev` → custom profile for separate environment  
- Copy the login link → paste in browser → authenticate  
- Useful for managing multiple AWS accounts or environments  
