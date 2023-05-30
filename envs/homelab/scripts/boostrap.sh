#!/bin/bash 
#
set -euo pipefail

# create required secrets for initial workloads
ENVIRONMENT="homelab"
export AWS_REGION="us-east-2"

SOURCE_DIR=$(dirname "${BASH_SOURCE[0]}")

ACCESS_KEY=$(aws ssm get-parameter --name "/${ENVIRONMENT}/external-secrets/access-key-id" --profile "$ENVIRONMENT"| jq -r .Parameter.Value)
SECRET_ACCESS_KEY=$(aws ssm get-parameter --name "/${ENVIRONMENT}/external-secrets/secret-access-key"  --profile "$ENVIRONMENT" | jq -r .Parameter.Value)

ESO_INITIAL_SECRET=$(cat <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: eso-awsssm-secret
data:
  access-key: "$(echo -n "$ACCESS_KEY" | base64 -w0)"
  secret-access-key: "$(echo -n "$SECRET_ACCESS_KEY" | base64 -w0)"
EOF
)

echo "$ESO_INITIAL_SECRET" | kubectl apply -n external-secrets -f-

# create workloads
kubectl apply -k "$SOURCE_DIR/../workloads/argocd"
kubectl apply -k "$SOURCE_DIR/../workloads/external-secrets"
