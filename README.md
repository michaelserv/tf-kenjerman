## Summary

This repo will create a create your custom EKS environment.

## Basic Architecture

![Design](.github/img/tf-tf-kenjerman-milestone-1.png)

## Built with:

* Terraform (v1.0.4)
* AWS_ACCESS_KEYS and AWS_SECRET_ACCESS_KEYS are set as environment variables (link: https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

### Step by Step deployment
* **Step 1: Clone the Repo**. This command will clone the repo and will change directory the recently cloned repo
```shell script
$ git clone https://github.com/antonio-rufo/tf-kenjerman.git
```

* **Step 2: Create a S3 bucket for remote state storage.** Update the `terraform.tfvars` file with your region and account id.
```shell script
$ cd tf-kenjerman
$ cd statebucket
$ vi terraform.tfvars
```
Create the resources:
```shell script
$ terraform init
$ terraform plan
$ terraform apply --auto-approve
```
Take note of the output for `state_bucket_id` and `state_bucket_region`. You'll need to update the `main.tf` on each layer with these values. It is not yet possible to have the state bucket values interpolated.

* **Step 3: Create custom VPC environment.** Update the `terraform.tfvars` file with your inputs. Then update `main.tf` with the **state_bucket_id** created in step 2 as well as the **state_bucket_region**.
```shell script
$ cd ../layers/000base
$ vi terraform.tfvars
$ vi main.tf
```
Create the resources:
```shell script
$ terraform init
$ terraform plan
$ terraform apply --auto-approve
```

* **Step 4: Create your compute resources (Bastion).** Update the `terraform.tfvars` file with your inputs. Then update `main.tf` with the **state_bucket_id** created in step 2 as well as the **state_bucket_region**.
```shell script
$ cd ../layers/200compute
$ vi terraform.tfvars
$ vi main.tf
```
Create the resources:
```shell script
$ terraform init
$ terraform plan
$ terraform apply --auto-approve
```
