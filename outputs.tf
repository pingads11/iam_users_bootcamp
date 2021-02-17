output "trainer_users" {
  value = aws_iam_user.trainer
}

output "student_users" {
  value = aws_iam_user.student
}

output "trainer_passwords" {
  value = values(aws_iam_user_login_profile.trainer_logins)[*].encrypted_password
}

output "student_passwords" {
  value = values(aws_iam_user_login_profile.student_logins)[*].encrypted_password
}


