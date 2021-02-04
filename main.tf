##### DEFINING THE REGION #####

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

##### CREATING THE USERS #####

resource "aws_iam_user" "user1" {
    name = "user1"
}

resource "aws_iam_user" "user2" {
    name = "user2"
}

##### ADDING USERS TO THE GROUPS #####

resource "aws_iam_group_membership" "trainers-users" {
    name = "trainers-users"
    users = [aws_iam_user.user1.name]
    group = aws_iam_group.trainers.name
}

resource "aws_iam_group_membership" "students-users" {
    name = "students-users"
    users = [aws_iam_user.user2.name]
    group = aws_iam_group.students.name
}


