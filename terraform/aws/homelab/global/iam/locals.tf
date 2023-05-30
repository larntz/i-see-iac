locals {
  iam_users = [
    {
      name = "cert-manager"
      policy = jsonencode({
        "Version" : "2012-10-17",
        "Statement" : [
          {
            "Effect" : "Allow",
            "Action" : "route53:GetChange",
            "Resource" : "arn:aws:route53:::change/*"
          },
          {
            "Effect" : "Allow",
            "Action" : [
              "route53:ChangeResourceRecordSets",
              "route53:ListResourceRecordSets"
            ],
            "Resource" : "arn:aws:route53:::hostedzone/${data.terraform_remote_state.blue42_route53.outputs.homelab_blue42_zone_id}"
        }]
      })
    },
    {
      name = "external-secrets"
      policy = jsonencode({
        "Version" : "2012-10-17",
        "Statement" : [
          {
            "Effect" : "Allow",
            "Action" : [
              "ssm:GetParameter",
              "ssm:DescribeParameters"
            ],
            "Resource" : "*"
          }
        ]
      })
    }
  ]
}
