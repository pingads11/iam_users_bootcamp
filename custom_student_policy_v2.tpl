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
                "s3:GetBucketPublicAccessBlock"
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
                "apigateway:*"
            ],
            "Resource": [
                "arn:aws:lambda:*:*:function:icp-user-data*",
                "arn:aws:iam::*:role/userDataRole",
                "arn:aws:apigateway:*::*"
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
                "ec2:CreateTags"
            ],
            "Resource": [
                "arn:aws:ec2:*::image/*",
                "arn:aws:ec2:*::snapshot/*",
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
                "arn:aws:cloudformation:*:*:stack/student*"
            ]
        },
        {
            "Sid": "AllowActionsWithRestrictions",
            "Effect": "Allow",
            "Action": [
                "ec2:*",
                "elasticloadbalancing:*",
                "autoscaling:*",
                "s3:*",
                "cloudformation:CreateStack",
                "cloudformation:UpdateStack"
            ],
            "Resource": [
                "*",
                "arn:aws:s3:::icp-static-website*"
            ],
            "Condition": {
                "StringEquals": {
                    "aws:RequestTag/project": "Bootcamp",
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
                "cloudformation:DeleteStack"
            ],
            "Resource": [
                "*"
            ],
            "Condition": {
                "StringEquals": {
                    "aws:ResourceTag/project": "Bootcamp",
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
            "Resource": "arn:aws:iam::*:user/${aws:username}"
        },
        {
            "Effect": "Allow",
            "Action": [
                "cloudformation:GetTemplateSummary"
            ],
            "Resource": "*"
        }
    ]
}