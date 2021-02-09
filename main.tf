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

#resource "aws_iam_policy_attachment" "group-policy-attach" {
#    name = "group-policy-attach"
#    groups = ["${aws_iam_group.trainers.name}", "${aws_iam_group.students.name}"]
#    policy_arn = "arn:aws:iam::aws:policy/ADD_POLICY_NAME"
#}

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

resource "aws_iam_group_membership" "trainers_membership" {
    name = "Trainer Memberships"
    for_each = toset(var.trainer_users)
    users = [aws_iam_user.trainer[each.value].name]
    group = aws_iam_group.trainers.name
}

resource "aws_iam_group_membership" "students_membership" {
    name = "Student Memberships"
    for_each = toset(var.student_users)
    users = [aws_iam_user.student[each.value].name]
    group = aws_iam_group.students.name
}

