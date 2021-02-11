##### DEFINING THE REGION  #####
##### NOT RELEVANT FOR IAM #####

provider "aws" {
  region = "eu-central-1"
}

##### CREATING THE GROUPS #####

resource "aws_iam_group" "trainers" {
  name = "Trainers"
}

resource "aws_iam_group" "students" {
  name = "Students"
}

##### CREATING A STUDENT POLICY FOR S3 #####

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
            "Resource": "${aws_s3_bucket.bootcamp_bucket.arn}"
        }
    ]
}
EOF
}

##### ADDING DEFAULT POLICIES TO THE GROUPS #####

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

##### CREATING THE TRAINER USERS #####

resource "aws_iam_user" "trainer" {
  for_each = toset(var.trainer_users)
  name     = each.value
}

##### CREATING THE STUDENT USERS #####

resource "aws_iam_user" "student" {
  for_each = toset(var.student_users)
  name     = each.value
}

##### ADDING USERS TO THEIR GROUPS #####

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

##### S3 BUCKET #####

resource "aws_s3_bucket" "bootcamp_bucket" {
  bucket = "bootcamp-2021-aws-s3-bucket"

  acl    = "private"

# Policies can be added in s3policies.json. Uncomment the line below 
# to apply them.

# policy = file("s3_bucket_policy.json")

# Allow deletion of non-empty bucket. Comment it out if not needed.
  force_destroy = true

  versioning {
    enabled = true
  }
}

##### S3 BUCKET INTO BACKEND #####

#terraform {
#  backend "s3" {
#    bucket = aws_s3_bucket.bootcamp_bucket.bucket
#    key    = "/key/"
#    region = "eu-central-1"
#  }
#}

