#########################
##### AWS IAM USERS #####
#########################

output "trainer_users" {
  value = values(aws_iam_user.trainer)[*].id
}

output "student_users" {
  value = values(aws_iam_user.student)[*].id
}

################################
##### USER LOGIN PASSWORDS #####
################################

output "trainer_passwords" {
  value = values(aws_iam_user_login_profile.trainer_logins)[*].encrypted_password
}

output "student_passwords" {
  value = values(aws_iam_user_login_profile.student_logins)[*].encrypted_password
}

##########################
##### ACCESS KEY IDS #####
##########################

output "trainer_key_id" {
  value = values(aws_iam_access_key.trainer_keys)[*].id
}

output "student_key_id" {
  value = values(aws_iam_access_key.student_keys)[*].id
}

##############################
##### ACCESS KEY SECRETS #####
##############################

output "trainer_key_secret" {
  value = values(aws_iam_access_key.trainer_keys)[*].encrypted_secret
}

output "student_key_secret" {
  value = values(aws_iam_access_key.student_keys)[*].encrypted_secret
}
