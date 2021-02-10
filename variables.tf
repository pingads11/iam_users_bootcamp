##### USERS #####

variable "trainer_users" {
  type = list(string)
  default = ["Sabir", "Darina", "Shahid"] 
}

variable "student_users" {
  type = list(string)
  default = ["Umar", "Janis_K", "Janis_R", "Idriss", "Agnese"]
}

##### POLICIES #####

variable "trainer_policies" {
  type = list(string)
  default = ["arn:aws:iam::aws:policy/AmazonVPCFullAccess", "arn:aws:iam::aws:policy/AmazonEC2FullAccess", "arn:aws:iam::aws:policy/AWSCloudFormationFullAccess"]
}

variable "student_policies" {
  type = list(string)
  default = ["arn:aws:iam::aws:policy/AmazonVPCFullAccess", "arn:aws:iam::aws:policy/AmazonEC2FullAccess", "arn:aws:iam::aws:policy/AWSCloudFormationFullAccess"]
}
