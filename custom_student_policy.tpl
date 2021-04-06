{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "s3:ListAllMyBuckets",
          "s3:ListBucket",
          "s3:CreateBucket",
          "s3:GetAccountPublicAccessBlock",
          "s3:GetBucketPublicAccessBlock",
          "s3:GetBucketLocation",
          "s3:GetBucketPolicyStatus",
          "s3:GetBucketAcl",
          "s3:ListAccessPoints"
        ],
        "Resource": [
          "arn:aws:s3:::*"
        ]
      },
      {
        "Effect": "Allow",
        "Action": [
          "s3:GetObject",
          "s3:PutObject",
          "s3:GetObjectVersion"
        ],
        "Resource": [
          "arn:aws:s3:::${bootcamp_bucket_name}"
        ]
      },
      {
        "Effect": "Deny",
        "Action": [
          "s3:ListBucket"
        ],
        "Resource": [
          "arn:aws:s3:::${state_bucket_name}"
        ]
      },
      {
         "Sid": "DenyExpensiveRegions",
         "Effect": "Deny",
         "NotAction": [
           "cloudfront:*",
           "iam:*",
           "route53:*",
           "support:*"
         ],
         "Resource": "*",
         "Condition": {
           "StringNotEquals": {
             "aws:RequestedRegion": [
               "eu-central-1"
             ]
           }
         }
       },
       {
         "Sid": "VisualEditor0",
         "Effect": "Allow",
         "Action": [
           "iam:GetUserPolicy",
           "iam:ListGroupsForUser",
           "iam:ListAttachedUserPolicies",
           "iam:ListUserPolicies",
           "iam:GetUser"
         ],
         "Resource": "arn:aws:iam::*:user/$${aws:username}"
       },
       {
         "Sid": "VisualEditor1",
         "Effect": "Allow",
         "Action": [
           "iam:ListPolicies",
           "iam:GetPolicyVersion",
           "iam:GetPolicy",
           "iam:ListPolicyVersions",
           "iam:ListGroupPolicies",
           "iam:ListUsers",
           "iam:ListAttachedGroupPolicies",
           "iam:GetGroupPolicy"
          ],
          "Resource": "*"
        },
	{
          "Sid": "VisualEditor3",
          "Effect": "Allow",
          "Action": [
            "iam:DeleteAccessKey",
            "iam:UpdateAccessKey",
            "iam:CreateAccessKey",
            "iam:ListAccessKeys"
          ],
          "Resource": "arn:aws:iam::*:user/$${aws:username}"
        },
	{
          "Sid": "ReadOnlyEC2WithNonResource",
          "Action": [
            "ec2:Describe*",
            "iam:ListInstanceProfiles"
          ],
          "Effect": "Allow",
          "Resource": "*"
        },
        {
          "Sid": "ModifyingEC2WithNonResource",
          "Action": [
            "ec2:CreateKeyPair",
            "ec2:CreateSecurityGroup",
            "ec2:AllocateAddress",
            "ec2:AssociateAddress",
            "ec2:DisassociateAddress",
            "ec2:AssignPrivateIpAddresses",
            "ec2:UnassignPrivateIpAddresses",
            "ec2:AssociateSubnetCidrBlock",
            "ec2:DisassociateSubnetCidrBlock",
            "ec2:CreateSubnet",
            "ec2:CreateDefaultSubnet",
            "ec2:ModifySubnetAttribute",
            "ec2:DeleteSubnet"
          ],
          "Effect": "Allow",
          "Resource": "*"
        },
        {
          "Sid": "EC2InstanceConnectWithTagRestrictions",
          "Effect": "Allow",
          "Action": [
            "ec2-instance-connect:SendSSHPublicKey"
          ],
          "Resource": "*",
          "Condition": {
            "StringLike": {
              "aws:RequestTag/project": "bootcamp"
            }
          }
        },
        {
          "Sid": "EC2RunInstancesVpcSubnet",
          "Effect": "Allow",
          "Action": "ec2:RunInstances",
          "Resource": "arn:aws:ec2:eu-central-1:*:subnet/*",
          "Condition": {
            "StringEquals": {
              "ec2:Vpc": "arn:aws:ec2:eu-central-1:*:vpc/${vpc_id}"
            }
          }
        },
        {
          "Sid": "EC2VpcNonResourceSpecificActions",
          "Effect": "Allow",
          "Action": [
            "ec2:DeleteNetworkAcl",
            "ec2:DeleteNetworkAclEntry",
            "ec2:DeleteRoute",
            "ec2:DeleteRouteTable",
            "ec2:ReleaseAddress",
            "ec2:AuthorizeSecurityGroupEgress",
            "ec2:AuthorizeSecurityGroupIngress",
            "ec2:RevokeSecurityGroupEgress",
            "ec2:RevokeSecurityGroupIngress",
            "ec2:DeleteSecurityGroup",
            "ec2:CreateNetworkInterfacePermission",
            "ec2:CreateRoute",
            "ec2:UpdateSecurityGroupRuleDescriptionsEgress",
            "ec2:UpdateSecurityGroupRuleDescriptionsIngress"
          ],
          "Resource": "*",
          "Condition": {
            "StringEquals": {
              "ec2:Vpc": "arn:aws:ec2:eu-central-1:*:vpc/${vpc_id}"
            }
          }
        },
        {
          "Sid": "AllowInstanceActionsTagBased",
          "Effect": "Allow",
          "Action": [
            "ec2:RebootInstances",
            "ec2:StopInstances",
            "ec2:TerminateInstances",
            "ec2:StartInstances",
            "ec2:AttachVolume",
            "ec2:DetachVolume",
            "ec2:AssociateIamInstanceProfile",
            "ec2:DisassociateIamInstanceProfile",
            "ec2:GetConsoleScreenshot",
            "ec2:ReplaceIamInstanceProfileAssociation"
          ],
          "Resource": [
            "arn:aws:ec2:eu-central-1:*:instance/*",
            "arn:aws:ec2:eu-central-1:*:volume/*"
          ],
          "Condition": {
            "StringLike": {
              "ec2:ResourceTag/project": "bootcamp"
            }
          }
        },
        {
          "Sid": "AllowCreateTags",
          "Effect": "Allow",
          "Action": [
            "ec2:CreateTags"
          ],
          "Resource": "*"
        }
    ]
}
