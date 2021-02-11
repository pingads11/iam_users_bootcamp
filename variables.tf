##### USERS #####

variable "trainer_users" {
  type = list(string)
  default = ["Darina", "Emmanuel", "Ieva", "Shahid"] 
}

variable "student_users" {
  type = list(string)
  default = ["Umar", "Janis_K", "Janis_R", "Idriss", "Alija", "Agnese"]
}

##### POLICIES #####

variable "trainer_policies" {
  type = list(string)
  default = ["arn:aws:iam::aws:policy/AdministratorAccess"]
}

variable "student_policies" {
  type = list(string)
  default = ["arn:aws:iam::aws:policy/AmazonVPCFullAccess", "arn:aws:iam::aws:policy/AmazonEC2FullAccess", "arn:aws:iam::aws:policy/AWSCloudFormationFullAccess"]

# S3 Policy is created as JSON code then attached to students in main.tf
# If not needed, you can comment out the resource
# "aws_iam_group_policy_attachment" named "student_group_s3_attach"
}

