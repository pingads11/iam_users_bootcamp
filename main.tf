################################
#####   REMOTE S3 BACKEND  #####
################################

### Only uncomment this block when you have deployed all the
### resources successfully and have the terraform.tfstate locally.

# terraform {
#  backend "s3" {

### Variables are not allowed in this block. Make sure to update
### the bucket and dynamodb table names below if changed.

 #   bucket = "tfstate-bootcamp-bucket"
 #   dynamodb_table = "terraform-state-locking"

 #   key = "terraform/terraform.tfstate"
 #   region = "eu-central-1"
 #   encrypt = true
 # }
# }

##############################
##### TERRAFORM VERSION  #####
##############################

terraform {
  required_version = ">= 0.14.5"
}

################################
##### DEFINING THE REGION  #####
################################

provider "aws" {
  region  = "eu-central-1"
  access_key = "AKIAWI4EI2WZ6GA6JCMW"
  secret_key = "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"
}

########################################
##### CALLING STATE BUCKET MODULE  #####
########################################

module "state_bucket" {
  source = "./modules/s3bucket"

### A default name is already defined, if you want to use a different one,
### add it below and uncomment the line.

#  bucket = ""
}

####################################
##### ACCOUNT PASSWORD POLICY  #####
####################################

### This is to enable the option for users to change their passwords
### after the first login. The other password requirements need to be 
### set as well (as desired).

### WARNING: This modifies the password policy on the root account!

resource "aws_iam_account_password_policy" "strict" {
  minimum_password_length        = 8
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = true
  require_symbols                = true
  allow_users_to_change_password = true
}

###############################
##### CREATING THE GROUPS #####
###############################

resource "aws_iam_group" "trainers" {
  name = "Trainers"
}

resource "aws_iam_group" "students" {
  name = "Students2"
}

############################################
##### CREATING A STUDENT POLICY FOR S3 #####
############################################

data "template_file" "custom_student_policy" {
  template = file("./custom_student_policy_v2.tpl")
  vars = {
    bootcamp_bucket_name = var.bucket_name
    state_bucket_name = module.state_bucket.bucket_name
    vpc_id = var.main_vpc_id
  }
}

resource "aws_iam_policy" "custom_student_policy" {
  name = "Custom_Student_Policy"
  description = "A custom policy for specific student Allow/Deny actions."

  policy = data.template_file.custom_student_policy.rendered

### "tags" argument unsupported? Customer managed policies still have tags on the console...

#  tags = var.tags
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

 
resource "aws_iam_group_policy_attachment" "student_group_custom_attach" {
  group = aws_iam_group.students.name
  policy_arn = aws_iam_policy.custom_student_policy.arn
} 

##################################################
##### CREATING THE TRAINER AND STUDENT USERS #####
##################################################

resource "aws_iam_user" "trainer" {
  for_each = toset(var.trainer_users)
  name     = each.value
  tags     = var.tags
}

resource "aws_iam_user" "student" {
  for_each = toset(var.student_users)
  name     = each.value
  tags     = var.tags
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

#resource "aws_s3_bucket" "bootcamp_bucket" {

### If you change the name below, updated it also in the first block
### named terraform backend "s3"

 # bucket = var.bucket_name

 # acl    = "private"

 #  tags   = var.tags

### The argument below prevents the bucket to be accidentally destroyed
### by "terraform destroy". This will avoid losing the terraform.tfstate file
### stored as backend in the S3 bucket. Comment it out if you want to
### destroy the bucket.

#  lifecycle {
#    prevent_destroy = true
#  }

### The argument below should be commented out by default. If you want to
### destroy the bucket, uncomment it. It will delete all the files
### inside it in an unrecoverable manner!

#  force_destroy = true

### Policies can be added in the s3_bucket_policy.json file
### in case you want to allow other AWS accounts to have access to it
### Uncomment the line below to apply them.

# policy = file("s3_bucket_policy.json")

 # versioning {
 #   enabled = true
 # }

#  server_side_encryption_configuration {
#    rule {
 #     apply_server_side_encryption_by_default {
 #       sse_algorithm = "AES256"
 #     }
 #   }
 # }
# }

#######################################
##### CREATING THE DYNAMODB TABLE #####
#######################################

resource "aws_dynamodb_table" "terraform_locks" {

### If you change the name below, updated it also in the first block
### named terraform backend "s3"

  name = var.dynamodb_name

  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  
  attribute {
    name = "LockID"
    type = "S"
  }
}

################################
##### IAM USER ACCESS KEYS #####
################################

resource "aws_iam_access_key" "trainer_keys" {
  for_each = toset(var.trainer_users)
  user    = aws_iam_user.trainer[each.value].name

  pgp_key = var.keybase_username
}

resource "aws_iam_access_key" "student_keys" {
  for_each = toset(var.student_users)
  user    = aws_iam_user.student[each.value].name

  pgp_key = var.keybase_username
}

###################################
##### IAM USER LOGIN PROFILES #####
###################################

resource "aws_iam_user_login_profile" "trainer_logins" {
  for_each = toset(var.trainer_users)
  user    = aws_iam_user.trainer[each.value].name

  pgp_key = var.keybase_username
}

resource "aws_iam_user_login_profile" "student_logins" {
  for_each = toset(var.student_users)
  user    = aws_iam_user.student[each.value].name

  pgp_key = var.keybase_username
}

