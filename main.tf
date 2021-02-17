################################
#####   REMOTE S3 BACKEND  #####
################################

### Only uncomment this block when you have deployed all the
### resources successfully and have the terraform.tfstate locally.

terraform {
  backend "s3" {

### Variables are not allowed in this block. Make sure to update
### the bucket and dynamodb table names below if changed.

    bucket = "bootcamp-2021-aws-s3-bucket"
    dynamodb_table = "terraform-state-locking"

    key = "terraform/terraform.tfstate"
    region = "eu-central-1"
    encrypt = true
  }
}

################################
##### DEFINING THE REGION  #####
################################

provider "aws" {
  region = "eu-central-1"
}

###############################
##### CREATING THE GROUPS #####
###############################

resource "aws_iam_group" "trainers" {
  name = "Trainers"
}

resource "aws_iam_group" "students" {
  name = "Students"
}

############################################
##### CREATING A STUDENT POLICY FOR S3 #####
############################################

resource "aws_iam_policy" "student_s3_policy" {
  name = "Student_S3_Policy"
  description = "A policy allowing Create, Get, and Put actions on S3 buckets without the Delete action."
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListAllMyBuckets",
                "s3:CreateBucket",
                "s3:ListBucket",
                "s3:GetBucketLocation",
                "s3:GetObject",
                "s3:PutObject",
                "s3:GetObjectVersion",
                "s3:GetBucketPolicy",
                "s3:PutBucketPolicy",
                "s3:GetBucketAcl"
            ],
            "Resource": [
                "arn:aws:s3:::*"
            ]
        }
    ]
}
EOF
}

#################################################
##### ADDING DEFAULT POLICIES TO THE GROUPS #####
#################################################

resource "aws_iam_group_policy_attachment" "trainer_group_attach" {
  for_each = toset(var.trainer_policies)
  group = aws_iam_group.trainers.name
  policy_arn = each.value
}

resource "aws_iam_group_policy_attachment" "student_group_attach" {
  for_each = toset(var.student_policies)
  group = aws_iam_group.students.name
  policy_arn = each.value
}

resource "aws_iam_group_policy_attachment" "student_group_s3_attach" {
  group = aws_iam_group.students.name
  policy_arn = aws_iam_policy.student_s3_policy.arn
}
##################################################
##### CREATING THE TRAINER AND STUDENT USERS #####
##################################################

resource "aws_iam_user" "trainer" {
  for_each = toset(var.trainer_users)
  name     = each.value
}

resource "aws_iam_user" "student" {
  for_each = toset(var.student_users)
  name     = each.value
}

########################################
##### ADDING USERS TO THEIR GROUPS #####
########################################

resource "aws_iam_user_group_membership" "trainers_membership" {
  for_each = toset(var.trainer_users)
  user = aws_iam_user.trainer[each.value].name
  groups = [aws_iam_group.trainers.name]
}

resource "aws_iam_user_group_membership" "students_membership" {
  for_each = toset(var.student_users)
  user = aws_iam_user.student[each.value].name
  groups = [aws_iam_group.students.name]
}

##################################
##### CREATING THE S3 BUCKET #####
##################################

resource "aws_s3_bucket" "bootcamp_bucket" {

### If you change the name below, updated it also in the first block
### named terraform backend "s3"

  bucket = "bootcamp-2021-aws-s3-bucket"

  acl    = "private"

### The bracket below prevents the bucket to be accidentally destroyed 
### by "terraform destroy". This will avoid losing the terraform.tfstate file
### stored as backend in the S3 bucket. If needed, destroy manually.

  lifecycle {
    prevent_destroy = true
  }

### Policies can be added in the s3_bucket_policy.json file.
### Uncomment the line below to apply them.

# policy = file("s3_bucket_policy.json")

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

#######################################
##### CREATING THE DYNAMODB TABLE #####
#######################################

resource "aws_dynamodb_table" "terraform_locks" {

### If you change the name below, updated it also in the first block
### named terraform backend "s3"

  name = "terraform-state-locking"

  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  
  attribute {
    name = "LockID"
    type = "S"
  }
}

###################################
##### IAM USER LOGIN PROFILES #####
###################################

resource "aws_iam_user_login_profile" "trainer_logins" {
  for_each = toset(var.trainer_users)
  user    = aws_iam_user.trainer[each.value].name

### Change the username below to match your Keybase profile

  pgp_key = "keybase:idrisscharai"
}

resource "aws_iam_user_login_profile" "student_logins" {
  for_each = toset(var.student_users)
  user    = aws_iam_user.student[each.value].name

### Change the username below to match your Keybase profile

  pgp_key = "keybase:idrisscharai"
}

