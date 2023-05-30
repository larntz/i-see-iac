# Notes

I'm using IAM users because this environment runs locally and not in AWS so IRSA or kube2iam won't work. In a production environment running on AWS I'd use IAM roles and IRSA. 

## Rotating IAM Access Keys

Access keys can be rotated using `terraform apply -var="environment=homelab" -replace='module.users.aws_iam_access_key.access_key["external-secrets"]'`.  This works because the external secrets operator will automatically recreate the secrets holding the access keys.  There may be some delay here. The best approach would be to do the following: 1) rotate the access keys, 2) annotation associated external secrets to force an immediate update, 3) Trigger a deployment pod restarts or another method if available to have the application use the new access keys. Given this is not production that should be acceptable. If not we'd probably want two sets of access keys that can be rotated independently of each other so we don't cause any 400 errors.

