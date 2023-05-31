# IaC 

This repository is meant to serve as an example of some technology I've worked on in the past. 

This is currently a work in progress. The infrastructure created here will also be used by `larntz/ssm-sync` to demonstrate some GitHub Actions workflows. 


## Current Setup

- [x] Ansible playbook to deploy/update k3s running in a HA deployment on 3 Raspberry Pi's.
- [x] Terraform to create IAM resources and SystemMananger parameters (secrets) that will be pulled into the cluster by external-secrets.
- [x] A [`bootstrap.sh`](envs/homelab/scripts) script to deploy our initial applications (argocd, cert-manager, and external-secrets). 
- [x] ArgoCD 
- [x] cert-manager
- [x] external-secrets 
- [x] GitHub actions runner controller and a runner deployment attached to the `larntz/ssm-sync` repository.

## Remaining TODO

- [ ] Prometheus and Grafana
- [ ] GitHub Actions workflows for `ssm-sync`. 
- [ ] Do some more development on `ssm-sync` to make it more usable and demonstrate CICD workflows.
