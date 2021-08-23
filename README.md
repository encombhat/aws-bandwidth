# aws-bandwidth

A terraform script that spawns 100 EC2 instances to test AWS's bandwidth pricing.

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
