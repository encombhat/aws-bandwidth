# aws-bandwidth

A terraform script that spawns 100 EC2 instances to test AWS's bandwidth pricing.

**Warning! This script consumes ~1TB bandwidth!**
That is like 100 USD according to AWS.
Don't use this script for fun!

Alternatively, change the total number of instances in `main.tf`.

To initiate, execute

```sh
terraform init
```

Then, add your SSH public key to `ssh_key.pub`,
and your AWS API credentials to `secret.tfvars`.

To start testing, execute

```sh
terraform apply --var-file secret.tfvars
```

To destroy created instances, execute

```sh
terraform destroy --var-file secret.tfvars
```
