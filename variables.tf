#######################
##### BUCKET NAME #####
#######################

variable "bucket_name" {
  type = string
  default = "bootcamp-april2021-aws-s3-bucket"
}

#########################
##### DYNAMODB NAME #####
#########################

### If the name below is changed, make sure to change it also
### in the remote s3 backend block in main.tf

variable "dynamodb_name" {
  type = string
  default = "terraform-state-locking"
}

############################
##### KEYBASE USERNAME #####
############################

### Make sure to update the field after "keybase:-----"
### with your own username.

variable "keybase_username" {
  type = string
  default = "keybase:deekaay"
}

#################
##### USERS #####
#################

variable "trainer_users" {
  type = list(string)
  default = ["Shahid", "Darina", "Gatis", "Ieva", "Andris", "Janis", "Emmanuel", "Ernest", "Richards", "Abuharis"] 
}

variable "student_users" {
  type = list(string)
  default = ["Antons_S", "Alina_V", "Marats_S", "Angelina_S", "Vadim_S", "Anna_S", "Martins_T", "Asnate_M", "Arturs_Z", "Anfisa_T", "Konstantinos_M", "Ksenija_G", "Sami_U", "Zane_G", "Jevgenijs_L", "Aleksandra_H"]
}

####################
##### POLICIES #####
####################

variable "trainer_policies" {
  type = list(string)
  default = ["arn:aws:iam::aws:policy/AdministratorAccess"]
}

variable "student_policies" {
  type = list(string)
  default = ["arn:aws:iam::aws:policy/AmazonVPCFullAccess", "arn:aws:iam::aws:policy/AmazonEC2FullAccess", "arn:aws:iam::aws:policy/AWSCloudFormationFullAccess"]
}

##################
##### VPC ID #####
##################

variable "main_vpc_id" {
  type = string
  default = "vpc-022d40f0a4dc4bb61"
}

################
##### TAGS #####
################

variable "tags" {
  type = map
  default = {
    department = "ICP",
    project = "bootcamp"
  }
}

