# homelab environment

This is where all the `homelab` environment specific code resides. Here we have our bootstrap.sh script, Ansible playbook, cluster CRDs, workloads, and ArgoCD apps. 

The ArgoCD apps use an "app of apps" approach where we have one application that then creates all other workload applications.  This has the benefit of making applications automatically get provisioned when committed to the repo so everything is nicely tracked in git.


