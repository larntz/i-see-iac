#!/bin/bash 
#
set -euo pipefail

# create required secrets for initial workloads
ENVIRONMENT="homelab"
export AWS_REGION="us-east-2"

SOURCE_DIR=$(dirname "${BASH_SOURCE[0]}")

#
# crds
# 
kubectl apply -k "$SOURCE_DIR/../crds"

# actions runner crds need to be applied using --server-side 
# see: https://github.com/actions/actions-runner-controller/issues/2565
kubectl apply --server-side -k "$SOURCE_DIR/../../../bases/actions-runner-controller/crds"

# 
# argocd
#
kubectl apply -k "$SOURCE_DIR/../../../envs/homelab/workloads/argocd/"

# 
# cert-manager
#
kubectl apply -k "$SOURCE_DIR/../../../envs/homelab/workloads/cert-manager/"

CM_ACCESS_KEY=$(aws ssm get-parameter --name "/${ENVIRONMENT}/cert-manager/access-key-id" --profile "$ENVIRONMENT"| jq -r .Parameter.Value)
CM_SECRET_ACCESS_KEY=$(aws ssm get-parameter --name "/${ENVIRONMENT}/cert-manager/secret-access-key"  --profile "$ENVIRONMENT" | jq -r .Parameter.Value)

CM_INITIAL_SECRET=$(cat <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: aws-credentials
data:
  access-key-id: "$(echo -n "$CM_ACCESS_KEY" | base64 -w0)"
  secret-access-key: "$(echo -n "$CM_SECRET_ACCESS_KEY" | base64 -w0)"
EOF
)

echo "$CM_INITIAL_SECRET" | kubectl apply -n cert-manager -f-


#
# external-secrets
#
kubectl apply -k "$SOURCE_DIR/../../../envs/homelab/workloads/external-secrets"

ESO_ACCESS_KEY=$(aws ssm get-parameter --name "/${ENVIRONMENT}/external-secrets/access-key-id" --profile "$ENVIRONMENT"| jq -r .Parameter.Value)
ESO_SECRET_ACCESS_KEY=$(aws ssm get-parameter --name "/${ENVIRONMENT}/external-secrets/secret-access-key"  --profile "$ENVIRONMENT" | jq -r .Parameter.Value)

ESO_INITIAL_SECRET=$(cat <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: aws-credentials
data:
  access-key-id: "$(echo -n "$ESO_ACCESS_KEY" | base64 -w0)"
  secret-access-key: "$(echo -n "$ESO_SECRET_ACCESS_KEY" | base64 -w0)"
EOF
)

echo "$ESO_INITIAL_SECRET" | kubectl apply -n external-secrets -f-

#
# bootstrap that apps
#
kubectl apply -k "$SOURCE_DIR/../../../envs/homelab/apps"

