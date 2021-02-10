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

##### ADDING A DEFAULT POLICY TO THE GROUPS #####

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

