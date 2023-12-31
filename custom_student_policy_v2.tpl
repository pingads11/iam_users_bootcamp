{
    "Version": "2012-10-17",
    "Statement": [
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
            "Sid": "AllowToDescribeAll",
            "Effect": "Allow",
            "Action": [
                "appmesh:Describe*",
                "backup:Describe*",
                "acm:Describe*",
                "cloudfront:Describe*",
                "cloudtrail:Describe*",
                "cloudwatch:Describe*",
                "events:Describe*",
                "logs:Describe*",
                "codebuild:Describe*",
                "codecommit:Describe*",
                "cognito-identity:Describe*",
                "cognito-idp:Describe*",
                "comprehend:Describe*",
                "config:Describe*",
                "directconnect:Describe*",
                "dms:Describe*",
                "dynamodb:Describe*",
                "ec2:Describe*",
                "elasticfilesystem:Describe*",
                "elasticbeanstalk:Describe*",
                "ecs:Describe*",
                "elasticache:Describe*",
                "elasticloadbalancing:Describe*",
                "elasticmapreduce:Describe*",
                "firehose:Describe*",
                "fsx:Describe*",
                "iotanalytics:Describe*",
                "iotevents:Describe*",
                "kinesisanalytics:Describe*",
                "kms:Describe*",
                "rds:Describe*",
                "redshift:Describe*",
                "s3:Describe*",
                "sagemaker:Describe*",
                "secretsmanager:Describe*",
                "states:Describe*",
                "storagegateway:Describe*",
                "ssm:Describe*",
                "workspaces:Describe*",
                "autoscaling:Describe*",
                "s3:ListAllMyBuckets",
                "lambda:GetAccountSettings",
                "lambda:ListEventSourceMappings",
                "lambda:ListFunctions",
                "lambda:ListTags",
                "iam:ListRoles",
                "cloudformation:Describe*"
            ],
            "Resource": "*"
        },
        {
            "Sid": "NetworkModule",
            "Effect": "Allow",
            "Action": [
                "s3:List*",
                "S3:Get*"
            ],
            "Resource": [
                "arn:aws:s3:::bootcamp-materials",
                "arn:aws:s3:::bootcamp-materials/*"
            ]
        },
        {
            "Sid": "BucketAccessAWSAdvanceModule",
            "Effect": "Allow",
            "Action": [
                "s3:List*",
                "s3:DeleteBucket",
                "s3:GetBucketTagging",
                "s3:GetBucketWebsite",
                "s3:Put*",
                "s3:GetAccountPublicAccessBlock",
                "s3:GetBucketPolicy",
                "s3:GetBucketPublicAccessBlock",
                "s3:Delete*",
                "s3:GetBucketAcl",
                "s3:GetObjectAcl",
                "s3:GetObjectVersionAcl",
                "s3:PutBucketAcl",
                "s3:PutObjectAcl",
                "s3:PutObjectVersionAcl",
                "s3:DeleteObjectVersion",
                "s3:GetBucketVersioning",
                "s3:GetObjectVersion"
            ],
            "Resource": [
                "arn:aws:s3:::icp-static-website*",
                "arn:aws:s3:::icp-static-website*/*"
            ]
        },
        {
            "Sid": "LambdaAccessAWSAdvanceModule",
            "Effect": "Allow",
            "Action": [
                "lambda:GetFunction",
                "lambda:GetFunctionConfiguration",
                "lambda:GetFunctionCodeSigningConfig",
                "lambda:GetFunctionConcurrency",
                "iam:GetRole",
                "iam:PassRole",
                "lambda:TagResource",
                "lambda:UpdateFunctionCode",
                "lambda:InvokeFunction",
                "lambda:AddPermission",
                "apigateway:*",
                "cloudwatch:GetMetricData"
            ],
            "Resource": [
                "arn:aws:lambda:*:*:function:icp-user-data*",
                "arn:aws:iam::*:role/UserDataRoleM08",
                "arn:aws:apigateway:*::*"
            ]
        },
        {
            "Sid": "LambdaGetMetrics",
            "Effect": "Allow",
            "Action": [
                "cloudwatch:GetMetricData"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Sid": "ListAllStacksAndStartInstance",
            "Effect": "Allow",
            "Action": [
                "ec2:StopInstances",
                "ec2:StartInstances",
                "cloudformation:ListStacks"
            ],
            "Resource": [
                "arn:aws:ec2:*:*:instance/*",
                "arn:aws:cloudformation:*:*:stack/*/*"
            ]
        },
        {
            "Sid": "AllowActionsNoRestriction",
            "Effect": "Allow",
            "Action": [
                "ec2:RunInstances",
                "ec2:CreateSecurityGroup",
                "ec2:CreateKeyPair",
                "ec2:AuthorizeSecurityGroupIngress",
                "ec2:DeleteSecurityGroup",
                "ec2:DeleteKeyPair",
                "ec2:CreateSnapshot",
                "ec2:DeleteSnapshot",
                "elasticloadbalancing:CreateTargetGroup",
                "elasticloadbalancing:CreateListener",
                "elasticloadbalancing:DeleteTargetGroup",
                "ec2:RegisterImage",
                "ec2:DeregisterImage",
                "elasticloadbalancing:RegisterTargets",
                "autoscaling:UpdateAutoScalingGroup",
                "s3:CreateBucket",
                "s3:PutBucketTagging",
                "lambda:CreateFunction",
                "iam:ListUsers",
                "ec2:ImportKeyPair",
                "cloudformation:EstimateTemplateCost",
                "cloudformation:Get*",
                "cloudformation:GetTemplate",
                "cloudformation:GetTemplateSummary",
                "cloudformation:List*",
                "cloudformation:Detect*",
                "ec2:CreateTags",
                "cloudformation:CreateStack",
                "cloudformation:UpdateStack",
                "ec2:CreateSubnet",
                "ec2:ModifySubnetAttribute",
                "ec2:AssociateRouteTable",
                "ec2:RevokeSecurityGroup*",
                "ec2:AuthorizeSecurityGroup*",
                "ec2:DisassociateRouteTable",
                "ec2:DeleteSubnet",
                "route53:GetHostedZone",
                "route53:ChangeResourceRecordSets",
                "route53:GetChange",
                "route53:Describe*",
                "route53:Get*",
                "route53:List*"
            ],
            "Resource": [
                "arn:aws:ec2:*::image/*",
                "arn:aws:ec2:*::snapshot/*",
                "arn:aws:ec2:*:*:route-table/*",
                "arn:aws:ec2:*:*:subnet/*",
                "arn:aws:ec2:*:*:network-interface/*",
                "arn:aws:ec2:*:*:security-group/*",
                "arn:aws:ec2:*:*:key-pair/*",
                "arn:aws:ec2:*:*:vpc/*",
                "arn:aws:elasticloadbalancing:*:*:targetgroup/*",
                "arn:aws:elasticloadbalancing:*:*:loadbalancer/*",
                "arn:aws:ec2:*:*:volume/*",
                "arn:aws:ec2:*::snapshot/*",
                "arn:aws:ec2:*::image/*",
                "arn:aws:ec2:*:*:launch-template/*",
                "arn:aws:autoscaling:*:*:autoScalingGroup:*:autoScalingGroupName/*",
                "arn:aws:s3:::icp-static-website*",
                "arn:aws:lambda:*:*:function:*",
                "arn:aws:iam::*:user/",
                "arn:aws:cloudformation:*:*:stack/student*",
                "arn:aws:route53:::*"
            ]
        },
        {
            "Sid": "AllowActionsWithRestrictions",
            "Effect": "Allow",
            "Action": [
                "ec2:*",
                "ec2:StartInstances",
                "elasticloadbalancing:*",
                "autoscaling:*",
                "s3:*"
            ],
            "Resource": [
                "*",
                "arn:aws:s3:::icp-static-website*"
            ],
            "Condition": {
                "StringEquals": {
                    "aws:RequestTag/project": "bootcamp",
                    "aws:RequestTag/department": "ICP"
                }
            }
        },
        {
            "Sid": "AllowTerminateInstancesWithRestrictions",
            "Effect": "Allow",
            "Action": [
                "ec2:Terminate*",
                "elasticloadbalancing:DeleteLoadBalancer",
                "ec2:DeleteLaunchTemplate",
                "autoscaling:DeleteAutoScalingGroup",
                "cloudformation:DeleteStack",
                "ec2:DeleteSubnet"
            ],
            "Resource": [
                "*"
            ],
            "Condition": {
                "StringEquals": {
                    "aws:ResourceTag/project": "bootcamp",
                    "aws:ResourceTag/department": "ICP"
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
                "iam:GetUser",
                "iam:ListAccessKeys",
                "iam:CreateAccessKey",
                "iam:UpdateAccessKey",
                "iam:DeleteAccessKey"
            ],
            "Resource": "arn:aws:iam::*:user/$${aws:username}"
        },
        {
            "Effect": "Allow",
            "Action": [
                "cloudformation:GetTemplateSummary"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:CreateUser"
            ],
            "Resource": "arn:aws:iam::789857956406:user/ses-smtp-user*"
        }
    ]
}
