# terraform

This is a basic example of Terraform to create AWS resources that will be used in-cluster. 

I've made some trade-offs here to keep things simple and make them work in a cluster that lives outside AWS and keep the bill as low as possible. 

First, I am using IAM users and security keys instead of roles. In a production cluster running on AWS I would use IRSA and roles exclusively. Using IRSA is a security best practice. 

Second, I'm using SSM string parameters for secrets because they are totally free. Using encrypted parameters would be better, but there you are paying for certificates and API calls. Using AWS Secrets Manager, or something similar, would be a best case scenario. 

Finally, this should be setup to run in an automated workflow, but I am limited to one on-prem cluster. Some options for automation here would be using GitHub Actions runners configured to run in AWS with permission to create/modify these resources, or something similar to [Atlantis](https://www.runatlantis.io/). 
